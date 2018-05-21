//
//  FFCameraView.m
//  MonetBlockchain
//
//  Created by LingTuan on 17/10/11.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFCameraView.h"

@interface FFCameraView ()

/** 返回按钮 */
@property (nonatomic, strong) DDYButton *backBtn;
/** 闪光灯/补光灯按钮 */
@property (nonatomic, strong) DDYButton *flashBtn;
/** 拍照/录制 */
@property (nonatomic, strong) UIButton *takeBtn;
/** 切换前后摄像头按钮 */
@property (nonatomic, strong) DDYButton *toggleBtn;

@end

@implementation FFCameraView

+ (instancetype)cameraView {
    return [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupContentView];
        [self layoutContentView];
    }
    return self;
}

- (void)setupContentView
{
    _backBtn = DDYButtonNew.btnImgNameN(@"back_white").btnSuperView(self).btnAction(self, @selector(handleBack:));
    
    _flashBtn = DDYButtonNew.btnImgNameN(@"back_white").btnSuperView(self).btnAction(self, @selector(handleFlash:));
    
    _takeBtn = DDYButtonNew.btnImgNameN(@"icon_chat_rotate").btnSuperView(self).btnAction(self, @selector(handleTake:));
    [_takeBtn addLongGestureTarget:self action:@selector(handleLangPress:) minDuration:0.5];
    
    _toggleBtn = DDYButtonNew.btnImgNameN(@"icon_chat_rotate").btnSuperView(self).btnAction(self, @selector(handleToggle:));
}

- (void)layoutContentView {
    _backBtn.btnFrame(12, 25, 30, 30);
    _flashBtn.btnFrame(30,DDYSCREENH-65, 30, 30);
    _takeBtn.btnFrame(DDYSCREENW/2.-35, DDYSCREENH-100, 70, 70);
    _toggleBtn.btnFrame(DDYSCREENW-30-30, DDYSCREENH-65, 30, 30);
}

#pragma mark - 事件处理
#pragma mark 返回
- (void)handleBack:(UIButton *)sender {
    //    [[self currentViewController].navigationController popViewControllerAnimated:YES];
    if (self.backBlock) {
        self.backBlock();
    }
}

#pragma mark 切换摄像头
- (void)handleToggle:(UIButton *)sender {
    if (self.toggleBlock) {
        self.toggleBlock();
    }
}

#pragma mark 切换闪光灯模式
- (void)handleFlash:(UIButton *)sender
{
//    if (_cameraType == DDYCameraTypeVideo)
//    {
//        
//    }
//    else
//    {
//        
//    }
}

#pragma mark 拍照
- (void)handleTake:(UIButton *)sender {
    if (self.takeBlock) {
        self.takeBlock();
    }
}

#pragma mark 长按录制与结束
- (void)handleLangPress:(UILongPressGestureRecognizer *)longP
{
    //判断长按时的状态
    if (longP.state == UIGestureRecognizerStateBegan)
    {
        DDYInfoLog(@"开始录制");
        if (self.recordBlock) {
            self.recordBlock(YES);
        }
        
    }
    else if (longP.state == UIGestureRecognizerStateChanged)
    {
        DDYInfoLog(@"录制中");
    }
    else if (longP.state == UIGestureRecognizerStateEnded)
    {
        DDYInfoLog(@"录制结束");
        if (self.recordBlock) {
            self.recordBlock(NO);
        }
    }
}

@end
