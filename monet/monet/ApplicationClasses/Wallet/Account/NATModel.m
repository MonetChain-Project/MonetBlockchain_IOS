//
//  NATModel.m
//  NAToken
//
//  Created by Rain on 17/8/2.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "NATModel.h"

@implementation NATModel

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.imgName = dict[@"imgName"];
        self.title = dict[@"title"];
        self.address = dict[@"address"];
//        self.ethPrice = dict[@"eth"];
//        self.fftPrice = dict[@"fft"];
    }
    return self;
}

@end
