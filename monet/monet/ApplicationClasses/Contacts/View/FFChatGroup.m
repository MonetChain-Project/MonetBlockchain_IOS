//
//  NAChatGroup.m
//  NextApp
//
//  Created by Megan on  17-12-12.
//  Copyright (c) 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFChatGroup.h"

@implementation FFChatGroup


-(void) setGroupMember:(NSMutableArray *)groupMember
{
    NSMutableArray * source = groupMember;
    
    if ([groupMember isKindOfClass:[NSMutableArray class]]) {
        
    }
    else{
        
        source = [NSMutableArray arrayWithArray:groupMember];
    }
    
    _groupMember = source;
}

@end
