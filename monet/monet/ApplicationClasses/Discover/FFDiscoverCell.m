//
//  FFDiscoverCell.m
//  MonetBlockchain
//
//  Created by Rain on 17/12/08.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFDiscoverCell.h"

@interface FFDiscoverCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *detailLab;

@property (nonatomic, strong) UIImageView *arrowView;

@end

@implementation FFDiscoverCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *cellID = NSStringFromClass([self class]);
    FFDiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    return cell?cell:[[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupContentView];
        [self setBackgroundColor:FFBackColor];
    }
    return self;
}

- (void)setupContentView {
    _bgView = [[UIView alloc] initWithFrame:DDYRect(15, 15, DDYSCREENW-30, 80)];
    DDYBorderRadius(_bgView, 8, 0, DDY_ClearColor);
    
    _iconView = [[UIImageView alloc] initWithFrame:DDYRect(15, 0, 35, _bgView.ddy_h)];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    
    _titleLab = [self labelWithFont:DDYFont(19)];
    
    _detailLab = [self labelWithFont:DDYFont(15)];
    
    _arrowView = [[UIImageView alloc] initWithFrame:DDYRect(_bgView.ddy_w-12-14, _bgView.ddy_h/2.0-9, 14, 18)];
    _arrowView.image = [UIImage imageNamed:@"back_white"];
    
    [self.contentView addSubview:_bgView];
    [_bgView addSubview:_iconView];
    [_bgView addSubview:_titleLab];
    [_bgView addSubview:_detailLab];
    [_bgView addSubview:_arrowView];
}

#pragma mark 生成label
- (UILabel *)labelWithFont:(UIFont *)font {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = DDY_White;
    label.font = font;
    return label;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconView.mas_right).offset(12);
        make.right.mas_equalTo(_arrowView.mas_left).offset(-12);
        make.top.mas_equalTo(_bgView.mas_top).offset(15);
        make.height.mas_equalTo(20);
    }];
    
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconView.mas_right).offset(12);
        make.right.mas_equalTo(_arrowView.mas_left).offset(-12);
        make.top.mas_equalTo(_titleLab.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
}


- (void)loadData:(NSDictionary *)dict {
    _iconView.image = [UIImage imageNamed:dict[@"img"]];
    _titleLab.text = DDYLocalStr(dict[@"title"]);
    _detailLab.text = DDYLocalStr(dict[@"detail"]);
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    if ([dict[@"row"] isEqualToString:@"0_0"]) {
        gradientLayer.colors = @[(__bridge id)DDYRGBA(110, 220, 210, 1).CGColor,
                                 (__bridge id)DDYRGBA(75, 193, 247, 1).CGColor];
    } else {
        gradientLayer.colors = @[(__bridge id)DDYRGBA(249, 215, 108, 1).CGColor,
                                 (__bridge id)DDYRGBA(249, 168, 119, 1).CGColor];
    }
    gradientLayer.locations = @[@0.3, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0.4, 1);
    gradientLayer.frame = _bgView.bounds;
    [_bgView.layer insertSublayer:gradientLayer atIndex:0];
    
}

@end
