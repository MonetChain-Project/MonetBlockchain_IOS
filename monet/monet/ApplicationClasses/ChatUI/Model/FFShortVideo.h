//
//  NAShortVideo.h
//  MonetBlockchain
//
//  Created by Rain on 18/1/206.
//  Copyright © 2018年 MonetBlockchain Foundation All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFShortVideo : NSObject


@property(nonatomic,strong) NSString * videoName;
@property(nonatomic,assign) NSString * imageUrl;
@property(nonatomic,strong) NSString * localVideoUrl;
@property(nonatomic,assign) NSInteger  isLocal;
@property(nonatomic,strong) NSString * remotingurl;
@property(nonatomic,strong) NSString * oldName; //  用于解决用户发送两次的情况
@property(nonatomic,assign) NSInteger time;

-(instancetype) initWithDictionary:(NSDictionary *)dic;


@end
