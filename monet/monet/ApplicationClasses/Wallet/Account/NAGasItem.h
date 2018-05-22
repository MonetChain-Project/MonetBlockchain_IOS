//
//  NAGasItem.h
//  MonetBlockchain
//
//  Created by Rain on 15/9/11.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.

#import <Foundation/Foundation.h>
#import "NAGasDetailItem.h"

@interface NAGasItem : NSObject

@property (nonatomic, strong) NAGasDetailItem *eth;
@property (nonatomic, strong) NAGasDetailItem *fft;

@end
