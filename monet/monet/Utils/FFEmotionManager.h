//
//  FFEmotionManager.h
//  MonetBlockchain
//
//  Created by Rain on 17/12/07.
//  Copyright © 2017年 MonetBlockchain Foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFEmotionManager : NSObject

+ (NSArray *)emojiEmotion;

+ (NSArray *)customEmotion;

+ (NSArray *)gifEmotion;

+ (NSMutableAttributedString *)transferMessageString:(NSString *)message
                                                font:(UIFont *)font
                                          lineHeight:(CGFloat)lineHeight;

@end
