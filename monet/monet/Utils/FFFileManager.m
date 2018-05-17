//
//  FFFileManager.m
//  MonetBlockchain
//
//  Created by Rain on 17/12/07.
//  Copyright © 2017年 MonetBlockchain Foundation. All rights reserved.
//

#import "FFFileManager.h"

/** 临时文件 录音、拍照等临时存储 */
static NSString *const FFChatTempPath       = @"/FFChat/Temp/";

@implementation FFFileManager

#pragma mark - Base
#pragma mark 是否存在
+ (BOOL)fileExistsAtPath:(NSString *)path {
    return [DDYFileManager fileExistsAtPath:path];
}

#pragma mark 创建
+ (BOOL)createDirectory:(NSString *)path error:(NSError **)error {
    if ([FFFileManager fileExistsAtPath:path]) {
        return YES;
    } else {
        return [DDYFileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:error];
    }
}

#pragma mark 删除
+ (BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error {
    return [DDYFileManager removeItemAtPath:path error:error];
}

#pragma mark 移动
+ (BOOL)moveItemAtPath:(NSString *)path toPath:(NSString *)toPath error:(NSError **)error {
    return [DDYFileManager moveItemAtPath:path toPath:toPath error:error];
}

#pragma mark 复制
+ (BOOL)copyItemAtPath:(NSString *)path toPath:(NSString *)toPath error:(NSError **)error {
    return [DDYFileManager copyItemAtPath:path toPath:path error:error];
}

#pragma mark 大小
+ (CGFloat)fileSizeAtPath:(NSString *)path {
    unsigned long long length = [[DDYFileManager attributesOfItemAtPath:path error:nil] fileSize];
    return length/1024.0;
}

#pragma mark 本地音视频时长
+ (NSUInteger)durationWithPath:(NSString *)path {
    if ([FFFileManager fileExistsAtPath:path]) {
        AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:DDYURLStr(path) options:@{AVURLAssetPreferPreciseDurationAndTimingKey:@(NO)}];
        return urlAsset.duration.value / urlAsset.duration.timescale;
    }
    return 0;
}

#pragma mark -
#pragma mark 预先创建文件夹
+ (void)createAllDirectory {
    if (![FFLoginDataBase sharedInstance].loginUser.localID)  {
        DDYInfoLog(@"必须登录后调用");
        return;
    }
    // 用户基础文件夹
    [self createDirectory:FFUserPath error:nil];
    // 用户数据库文件夹
    [self createDirectory:FFDataBasePath error:nil];
    // 用户视频文件夹
    [self createDirectory:FFVideoPath error:nil];
    // 用户图片文件夹
    [self createDirectory:FFImagePath error:nil];
    // 用户语音文件夹
    [self createDirectory:FFAudioPath error:nil];
    // 用户文件文件夹
    [self createDirectory:FFFilesPath error:nil];
    // 用户头像文件夹
    [self createDirectory:FFAvatarPath error:nil];
}

#pragma mark 删除所有文件夹
+ (void)deleteAllDirectory {
    [self removeItemAtPath:FFVideoPath error:nil];
    [self removeItemAtPath:FFImagePath error:nil];
    [self removeItemAtPath:FFAudioPath error:nil];
    [self removeItemAtPath:FFFilesPath error:nil];
    [self removeItemAtPath:FFAvatarPath error:nil];
}

#pragma mark 创建与某人的聊天文件夹
+ (void)createDirectoryWithUser:(NSString *)localID {
    [self pathWithBasePath:FFVideoPath addPath:[localID ddy_MD5]];
    [self pathWithBasePath:FFImagePath addPath:[localID ddy_MD5]];
    [self pathWithBasePath:FFAudioPath addPath:[localID ddy_MD5]];
    [self pathWithBasePath:FFFilesPath addPath:[localID ddy_MD5]];
    [self pathWithBasePath:FFAvatarPath addPath:[localID ddy_MD5]];
}
#pragma mark 删除与某人的聊天文件夹
+ (void)deleteDirecrotyWithUser:(NSString *)localID {
    [self removeItemAtPath:[FFVideoPath stringByAppendingPathComponent:[localID ddy_MD5]] error:nil];
    [self removeItemAtPath:[FFImagePath stringByAppendingPathComponent:[localID ddy_MD5]] error:nil];
    [self removeItemAtPath:[FFAudioPath stringByAppendingPathComponent:[localID ddy_MD5]] error:nil];
    [self removeItemAtPath:[FFFilesPath stringByAppendingPathComponent:[localID ddy_MD5]] error:nil];
    [self removeItemAtPath:[FFAvatarPath stringByAppendingPathComponent:[localID ddy_MD5]] error:nil];
}

#pragma mark 临时文件 录音、拍照等临时存储
+ (NSString *)tempPath:(NSString *)fileName {
    NSString *tempPath = DDYStrFormat(@"%@%@", DDYPathDocument, FFChatTempPath);
    if (![self fileExistsAtPath:tempPath]) {
        [self createDirectory:tempPath error:nil];
    }
    return [tempPath stringByAppendingPathComponent:fileName];
}

#pragma mark 保存自己头像
+ (NSString *)saveMyAvatar:(UIImage *)image localID:(NSString *)localID {
    NSString *path = [FFAvatarPath stringByAppendingPathComponent:DDYStrFormat(@"%@.png",localID)];
    if ([self fileExistsAtPath:path]) {
        [self removeItemAtPath:path error:nil];
    }
    [[FFFileManager defaultManager] createFileAtPath:path contents:UIImagePNGRepresentation(image) attributes:nil];
    return path;
}

#pragma mark 保存无网用户头像
+ (BOOL)saveAvatarImage:(NSURL *)url uidTo:(NSString *)uidTo
{
    NSString *path = [FFAvatarPath stringByAppendingPathComponent:DDYStrFormat(@"%@.png",uidTo)];
    if ([self fileExistsAtPath:path]) {
        [self removeItemAtPath:path error:nil];
    }
    return [DDYFileManager moveItemAtURL:url toURL:[NSURL fileURLWithPath:path] error:nil];
}

#pragma mark 保存有网用户头像
+ (void)saveNetAvatar:(NSURL *)url uidTo:(NSString *)uidTo callBack:(void(^)(NSURL *filePath))callBack {
    NSString *path = [FFAvatarPath stringByAppendingPathComponent:DDYStrFormat(@"%@.png",uidTo)];
    if ([self fileExistsAtPath:path]) {
        [self removeItemAtPath:path error:nil];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) [self removeItemAtPath:path error:nil];
        if (callBack) callBack(error ? nil : filePath);
    }];
    [download resume];
}

#pragma mark 读取用户头像
+ (UIImage *)avatarWithID:(NSString *)uidTo {
    return [UIImage imageWithContentsOfFile:[FFAvatarPath stringByAppendingPathComponent:DDYStrFormat(@"%@.png",uidTo)]];
    
}


#pragma mark - 0. 图片/语音下载

#pragma mark 保存与某人有网聊天收到的图片/语音
+ (void)saveReceiveMsg:(FFMessage *)msg callBack:(void(^)(BOOL finish))callBack {
    
    NSString *path = nil;
    if (msg.messageType == FFMessageTypeImg) {
        
        DDYInfoLog(@"保存与某人有网聊天收到的图片:%@",msg.fileURL);
        path = [[self pathWithBasePath:FFImagePath addPath:[msg.remoteID ddy_MD5]] stringByAppendingPathComponent:DDYStrFormat(@"%@.png",[msg.messageID ddy_MD5])];
        
    }else if (msg.messageType == FFMessageTypeVoice) {
        
        DDYInfoLog(@"保存与某人有网聊天收到的语音:%@",msg.fileURL);
        path = [[self pathWithBasePath:FFAudioPath addPath:[msg.remoteID ddy_MD5]] stringByAppendingPathComponent:DDYStrFormat(@"%@.%@",[msg.messageID ddy_MD5], pathExt_AMR)];
    }
    DDYInfoLog(@"保存与某人有网聊天收到的地址:%@",path);
    if ([self fileExistsAtPath:path]) {
        [self removeItemAtPath:path error:nil];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:msg.fileURL]];
    
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        DDYInfoLog(@"download:%lld---total:%lld",downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (callBack)  callBack(YES);
    }];
    
    [download resume];
}

#pragma mark - 1. 图片

#pragma mark 保存与某人聊天发送的图片 [msgID MD5].png
+ (NSString *)saveSendImage:(UIImage *)image msgID:(NSString *)msgID uidTo:(NSString *)uidTo {
    NSString *path = [[self pathWithBasePath:FFImagePath addPath:[uidTo ddy_MD5]] stringByAppendingPathComponent:DDYStrFormat(@"%@.png",[msgID ddy_MD5])];
    [[FFFileManager defaultManager] createFileAtPath:path contents:UIImagePNGRepresentation(image) attributes:nil];
    return path;
}

#pragma mark 保存与某人无网聊天收到的图片 未经同意别动
+ (BOOL)saveReceiveImage:(NSURL *)url uidTo:(NSString *)uidTo resourceName:(NSString *)resourceName {
    DDYInfoLog(@"保存与某人无网聊天收到的图片:%@",resourceName);
    NSString *path = [[self pathWithBasePath:FFImagePath addPath:[uidTo ddy_MD5]] stringByAppendingPathComponent:[resourceName stringByReplacingOccurrencesOfString:DDYStrFormat(@"%@<#>",FFSendImage) withString:@""]];;
    if ([self fileExistsAtPath:path]) {
        [self removeItemAtPath:path error:nil];
    }
    NSError *error ;
    BOOL result = [DDYFileManager moveItemAtURL:url toURL:[NSURL fileURLWithPath:path] error:&error];
    if (error) {
        DDYInfoLog(@"保存与某人无网聊天收到的图片 未经同意别动 ：%@",error);
    }
    return result;
}

#pragma mark 读取与某人的聊天图片
+ (UIImage *)chatImgWithMsgID:(NSString *)msgID uidTo:(NSString *)uidTo {
    DDYInfoLog(@"duqutupian:%@\n%@\n%@",msgID,uidTo,[[self pathWithBasePath:FFImagePath addPath:[uidTo ddy_MD5]] stringByAppendingPathComponent:DDYStrFormat(@"%@.png",[msgID ddy_MD5])]);
    DDYInfoLog(@"duqudaxiao:%f",[self fileSizeAtPath:[self pathWithBasePath:FFImagePath addPath:[uidTo ddy_MD5]]]);
    return [UIImage imageWithContentsOfFile:[[self pathWithBasePath:FFImagePath addPath:[uidTo ddy_MD5]] stringByAppendingPathComponent:DDYStrFormat(@"%@.png",[msgID ddy_MD5])]];
}

+ (NSString *)pathWithBasePath:(NSString *)basePath addPath:(NSString *)addPath {
    NSString *newPath = [basePath stringByAppendingPathComponent:addPath];
    [FFFileManager createDirectory:newPath error:nil];
    return newPath;
}

#pragma mark - 2. 语音

#pragma mark 保存与某人无网聊天发送的语音
+ (NSString *)saveSendVoiceWithmsgID:(NSString *)msgID uidTo:(NSString *)uidTo
{
    return [[self pathWithBasePath:FFAudioPath addPath:[uidTo ddy_MD5]] stringByAppendingPathComponent:DDYStrFormat(@"%@.%@",[msgID ddy_MD5], pathExt_AMR)];
}

#pragma mark 保存与某人无网聊天收到的语音
+ (BOOL)saveReceiveVoice:(NSURL *)url uidTo:(NSString *)uidTo resourceName:(NSString *)resourceName {
    DDYInfoLog(@"保存与某人无网聊天收到的语音:%@",resourceName);
    NSString *path = [[self pathWithBasePath:FFAudioPath addPath:[uidTo ddy_MD5]] stringByAppendingPathComponent:[resourceName stringByReplacingOccurrencesOfString:DDYStrFormat(@"%@<#>",FFSendVoice) withString:@""]];;
    if ([self fileExistsAtPath:path]) {
        [self removeItemAtPath:path error:nil];
    }
    NSError *error ;
    [DDYFileManager moveItemAtURL:url toURL:[NSURL fileURLWithPath:path] error:&error];
    if (error) {
        DDYInfoLog(@"%@",error);
    }
    return YES;
}

#pragma mark 读取与某人的聊天语音
+ (NSString *)chatVoiceWithMsgID:(NSString *)msgID uidTo:(NSString *)uidTo
{
    return [[self pathWithBasePath:FFAudioPath addPath:[uidTo ddy_MD5]] stringByAppendingPathComponent:DDYStrFormat(@"%@.%@",[msgID ddy_MD5], pathExt_AMR)];
}

@end
/**
 
 // 文件管理器
 NSFileManager *fileManager = [NSFileManager defaultManager];
 // 拼接要存放东西的文件夹
 NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)objectAtIndex:0];
 NSString *createPath = [NSStringstringWithFormat:@"%@/EcmChatMyPic", pathDocuments];
 // 判断文件夹是否存在，如果不存在，则创建
 if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
 
 // 如果没有就创建这个 想创建的文件夹   （）
 [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
 
 // 然后保存
 NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/EcmChatMyPic"];
 NSString *imgFileName = [NSStringstringWithFormat:@"/%@.jpg",fileName];
 [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:imgFileName] contents:data attributes:nil];
 
 } else {
 //文件夹存在   直接保存
 NSString * DocumentsPath = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents/EcmChatMyPic"];
 
 NSString *imgFileName = [NSStringstringWithFormat:@"/%@.jpg",fileName];
 
 [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:imgFileName]contents:data attributes:nil];
 }
 
 
 //存完之后 接着就取出来 发送
 NSString * DocumentsPath = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents/EcmChatMyPic"];
 NSString *imgFileName = [NSStringstringWithFormat:@"/%@.jpg",fileName];
 NSString * filePath = [[NSString alloc] initWithFormat:@"%@%@",DocumentsPath,imgFileName];
 //取出图片 等待 你的使用
 UIImage *img = [UIImage imageWithContentsOfFile:filePath];
 
 */
