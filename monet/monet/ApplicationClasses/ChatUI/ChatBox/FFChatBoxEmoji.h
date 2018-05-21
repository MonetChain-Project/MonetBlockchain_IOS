//
//  FFChatBoxEmoji.h
//  MonetBlockchain
//
//  Created by Rain on 17/11/16.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFChatBoxEmoji : UIView

/** 选中的表情 */
@property (nonatomic, copy) void (^selectEmojiBlock)(NSString *emoji);
/** 删除回调 */
@property (nonatomic, copy) void (^deleteBlock)();

+ (instancetype)emojiBox;

@end
