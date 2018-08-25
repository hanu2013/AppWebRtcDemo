//
//  SignalConnectionManagement.m
//  AppWebRTC
//
//  Created by Nguyen Kim Ngoc on 8/25/18.
//  Copyright © 2018 MOCHA. All rights reserved.
//

#import "SignalConnectionManagement.h"

@implementation SignalConnectionManagement

+ (id) sharedInstance
{
    static SignalConnectionManagement *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SignalConnectionManagement alloc] init];
    });
    
    return instance;
}

- (id) init
{
    self = [super init];
    
    if (!self.xmppStream) {
        self.xmppStream = [[XMPPStream alloc] init];
    }
//#if TARGET_IPHONE_SIMULATOR
//    self.xmppStream.myJID = [XMPPJID jidWithString:@"user02@localhost/abc"];
//#else
//    self.xmppStream.myJID = [XMPPJID jidWithString:@"user01@localhost/abc"];
//#endif
    self.xmppStream.hostName = @"125.235.13.148";
    self.xmppStream.hostPort = 5222;
    
    [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    self.xmppPing = [[XMPPPing alloc] initWithDispatchQueue:dispatch_get_main_queue()];
    self.xmppPing.respondsToQueries = NO;
    [self.xmppPing activate: self.xmppStream];
    
    self.xmppAutoPing = [[XMPPAutoPing alloc] initWithDispatchQueue:dispatch_get_main_queue()];
    
    [self.xmppAutoPing setPingTimeout: 10];
    [self.xmppAutoPing setPingInterval:12];
    [self.xmppAutoPing activate:self.xmppStream];
    
    //    self.xmppAutoPing
    self.xmppReconnect = [[XMPPReconnect alloc] initWithDispatchQueue:dispatch_get_main_queue()];
    [self.xmppReconnect setReconnectDelay:5];
    [self.xmppReconnect setReconnectTimerInterval:5];
    [self.xmppReconnect setAutoReconnect:TRUE];
    [self.xmppReconnect activate:self.xmppStream];
    
//    NSError *error;
//    [self.xmppStream connectWithTimeout:50 error: &error];
    
    return self;
}

- (void) connect: (XMPPJID*) jid
{
    self.xmppStream.myJID = jid;
    NSError *error;
    [self.xmppStream connectWithTimeout:50 error: &error];
    
    if(error) {
        NSLog(@"Loi khi login: %@", [error description]);
    }
}
@end
