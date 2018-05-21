//
//  FFUserListView.h
//  MonetBlockchain
//
//  Created by Rain on 17/9/18.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import <UIKit/UIKit.h>

#define FFUserListViewH 70.0

@interface FFUserListView : UIView

+ (instancetype)listView;

- (void)changeList:(NSMutableArray *)onlineUserArray;

@end
