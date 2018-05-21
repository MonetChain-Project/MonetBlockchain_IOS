//
//  FFChatBoxVoice.m
//  MonetBlockchain
//
//  Created by Rain on 17/11/16.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFChatBoxVoice.h"

CGFloat const kBoundsExtension = 12.;   // 更改响应范围
CGFloat const kRecordWH = 120.;         // 录音按钮宽高
CGFloat const kButtonWH = 56.;          // 播放按钮宽高
CGFloat const kMarginLR = 20.;          // 间隔

// 聊天类型
typedef NS_ENUM(NSInteger, FFRecordState) {
    FFRecordStateDefault = 0,       // 默认,正常录音,结束后发送
    FFRecordStatePlay,              // 滑到播放按钮,开始播放
    FFRecordStateDelete,            // 删除,不发送
};

@interface FFChatBoxVoice ()<DDYAudioManagerDelegate>

@property (nonatomic, strong) DDYButton *recordBtn;

@property (nonatomic, strong) DDYButton *playBtn;

@property (nonatomic, strong) DDYButton *deleteBtn;

/** 录制时长 */
@property (nonatomic, assign) NSInteger recordTime;
/** 计时时间 */
@property (nonatomic, assign) NSInteger keepTime;

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, strong) DDYAudioManager *audioManager;

@property (nonatomic, assign) FFRecordState recordState;

@end

@implementation FFChatBoxVoice

+ (instancetype)voiceBox {
    return [[self alloc] initWithFrame:CGRectMake(0, 0, DDYSCREENW, FFChatBoxFunctionViewH)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = FFBackColor;
        [self setupContentView];
        [self setupConfig];
    }
    return self;
}

- (void)setupContentView {
    _recordBtn = ({
        DDYButton *button = [DDYButton customDDYBtn].btnBgColor(FF_MAIN_COLOR).btnSize(kRecordWH, kRecordWH);
        button.showsTouchWhenHighlighted = YES;
        [button addTarget:self action:@selector(startRecord:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(buttonTouchUp:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(buttonTouchUp:withEvent:) forControlEvents:UIControlEventTouchUpOutside];
        [button addTarget:self action:@selector(buttonDrag:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [button addTarget:self action:@selector(buttonDrag:withEvent:) forControlEvents:UIControlEventTouchDragOutside];
        button.btnSuperView(self);
    });
    
    _playBtn = ({
        DDYButton *button = [DDYButton customDDYBtn].btnBgColor(DDY_White).btnSize(kButtonWH, kButtonWH);
        button.hidden = YES;
        button.btnSuperView(self);
    });
    
    _deleteBtn = ({
        DDYButton *button = [DDYButton customDDYBtn].btnBgColor(DDY_White).btnSize(kButtonWH, kButtonWH);
        button.hidden = YES;
        button.btnSuperView(self);
    });
}

- (void)setupConfig {
    _audioManager = [DDYAudioManager sharedManager];
    _audioManager.delegate = self;
}

#pragma mark - 初始化timer
- (void)setupTimer {
    self.recordTime = 0;
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerChange)];
    _displayLink.paused = YES;
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    [self startTimer];
}

#pragma mark - 定时器相关
#pragma mark - 开启定时器
- (void)startTimer {
    _displayLink.paused = NO;
}

#pragma mark - 停止计时器
- (void)stopTimer {
    _displayLink.paused = YES;
    [_displayLink invalidate];
    _displayLink = nil;
}

- (void)timerChange {
    self.recordTime ++;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _recordBtn.center       = CGPointMake(self.ddy_w/2., self.ddy_h/2.);
    _playBtn.ddy_origin     = CGPointMake(kMarginLR, _recordBtn.ddy_y);
    _deleteBtn.ddy_origin   = CGPointMake(self.ddy_w-kMarginLR-kButtonWH, _recordBtn.ddy_y);
    DDYBorderRadius(_recordBtn, _recordBtn.ddy_w/2., 0, DDY_ClearColor);
    DDYBorderRadius(_playBtn,   _playBtn.ddy_w/2.,   1, DDY_Small_Black);
    DDYBorderRadius(_deleteBtn, _deleteBtn.ddy_w/2., 1, DDY_Small_Black);
}

#pragma mark upinside / upoutside
- (void)buttonTouchUp:(DDYButton *)sender withEvent:(UIEvent *)event {
    _playBtn.hidden = YES;
    _deleteBtn.hidden = YES;
    
    CGPoint point = [[[event allTouches] anyObject] locationInView:self];
    if (!CGRectContainsPoint(_playBtn.frame, point) && !CGRectContainsPoint(_deleteBtn.frame, point)) {
        [self performSelectorOnMainThread:@selector(endRecord:) withObject:sender waitUntilDone:NO];
    }
}

#pragma mark dragin / dragout / dragEnter / dragExit
- (void)buttonDrag:(DDYButton *)sender withEvent:(UIEvent *)event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self];
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(playVoice:) object:sender];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(cancelRecord:) object:sender];
    
    _playBtn.btnBgColor(DDY_White);
    _deleteBtn.btnBgColor(DDY_White);
    
    if (CGRectContainsPoint(_playBtn.frame, point)) {
        _playBtn.btnBgColor(DDY_LightGray);
        [self performSelector:@selector(playVoice:) withObject:sender afterDelay:0.3];
    } else if (CGRectContainsPoint(_deleteBtn.frame, point)) {
        _deleteBtn.btnBgColor(DDY_LightGray);
        [self performSelector:@selector(cancelRecord:) withObject:sender afterDelay:0.3];
    }
}

#pragma mark - _audioManager delegate
- (void)audioRecorderDidFinishWithPath:(NSString *)path {
    if (self.recordFinish && _recordState==FFRecordStateDefault) {
        self.recordFinish(path, (self.recordTime / 60));
    } else if (_recordState == FFRecordStatePlay) {
        [_audioManager ddy_PlayAudio:path];
    } else if (_recordState == FFRecordStateDelete) {
        
    }
}

#pragma mark 开始录音
- (void)startRecord:(DDYButton *)sender {
    DDYInfoLog(@"startRecord-----startRecord");
    _playBtn.hidden = NO;
    _deleteBtn.hidden = NO;
    _recordState = FFRecordStateDefault;
    [_audioManager ddy_StartRecordAtPath:[FFFileManager tempPath:@"record.wav"]];
    [self setupTimer];
}

#pragma mark 结束录音
- (void)endRecord:(DDYButton *)sender {
     DDYInfoLog(@"endRecord-----endRecord");
    _recordState = FFRecordStateDefault;
    [_audioManager ddy_StopRecord];
    _playBtn.btnBgColor(DDY_White);
    _deleteBtn.btnBgColor(DDY_White);
    [self stopTimer];
}

#pragma mark 取消录音
- (void)cancelRecord:(DDYButton *)sender {
    DDYInfoLog(@"delete-----delete");
    _recordState = FFRecordStateDelete;
    _playBtn.btnBgColor(DDY_White);
    _deleteBtn.btnBgColor(DDY_White);
    [_audioManager ddy_StopRecord];
    [self stopTimer];
}

#pragma mark 播放录音
- (void)playVoice:(DDYButton *)sender {
    DDYInfoLog(@"play-----play");
    _recordState = FFRecordStatePlay;
     [_audioManager ddy_StopRecord];
    _playBtn.btnBgColor(DDY_White);
    _deleteBtn.btnBgColor(DDY_White);
    [self stopTimer];
}

@end
