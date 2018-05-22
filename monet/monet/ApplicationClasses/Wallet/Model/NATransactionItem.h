//
//  NATransactionItem.h
//  MonetBlockchain
//
//  Created by Rain on 15/9/11.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.

#import <Foundation/Foundation.h>

@interface NATransactionItem : NSObject

@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *dateline;

@end
