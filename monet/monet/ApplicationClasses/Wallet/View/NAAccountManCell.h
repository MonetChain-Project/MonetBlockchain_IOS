//
//  NAAccountCell.h
//  MonetBlockchain
//
//  Created by Rain on 17/9/11.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.

#import <UIKit/UIKit.h>
#import "Wallet.h"

@interface NAAccountManCell : UITableViewCell

@property (nonatomic, readonly) Wallet *wallet;
@property (nonatomic, strong)  Address *address;

@end
