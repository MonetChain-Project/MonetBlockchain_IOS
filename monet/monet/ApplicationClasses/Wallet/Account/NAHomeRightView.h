//
//  NAHomeRightView.h
//  MonetBlockchain
//
//  Created by Rain on 15/9/11.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.

#import <UIKit/UIKit.h>

@interface NAHomeRightView : UIView

@property (nonatomic, copy) void (^scanQRCodeBlock)(void);
@property (nonatomic, copy) void (^createAccountBlock)(void);

@property (nonatomic, copy) void (^transactionBlock)(void);
@property (nonatomic, copy) void (^accountBlock)(void);

@property (nonatomic, copy) void (^hideBlock)(BOOL changedAccount);

+ (instancetype)rightView;

- (void)showOnSuperView:(UIView *)view;

@end
