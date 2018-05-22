//
//  FFUserCardAlertView.h
//  MonetBlockchain
//
//  Created by Rain on 17/12/04.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFUserCardAlertView : UIView

@property(nonatomic,copy)void (^cancelBlock)();
@property(nonatomic,copy)void (^sendBlock)();

-(void)loadUser:(FFUser *)user;

@end
