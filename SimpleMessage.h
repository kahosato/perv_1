#ifndef SIMPLE_MESSAGE_H
#define SIMPLE_MESSAGE_H

typedef nx_struct SimpleMsg {
    nx_uint16_t nodeid;
} SimpleMsg;

enum {
    AM_MESSAGEC = 6,
};
#endif
