//
//  NAUserModel.m
//  MonetBlockchain
//
//  Created by Rain on 15/9/11.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.

#import "NAUserModel.h"

@implementation NAUserModel

- (id)initWithAddress:(NSString *)u_address tip:(NSString *)u_tip
{
    if (self = [super init])
    {
        self.u_address = u_address;
        self.u_tip = u_tip;
    }
    return self;
}

@end
