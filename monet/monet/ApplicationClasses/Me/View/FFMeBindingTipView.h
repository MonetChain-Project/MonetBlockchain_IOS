//
//  FFMeBindingTipView.h
//  MonetBlockchain
//
//  Created by Rain on 17/9/20.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import <UIKit/UIKit.h>

#define FFMeTipHight 60.0

@interface FFMeBindingTipView : UIView

@property (nonatomic, strong) void (^closeBlock)();

@property (nonatomic, strong) void (^bindingBlock)();

+ (instancetype)tipView;

@end
