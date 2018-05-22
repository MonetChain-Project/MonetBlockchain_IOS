//
//  FFMessageTipCell.m
//  MonetBlockchain
//
//  Created by Rain on 17/12/04.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFMessageTipCell.h"

@interface FFMessageTipCell ()<TTTAttributedLabelDelegate>

@property (nonatomic, strong) TTTAttributedLabel *tipLabel;

@end

@implementation FFMessageTipCell

- (TTTAttributedLabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        _tipLabel.linkAttributes = @{NSForegroundColorAttributeName:DDY_Blue};
        _tipLabel.font = ChatTimeFont;
        _tipLabel.textColor = DDY_White;
        _tipLabel.delegate = self;
        _tipLabel.numberOfLines = 0;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
        _tipLabel.linkBackgroundEdgeInset = UIEdgeInsetsMake(0, 5, 0, 5);
        _tipLabel.textInsets = UIEdgeInsetsMake(2, 0, 0, 0);
        _tipLabel.backgroundColor = DDYRGBA(190, 190, 190, 1);
        DDYBorderRadius(_tipLabel, 4, 0, DDY_ClearColor);
    }
    return _tipLabel;
}

- (void)setupContentView {
    [super setupContentView];
    [self setBackgroundColor:DDY_ClearColor];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView addSubview:self.tipLabel];
}

- (void)setCellModel:(FFMessageCellModel *)cellModel {
    _tipLabel.frame = cellModel.tipLabelFrame;
    _tipLabel.ddy_centerX = DDYSCREENW/2.0;
    NSRange range = [cellModel.message.textContent rangeOfString:@"www.baidu.com" options:NSBackwardsSearch];
    
    self.tipLabel.text = cellModel.message.textContent;
    [self.tipLabel addLinkToURL:[NSURL URLWithString:@"www.baidu.com"] withRange:range];
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url{
    DDYInfoLog(@"%@",url.absoluteString);
}

@end
