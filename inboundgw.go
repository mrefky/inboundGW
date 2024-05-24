package main

import (
	"strconv"

	"flag"
	"fmt"
	"path"
	_ "strings"
	"syscall"
	"time"
	"github.com/quickfixgo/field"
	"github.com/quickfixgo/quickfix"
	"github.com/quickfixgo/tag"
	fix44er "github.com/quickfixgo/fix44/reject"
	_ "encoding/json"
	"log"
	"os"
	"os/signal"
	"github.com/IBM/sarama"
)
var last time.Time  = time.Now()
var current time.Time  = time.Now()
var b time.Duration=0 * time.Millisecond
var ime int=1
var producer = createProducer()
type executor struct {
	*quickfix.MessageRouter
}

func Reject(msg *quickfix.Message, sis quickfix.SessionID){
seq,_:=msg.Header.GetInt(tag.MsgSeqNum)
Ric:= fix44er.New(field.NewRefSeqNum(seq))
//fmt.Println("Rejected")
Ric.SetText("Message Rate Exceeded")
quickfix.SendToTarget(Ric,sis)
}




func newExecutor() *executor {
	e := &executor{MessageRouter: quickfix.NewMessageRouter()}

	return e
}






func (e executor) OnCreate(sessionID quickfix.SessionID)                           {
log.Println(" Session ",sessionID," Created")	
}
func (e executor) OnLogon(sessionID quickfix.SessionID)                            {
	log.Println("Session ",sessionID," Logged on")
ime=1
}
func (e executor) OnLogout(sessionID quickfix.SessionID)                           {
	log.Println("Session ",sessionID," Logged out")
	ime=1
}

func (e executor) ToAdmin(msg *quickfix.Message, sessionID quickfix.SessionID)     {}
func (e executor) ToApp(msg *quickfix.Message, sessionID quickfix.SessionID) error { return nil }
func (e executor) FromAdmin(msg *quickfix.Message, sessionID quickfix.SessionID) quickfix.MessageRejectError {return nil}
func (e *executor) FromApp(msg *quickfix.Message, sessionID quickfix.SessionID) (reject quickfix.MessageRejectError) {
//quickfix.SendToTarget(msg,sessionID)
current=time.Now()
d:=current.Sub(last)
//fmt.Println("--------------------")
//fmt.Println(current,last)
//fmt.Println(d,b)
//fmt.Println("--------------------")

if d<=b {
	//fmt.Println(d,b)
	//fmt.Println(d,b," Too Fast Rejected...")
	Reject(msg,sessionID)
	return
	}else{
		type1,_ :=msg.Header.GetString(35) 
	log.Println("--",strconv.Itoa(ime),"-- Message of type \"",type1," \" Pushed to Inbound topic")
	ime=ime+1
	last=time.Now()
}
//fmt.Println("--------------------")
//fmt.Println("")
last=time.Now()

m4:=msg.String()
//tag:=quickfix.Tag(tag.SenderCompID)
//Firm,_:=msg.Header.GetString(tag)
tag := quickfix.Tag(tag.Symbol)
sym, _ := msg.Body.GetString(tag)
producer.Input() <- &sarama.ProducerMessage{
		Topic: "inbound",
		Value: sarama.ByteEncoder(m4),
		Key:   sarama.ByteEncoder(sym),
	}
	return 
}

//func (m *quickfix.Message) MsgType() (string, quickfix.MessageRejectError) {
//	return m.Header.GetString(3)
//}


func main() {

	flag.Parse()

	cfgFileName := path.Join("config", "executor.cfg")
	if flag.NArg() > 0 {
		cfgFileName = flag.Arg(0)
	}

	cfg, err := os.Open(cfgFileName)
	if err != nil {
		fmt.Printf("Error opening %v, %v\n", cfgFileName, err)
		return
	}

	appSettings, err := quickfix.ParseSettings(cfg)
	if err != nil {
		fmt.Println("Error reading cfg,", err)
		return
	}

	logFactory, _ := quickfix.NewFileLogFactory(appSettings)
	app := newExecutor()

	acceptor, err := quickfix.NewAcceptor(app, quickfix.NewMemoryStoreFactory(), appSettings, logFactory)
	if err != nil {
		fmt.Printf("Unable to create Acceptor: %s\n", err)
		return
	}

	err = acceptor.Start()
	if err != nil {
		fmt.Printf("Unable to start Acceptor: %s\n", err)
		return
	}

	interrupt := make(chan os.Signal, 1)
	signal.Notify(interrupt, os.Interrupt, syscall.SIGTERM)
	<-interrupt

	acceptor.Stop()
}
func createProducer() sarama.AsyncProducer {
	config := sarama.NewConfig()
	config.Producer.Return.Successes = false         // fire and forget
	config.Producer.Return.Errors = true             // notify on failed
	config.Producer.RequiredAcks = sarama.WaitForAll // waits for all insync replicas to commit

//	producer, err := sarama.NewAsyncProducer([]string{"192.168.1.70:9094"}, config)
	producer, err := sarama.NewAsyncProducer([]string{"kafka.default.svc.cluster.local:9092"}, config)
		if err != nil {
		log.Fatal("Unable to connect producer to kafka server")
	}

	return producer

}
