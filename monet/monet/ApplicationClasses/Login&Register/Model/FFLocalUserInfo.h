//
//  NALocalUserInfo.h
//  NextApp
//
//  Created by Megan ( http://nsobject.me )  on 14-4-10.
//  Copyright (c) 2017年 MonetBlockchain Foundation All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -

@interface FFLocalUserInfo : NSObject

@property(nonatomic,assign) BOOL       isLogin;
@property(nonatomic,assign) BOOL       isSignUp;
@property(nonatomic,assign) BOOL       isUser;
@property(nonatomic,assign) BOOL       isRSAKey;
@property(nonatomic,strong) NSString * phonenumber;
@property(nonatomic,strong) NSString * emailnumber;
@property(nonatomic,assign) NSInteger  uid;
@property(nonatomic,retain) NSMutableDictionary * userInfoDictionary;

+(void) exitCurrentUser;

+ (NSString *)deviceModel;

+ (NSString *)deviceUUID;

+ (NSString*)deviceVersion;

@end
