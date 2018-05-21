//
//  FFHomeChatsCell.h
//  MonetBlockchain
//
//  Created by Rain on 17/12/11.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFHomeChatsCell : UITableViewCell

@property (nonatomic, strong) FFRecentModel *recentModel;

/** height : 80 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
