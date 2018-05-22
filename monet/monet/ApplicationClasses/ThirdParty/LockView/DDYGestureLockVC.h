//
//  DDYGestureLockVC.h
//  MonetBlockchain
//
//  Created by Rain on 18/1/26.
//  Copyright © 2018年 MonetBlockchain Foundation All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDYGestureLockVC : DDYBaseViewController

@property (nonatomic, assign) DDYLockViewType lockType;

@property (nonatomic, copy) void (^gestureLockBlock)(BOOL isGesture);

@end
