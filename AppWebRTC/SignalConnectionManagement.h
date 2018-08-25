//
//  SignalConnectionManagement.h
//  AppWebRTC
//
//  Created by Nguyen Kim Ngoc on 8/25/18.
//  Copyright © 2018 MOCHA. All rights reserved.
//

#import <Foundation/Foundation.h>

@import XMPPFramework;
@import WebRTC;

@interface SignalConnectionManagement : NSObject
@property (nonatomic, strong) XMPPStream *xmppStream;
@property (nonatomic, strong) XMPPAutoPing *xmppAutoPing;
@property (nonatomic, strong) XMPPPing *xmppPing;
@property (nonatomic, strong) XMPPReconnect *xmppReconnect;

+ (id) sharedInstance;

- (void) connect: (XMPPJID*) jid;
@end
