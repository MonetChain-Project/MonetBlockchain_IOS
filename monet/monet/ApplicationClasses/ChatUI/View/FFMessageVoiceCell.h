//
//  FFMessageVoiceCell.h
//  MonetBlockchain
//
//  Created by Rain on 17/12/04.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFMessageBaseCell.h"

@interface FFMessageVoiceCell : FFMessageBaseCell

@property (nonatomic,copy) void (^playVoiceBlock)();
@property (nonatomic,strong) UIImageView * tip;

//+(FFMessageVoiceCell *) voiceViewWithMessage:(FFMessageCellModel *)message;

@end
