#include "SimpleMessage.h"
module SimpleMessageC
{
    uses interface Boot;
    uses interface AMPacket;
    uses interface AMSend;
    uses interface Receive;
    uses interface Timer<TMilli> as Timer0;
    uses interface SplitControl as AMControl;
}
implementation
{
    bool busy = FALSE;
    event void Boot.booted()
    {
        dbg("Boot", "booted");
        call AMControl.start();
    }

    event void AMControl.startDone(error_t err) {
        if (err == SUCCESS) {
            call Timer0.startPeriodic(1000);
        } else {
            call AMControl.start();
        }
    }

    event void Timer0.fired() {
        message_t p;
        SimpleMsg* msg = (SimpleMsg*) (call AMSend.getPayload(&p, sizeof(SimpleMsg)));
        msg->nodeid = TOS_NODE_ID;

        if (call AMSend.send((TOS_NODE_ID+1)%3, &p, sizeof(SimpleMsg)) == SUCCESS) {
            busy = TRUE;
        }
    }

    event void AMSend.sendDone(message_t* msg, error_t err) {
        if (err == SUCCESS) {
            dbg("SimpleMessageC", "Send done from node %d\n", TOS_NODE_ID);
            busy = FALSE;
        } else {
            dbg("SimpleMessageC", "Send failed from node %d\n");
        }
    }

    event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len) {
            SimpleMsg* message = (SimpleMsg*) payload;
            dbg("SimpleMessageC", "Node %d received message from node %d\n", TOS_NODE_ID, message->nodeid);
        if (len == sizeof(SimpleMsg)) {
            SimpleMsg* message = (SimpleMsg*) payload;
            dbg("Receive", "Node %d received message from node %d\n", TOS_NODE_ID, message->nodeid);
        }
        return msg;
    }

    event void AMControl.stopDone(error_t err) {
    }

}
