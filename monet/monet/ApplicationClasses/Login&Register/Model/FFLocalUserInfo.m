//
//  NALocalUserInfo.m
//  NextApp
//
//  Created by Megan ( http://nsobject.me )  on 14-4-10.
//  Copyright (c) 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFLocalUserInfo.h"
#import "sys/utsname.h"
#import "LC_UDID.h"

@implementation FFLocalUserInfo

+(void) exitCurrentUser
{
    [[FFLocalUserInfo LCInstance] isLogin];
}

-(BOOL) isLogin
{
    if (!self.userInfoDictionary)
    {
//        self.userInfoDictionary = [NSMutableDictionary dictionaryWithDictionary:[[NAUserDefault sharedInstance].store getObjectById:USER_INFO_KEY fromTable:TABLENAME]];
    }
    return _isLogin;
}

+ (NSString *)deviceUUID
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR || TARGET_OS_MAC)
    
    Class openUDID = NSClassFromString( @"LC_UDID" );
    
    if ( openUDID )
    {
        return [openUDID UDID];
    }
    else
    {
        return nil; //已弃用 [UIDevice currentDevice].uniqueIdentifier;
    }
    
#else
    return nil;
#endif
}

+ (NSString *)deviceModel
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
    //    return [UIDevice currentDevice].model;
    return [FFLocalUserInfo platform];
#else
    return nil;
#endif
}

+ (NSString*)platform
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    return deviceString;
}


@end
