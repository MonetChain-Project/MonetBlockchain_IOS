//
//  FFFileManager.h
//  MonetBlockchain
//
//  Created by Rain on 17/12/07.
//  Copyright © 2017年 MonetBlockchain Foundation. All rights reserved.
//

/**
 *  文件存储规则:
 *
 *  一.登录账户所有缓存 
 *      1.缓存及数据文件夹 ~/Document/MyUID_MD5/
 *      2.登录用户数据库   ~/Document/FFDB/loginDataBase.sqlite
 *      3.个人数据库      ~/Document/FFDB/MyUID_MD5/db.sqlite
 *      4.用户头像        ~/Document/MyUID_MD5/Avatar/
 *  二.视频缓存目录    ~/Document/MyUID_MD5/Video/
 *      1.单聊缓存      ~/Document/MyUID_MD5/Video/Chat/Chat_ID_MD5
 *      2.讨论组缓存    ~/Document/MyUID_MD5/Video/DiscussGroup/
 *      3.群组缓存      ~/Document/MyUID_MD5/Video/Group/
 *      4.动态缓存      ~/Document/MyUID_MD5/Video/Dynamic/
 *      5.其他缓存      ~/Document/MyUID_MD5/Video/Other/
 *  三.图片缓存目录    ~/Document/MyUID_MD5/Image/
 *      1.单聊缓存      ~/Document/MyUID_MD5/Image/Chat/Chat_ID_MD5/11.png
 *      2.讨论组缓存    ~/Document/MyUID_MD5/Image/DiscussGroup/
 *      3.群组缓存      ~/Document/MyUID_MD5/Image/Group/
 *      4.动态缓存      ~/Document/MyUID_MD5/Image/Dynamic/
 *      5.其他缓存      ~/Document/MyUID_MD5/Image/Other/
 *  四.语音缓存目录    ~/Document/MyUID_MD5/Audio/
 *      1.单聊缓存      ~/Document/MyUID_MD5/Audio/Chat/Chat_ID_MD5
 *      2.讨论组缓存    ~/Document/MyUID_MD5/Audio/DiscussGroup/
 *      3.群组缓存      ~/Document/MyUID_MD5/Audio/Group/
 *      4.动态缓存      ~/Document/MyUID_MD5/Audio/Dynamic/
 *      5.其他缓存      ~/Document/MyUID_MD5/Audio/Other/
 */

/**
 *  聊天信息统一存储在Document子目录 /FFChat/ChatCache 下
 *  规则:
 *  1.用户关系表 ~/Document/FFChat/UserRelationship.sqlite
 *  2.头像缓存  ~/Document/FFChat/UserAvatar/
 *  3.与某个用户聊天相关 ~/Document/FFChat/ChatCache/UID/
 *  4.与某个用户聊天内容 ~/Document/FFChat/ChatCache/UID/Chat.selite
 *  5.与某个用户聊天图片 ~/Document/FFChat/ChatCache/UID/Image/
 *  6.与某个用户聊天图组 ~/Document/FFChat/ChatCache/UID/ImageGroup/
 *  7.与某个用户聊天gif ~/Document/FFChat/ChatCache/UID/Gif/
 *  8.与某个用户聊天文件 ~/Document/FFChat/ChatCache/UID/Files/
 *
 *  注:
 *  1.群组 UID(localID) : 000000
 *  2.文件命名规则 YYYYMMddHHmmss.file
 *  3.头像命名规则 UID_avatar.png
 */

#import <Foundation/Foundation.h>

/** 用户基础文件夹 */
#define FFUserPath DDYStrFormat(@"%@/%@/", DDYPathDocument, [[FFLoginDataBase sharedInstance].loginUser.localID ddy_MD5])
/** 用户数据库文件夹 */
#define FFDataBasePath [FFUserPath stringByAppendingPathComponent:@"FFDB"]
/** 用户视频文件夹 */
#define FFVideoPath [FFUserPath stringByAppendingPathComponent:@"Video"]
/** 用户图片文件夹 */
#define FFImagePath [FFUserPath stringByAppendingPathComponent:@"Image"]
/** 用户语音文件夹 */
#define FFAudioPath [FFUserPath stringByAppendingPathComponent:@"Audio"]
/** 用户文件文件夹 */
#define FFFilesPath [FFUserPath stringByAppendingPathComponent:@"Files"]
/** 用户头像文件夹 */
#define FFAvatarPath [FFUserPath stringByAppendingPathComponent:@"Avatar"]
/** 用户图组文件夹 */
#define FFImgGroupPath [FFUserPath stringByAppendingPathComponent:@"ImgGroup"]
/** 用户gif文件夹 */
#define FFGifPath [FFUserPath stringByAppendingPathComponent:@"Gif"]

/** 登录账户数据库 */
#define FFLoginDBPath [DDYPathDocument stringByAppendingPathComponent:@"loginDB.sqlite"]
/** 好友资料数据库 */
#define FFUserDBPath [FFDataBasePath stringByAppendingPathComponent:@"userInfo.sqlite"]
/** 聊天缓存数据库 */
#define FFChatDBPath [FFDataBasePath stringByAppendingPathComponent:@"chatDB.sqlite"]

/** 钱包用户缓存的数据库 */
#define FFWalletUserPath [FFUserPath stringByAppendingPathComponent:@"Wallet"]


@interface FFFileManager : NSFileManager

/** 是否存在 */
+ (BOOL)fileExistsAtPath:(NSString *)path;
/** 创建 */
+ (BOOL)createDirectory:(NSString *)path error:(NSError **)error;
/** 删除 */
+ (BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error;
/** 移动 */
+ (BOOL)moveItemAtPath:(NSString *)path toPath:(NSString *)toPath error:(NSError **)error;
/** 复制 */
+ (BOOL)copyItemAtPath:(NSString *)path toPath:(NSString *)toPath error:(NSError **)error;
/** 大小 kb */
+ (CGFloat)fileSizeAtPath:(NSString *)path;
/** 本地音频时长 单位s */
+ (NSUInteger)durationWithPath:(NSString *)path;

/** 预先创建文件夹 */
+ (void)createAllDirectory;
/** 删除所有文件夹 */
+ (void)deleteAllDirectory;
/** 创建与某人的聊天文件夹 */
+ (void)createDirectoryWithUser:(NSString *)localID;
/** 删除与某人的聊天文件夹 */
+ (void)deleteDirecrotyWithUser:(NSString *)localID;

/** 临时文件 录音、拍照等临时存储 */
+ (NSString *)tempPath:(NSString *)fileName;



/**------------------------头像------------------------- */

/** 保存自己头像 */
+ (NSString *)saveMyAvatar:(UIImage *)image localID:(NSString *)localID ;

/** 保存无网用户头像 */
+ (BOOL)saveAvatarImage:(NSURL *)url uidTo:(NSString *)uidTo;
/** 保存有网用户头像 */
+ (void)saveNetAvatar:(NSURL *)url uidTo:(NSString *)uidTo callBack:(void(^)(NSURL *filePath))callBack ;

/** 读取用户头像 */
+ (UIImage *)avatarWithID:(NSString *)uidTo;







/** 保存与某人有网聊天收到的图片/语音 */
+ (void)saveReceiveMsg:(FFMessage *)msg callBack:(void(^)(BOOL finish))callBack;

/**------------------------图片------------------------- */

/** 保存与某人无网聊天发送的图片 */
+ (NSString *)saveSendImage:(UIImage *)image msgID:(NSString *)msgID uidTo:(NSString *)uidTo;

/** 保存与某人无网聊天收到的图片  未经同意别动 */
+ (BOOL)saveReceiveImage:(NSURL *)url uidTo:(NSString *)uidTo resourceName:(NSString *)resourceName;

/** 读取与某人的聊天图片 */
+ (UIImage *)chatImgWithMsgID:(NSString *)msgID uidTo:(NSString *)uidTo;

/**------------------------语音------------------------- */

/** 保存与某人无网聊天发送的语音 */
+ (NSString *)saveSendVoiceWithmsgID:(NSString *)msgID uidTo:(NSString *)uidTo;

/** 保存与某人聊天收到的语音 */
+ (BOOL)saveReceiveVoice:(NSURL *)url uidTo:(NSString *)uidTo resourceName:(NSString *)resourceName;

/* 读取与某人的聊天语音 */
+ (NSString *)chatVoiceWithMsgID:(NSString *)msgID uidTo:(NSString *)uidTo;

@end
