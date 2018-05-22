//
//  FFEditGroupNameVC.h
//  MonetBlockchain
//
//  Created by Megan on 2017/12/15.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "DDYBaseViewController.h"

@interface FFEditGroupNameVC : DDYBaseViewController

@property (nonatomic, strong) NSString *groupName;

-(instancetype)initWithChatUID:(NSString *)gid;

@end
