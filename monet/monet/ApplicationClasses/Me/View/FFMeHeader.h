//
//  FFMeHeader.h
//  MonetBlockchain
//
//  Created by Rain on 17/9/20.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import <UIKit/UIKit.h>

#define FFMeHeaderHight 110.0

@class FFUser;

@interface FFMeHeader : UIView

@property(nonatomic,copy)void (^tatBlock)();

+ (instancetype)headView;

- (void)loadHeaderData:(FFUser *)user;

@end
