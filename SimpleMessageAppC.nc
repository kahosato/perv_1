configuration SimpleMessageAppC
{
}
implementation
{
    components MainC;
    components SimpleMessageC as App;
    components ActiveMessageC;
    components new TimerMilliC() as Timer0;
    components new AMSenderC(AM_MESSAGEC);
    components new AMReceiverC(AM_MESSAGEC);
    App -> MainC.Boot;
    App.AMPacket -> AMSenderC;
    App.AMSend -> AMSenderC;
    App.Receive -> AMReceiverC;
    App.AMControl -> ActiveMessageC;
    App.Timer0 -> Timer0;
}
