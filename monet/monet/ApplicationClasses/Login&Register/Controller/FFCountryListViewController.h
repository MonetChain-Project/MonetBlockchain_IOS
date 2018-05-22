//
//  FFCountryListViewController.h
//  MonetBlockchain
//
//  Created by Megan on 2017/9/22.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "DDYBaseViewController.h"

@interface FFCountryListViewController : DDYBaseViewController

@property(nonatomic,copy) void (^chooseCountryBlock)(NSString * countryName);

@end
