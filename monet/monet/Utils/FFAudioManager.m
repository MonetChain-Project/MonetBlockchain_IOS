//
//  FFAudioManager.m
//  MonetBlockchain
//
//  Created by Rain on 17/12/07.
//  Copyright © 2017年 MonetBlockchain Foundation. All rights reserved.
//

#import "FFAudioManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface FFAudioManager () <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
/** 录音器 */
@property (nonatomic, strong) AVAudioRecorder *recorder;
/** 播放器 */
@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation FFAudioManager


#pragma mark - 单例对象

static FFAudioManager *_instance;

+ (instancetype)sharedManager {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

#pragma mark - 录音
#pragma mark 录音设置
- (NSDictionary *)recordSetting {
    if (!_recordSetting) {
        _recordSetting = @{AVSampleRateKey:@(8000), AVFormatIDKey:@(kAudioFormatLinearPCM), AVLinearPCMBitDepthKey:@(16), AVNumberOfChannelsKey:@(1)};
    }
    return _recordSetting;
}

#pragma mark 开始录音
- (void)ff_StartRecordAtPath:(NSString *)path {
    [self ff_StopRecord];
    [self ff_StopAudio];
    [DDYAuthorityMaster audioAuthSuccess:^{
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:path] settings:self.recordSetting error:nil];
        _recorder.meteringEnabled = YES;
        _recorder.delegate = self;
        if ([_recorder prepareToRecord]) {
            [_recorder record];
        }
    } fail:^{ } alertShow:YES];
}

#pragma mark 结束录音
- (void)ff_StopRecord {
    if (_recorder.isRecording) {
        [_recorder stop];
    }
}

#pragma mark - AVAudioRecorderDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    NSString *wavPath = [[_recorder url] path];
    // 音频转换
    NSString *amrPath = [[wavPath stringByDeletingPathExtension] stringByAppendingPathExtension:pathExt_AMR];
    [VoiceConverter ConvertWavToAmr:wavPath amrSavePath:amrPath];
}


#pragma mark - 播放
#pragma mark 播放本地音频
- (void)ff_PlayAudio:(NSString *)path {
    [self ff_StopRecord];
    [self ff_StopAudio];
    if ([FFFileManager fileExistsAtPath:path]) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
        _player.numberOfLoops = 0;
        _player.delegate = self;
        if ([_player prepareToPlay]) {
            [_player play];
        };
    }
}

#pragma mark 暂停播放
- (void)ff_PauseAudio {
    if (_player && _player.isPlaying) {
        [_player pause];
    }
}

#pragma mark 停止播放
- (void)ff_StopAudio {
    if (_player && _player.isPlaying) {
        [_player stop];
    }
}

#pragma mark 恢复播放
- (void)ff_ReplayAudio {
    if (_player) {
        [_player play];
    }
}

#pragma mark 播放完成
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self ff_StopAudio];
    if ([self.delegate respondsToSelector:@selector(audioPlayDidFinish)]) {
        [self.delegate audioPlayDidFinish];
    }
}

#pragma mark 设置播放模式
- (void)setAudioCategory:(NSString *)audioCategory {
    _audioCategory = audioCategory;
    [[AVAudioSession sharedInstance] setCategory:audioCategory error:nil];
}

#pragma mark 设置音量
- (void)setVolume:(CGFloat)volume {
    if (_player) {
        _player.volume = volume;
    }
}

- (void)dealloc {
    [self ff_StopRecord];
    [self ff_StopAudio];
}

@end
