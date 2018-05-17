
//
//  FFTabBar.m
//  MonetBlockchain
//
//  Created by RainDou on 18/1/16.
//  Copyright © 2015年 RainDou All rights reserved.
//

#import "FFTabBar.h"

@interface FFTabBar ()

@property (nonatomic, weak) UIButton *plusBtn;

@end

@implementation FFTabBar

@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        // 设置整个tabbar背景
        [self setBackgroundImage:[UIImage imageWithColor:FF_MAIN_COLOR size:CGSizeMake(DDYSCREENW, 49)]];
        // 去除tabar顶部线条
        [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(DDYSCREENW, 1)]];
        
        //为tabbar添加按钮
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        DDYBorderRadius(plusBtn, 66/2.0, 6, FF_MAIN_COLOR);
        
        [plusBtn setBackgroundImage:[UIImage imageWithColor:DDYRGBA(255, 20, 20, 1.0) size:CGSizeMake(66, 66)] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageWithColor:DDYRGBA(135, 27, 21, 1.0) size:CGSizeMake(66, 66)] forState:UIControlStateHighlighted];
        plusBtn.ddy_size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}

#pragma mark - 点击事件
- (void)plusBtnTouch:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(tabBarDidPlusBtn:)]) {
        [self.delegate tabBarDidPlusBtn:self];
    }
}

#pragma mark - 重写layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置加号位置
    self.plusBtn.ddy_centerX = self.ddy_w * 0.5;
    self.plusBtn.ddy_centerY = self.ddy_h * 0.5;
    self.plusBtn.ddy_centerY = self.ddy_h * 0.5 - 10.0;
    
    // 设置其它button的位置
    CGFloat tabBarBtnW = self.ddy_w / 5;
    CGFloat tabBarBtnIndex = 0;
    for (int i = 0; i < self.subviews.count; i++) {
        UIView *child = self.subviews[i];
        // 由于UITabBarButton是私有的，所以不能直接用
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.ddy_w = tabBarBtnW;
            child.ddy_x = tabBarBtnW * tabBarBtnIndex;
            tabBarBtnIndex ++;
            if (tabBarBtnIndex == 2) {
                tabBarBtnIndex ++;
            }
        }
    }
}

@end
