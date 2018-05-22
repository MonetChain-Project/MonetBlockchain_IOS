//
//  FFMessageFileCell.m
//  MonetBlockchain
//
//  Created by Rain on 17/12/04.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFMessageFileCell.h"
#import "FFGroupFileTypeView.h"
#import "FFFileInfo.h"

@interface FFMessageFileCell()
{
    float _downLoad_progress;
}

@property (nonatomic, strong) UIProgressView * progressView;
@property (nonatomic, strong) FFMessageCellModel * message;
@property (nonatomic, strong) UILabel * fileState;
@property (nonatomic, strong) UILabel * fileDeal;
@property (nonatomic, strong) UILabel * fileSize;

@end

@implementation FFMessageFileCell

- (id)initWithMessage:(FFMessageCellModel *)message{
    
    self = [super initWithFrame:CGRectMake(0, 0, 200, 90)];
    
    if (self) {
        
        self.message = message;
        
        FFGroupFileTypeView * icon = [[FFGroupFileTypeView alloc] initWithFrame:CGRectMake(11, 15 , 60, 60)];
        [icon setFileInfo:message.fileInfo];
        [self addSubview:icon];
        
        CGSize size = [message.fileInfo.showFileName sizeWithFont:NA_FONT(14) byWidth: 183 - icon.viewRightX - 5];
        
        UILabel * content = [[UILabel alloc] init];
        content.textColor = [UIColor blackColor];
        content.numberOfLines = 0;
        content.text = message.fileInfo.showFileName;
        content.font = NA_FONT(14);
        content.frame = CGRectMake(icon.viewRightX + 10, 10, size.width, 40);
        [self addSubview:content];
        
        _fileSize = [[UILabel alloc] init];
        _fileSize.textColor = LC_RGB(175, 175, 175);
        _fileSize.font = NA_FONT(12);
        _fileSize.text = message.fileInfo.formatFileSize;
        _fileSize.frame = CGRectMake(icon.viewRightX + 10, icon.viewBottomY - 12, 80, 15);
        [self addSubview:_fileSize];
        
        _fileState = [[UILabel alloc] init];
        _fileState.textColor = LC_RGB(175, 175, 175);
        _fileState.font = NA_FONT(12);
        _fileState.textAlignment = NSTextAlignmentRight;
        _fileState.frame = CGRectMake(120 , icon.viewBottomY - 12 , 70, 15);
        [self addSubview:_fileState];
        
        
        if (message.fileInfo.status == FFGroupFileStateTypeUploadFailure) {
            
            _fileState.text = @"发送失败";
            _fileState.textColor = [UIColor redColor];
            
        }else if(message.fileInfo.status == FFGroupFileStateTypeUploadSuccess){
            
            _fileState.text = @"已发送";
        }
//        else if(message.fileInfo.status == FFGroupFileStateTypeNormally && message.chatType == FFChatTypeOthers){
//            
//            _fileState.text = [self getLastTime:self.message.fileInfo.fileDate];
//            
//        }
        else if(message.fileInfo.status == FFGroupFileStateTypeDownloadFailure){
            
            _fileState.text = @"下载失败";
            _fileState.textColor = [UIColor redColor];
            
        }else if(message.fileInfo.status == FFGroupFileStateTypeDownloadSuccess|| message.fileInfo.status == FFGroupFileStateTypeLocalExist){
            
            _fileState.text = @"已下载";
        }else if(message.fileInfo.status == FFGroupFileStateTypeDateExpired){
            
            _fileState.text = @"已失效";
            
        }
        
        _progressView = [[UIProgressView alloc] initWithFrame:LC_RECT( 11 ,  icon.viewBottomY + 6 , 178 , 1)];
        _progressView.trackTintColor = LC_RGB(219, 219, 219);
        _progressView.progressTintColor = LC_RGB(76, 196, 201);
        _progressView.backgroundColor = [UIColor clearColor];
        _progressView.hidden = YES;
        [self addSubview:_progressView];
        
        
        _fileDeal = [[UILabel alloc] initWithFrame:CGRectMake(icon.viewRightX + 10, icon.viewBottomY - 12, 120 , 15)];
        _fileDeal.font = NA_FONT(13);
        _fileDeal.textColor = APP_MAIN_COLOR;
        _fileDeal.text = @"正在处理...";
        [self addSubview:_fileDeal];
        _fileDeal.hidden = YES;
        
        
        
        if (self.message.fileInfo.videoUrl && self.message.fileInfo.status == FFGroupFileStateTypeNormally)
        {
            _fileSize.hidden = YES;
            _fileDeal.hidden = NO;
        }
        else
        {
            _fileDeal.hidden = YES;
        }
        
        [self observeNotification:@"NASendFileProgressNotification"];
        [self observeNotification:@"NASendFileSuccessNotification"];
        [self observeNotification:@"NADownloadFileSuccessNotification"];
        [self observeNotification:@"NADownloadFileProgressNotification"];
        [self observeNotification:@"NASendFileFailNotification"];
        
        
    }
    
    return self;
}

- (void)handleNotification:(NSNotification *)notification{
    
    if ([notification is:@"NASendFileSuccessNotification"])
    {
        
        FFFileInfo *file = notification.object;
        
        if ([file.fileName isEqualToString:self.message.fileInfo.fileName])
        {
            
            _fileSize.hidden = NO;
            _fileDeal.hidden = YES;
            _fileState.text = @"已发送";
            _progressView.hidden = YES;
            self.message.fileInfo.status = FFGroupFileStateTypeUploadSuccess;
//            [[NAChatDatabase sharedInstance] updateCustomFileState:self.message];
        }
        
    }
    if ([notification is:@"NASendFileFailNotification"])
    {
        
        FFFileInfo *file = notification.object;
        
        if ([file.fileName isEqualToString:self.message.fileInfo.fileName])
        {
            
            _fileSize.hidden = NO;
            _fileDeal.hidden = YES;
            _progressView.hidden = YES;
            _fileState.text = @"发送失败";
            _fileState.textColor = [UIColor redColor];
            self.message.fileInfo.status = FFGroupFileStateTypeUploadFailure;
//            [[NAChatDatabase sharedInstance] updateCustomFileState:self.message];
        }
        
    }
    else if([notification is:@"NASendFileProgressNotification"]){
        
        NSString *fileName = notification.object[0];
        
        if ([fileName isEqualToString:self.message.fileInfo.fileName]) {
            
            _fileSize.hidden = NO;
            _fileDeal.hidden = YES;
            _progressView.hidden = NO;
            _fileState.hidden = YES;
            _downLoad_progress = [notification.object[1] floatValue] ;
            _progressView.progress = _downLoad_progress;
            
        }
    }else if ([notification is:@"NADownloadFileProgressNotification"]){
        
        NSString *fileName = notification.object[0];
        
        if ([fileName isEqualToString:self.message.fileInfo.fileName]) {
            
            _fileSize.hidden = NO;
            _fileDeal.hidden = YES;
            _progressView.hidden = NO;
            _fileState.hidden = YES;
            _downLoad_progress = [notification.object[1] floatValue] ;
            _progressView.progress = _downLoad_progress;
            
        }
    }else if ([notification is:@"NADownloadFileSuccessNotification"]){
        
        NSString *fileName = notification.object;
        
        if ([fileName isEqualToString:self.message.fileInfo.fileName]) {
            
            _fileSize.hidden = NO;
            _fileDeal.hidden = YES;
            _fileState.text = @"已下载";
            _progressView.hidden = YES;
            self.message.fileInfo.status = FFGroupFileStateTypeDownloadSuccess;
//            [[NAChatDatabase sharedInstance] updateCustomFileState:self.message];
            
        }
        
    }
    
    
}


- (NSString *)getLastTime:(NSString *)str{
    
    NSTimeInterval late1=[str doubleValue] + [NEXT_APP_FILE_EXPIRE_TIME integerValue];
    NSDate *senddate = [NSDate date];
    NSTimeInterval late2 = [senddate timeIntervalSince1970] ;
    NSTimeInterval cha = late1 - late2;
    
    NSString *hour=@"";
    NSString *min=@"";
    NSString *day=@"";
    
    min = [NSString stringWithFormat:@"%d", (int)((cha/60))];
    
    hour = [NSString stringWithFormat:@"%d", (int)cha/3600];
    
    day = [NSString stringWithFormat:@"%d", (int)((cha/3600)/24)];
    
    if (cha < 0) {
        
        return @"已失效";
        
    }else{
        
        if ([day integerValue] > 0) {
            
            return [NSString stringWithFormat:@"%@天后过期",day];
            
        }else if([hour integerValue] > 0){
            
            return [NSString stringWithFormat:@"%@小时后过期",hour];
            
        }else if([min integerValue]> 0){
            
            return [NSString stringWithFormat:@"%@分后过期",min];
            
        }else{
            
            return @"已失效";
        }
    }
    
    
    return @"";
}

@end
