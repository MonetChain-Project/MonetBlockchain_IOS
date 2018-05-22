//
//  FFGroupHeadView.m
//  MonetBlockchain
//
//  Created by Megan on 2017/11/3.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFGroupHeadView.h"
//#import "NAUserCache.h"

@interface FFGroupHeadView ()
{
    UIView * _contentView;
}

@property(nonatomic,retain) NSMutableArray * headViews;

@end

@implementation FFGroupHeadView


- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 50, 50)];
    if (self) {
        
        [self initSelf];
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 50, 50)];
    
    if (self) {
        
        [self initSelf];
    }
    
    return self;
}

-(void) initSelf
{
    self.headViews = [NSMutableArray array];
    
    self.layer.cornerRadius = 25;
    self.layer.masksToBounds = YES;
    self.backgroundColor = LC_RGB(210, 210, 210);
    
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    
    for (int i = 0 ; i < 4; i++) {
        
        UIImageView * circle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        circle.backgroundColor = [UIColor whiteColor];
        circle.hidden = YES;
        [self addSubview:circle];
        
        [self.headViews addObject:circle];
    }
}


#define PADDING 1

-(void) setUserHeads:(NSArray *)member
{
    for (int i = 0;i< self.headViews.count ;i++)
    {
        UIImageView * view =  self.headViews[i];
        view.hidden = YES;
        view.image = [UIImage imageNamed:@"icon_head_defaul"];
    }
    
    float width = 0;
    
    if (member.count == 1) {
        
        width = [self getWidth:1];
        
        FFUser *user = member[0];
        
        UIImageView * headView = self.headViews[0];
        headView.image = [UIImage imageNamed:@"icon_head_defaul"];
        [headView sd_setImageWithURL:[NSURL URLWithString:user.thumb] placeholderImage:[UIImage imageNamed:@"icon_head_defaul"]];
        headView.viewFrameX = PADDING;
        headView.viewFrameY = PADDING;
        headView.viewFrameWidth = width;
        headView.viewFrameHeight = width;
        headView.hidden = NO;
        headView.layer.cornerRadius = width/2;
        headView.layer.masksToBounds = YES;
    }
    else if (member.count == 2) {
        
        width = [self getWidth:2]  ;
        
        for (int i = 0; i< member.count; i++) {
            
            FFUser *user = member[i];
            UIImageView * headView = self.headViews[i];
            headView.image = [UIImage imageNamed:@"icon_head_defaul"];
            [headView sd_setImageWithURL:[NSURL URLWithString:user.thumb] placeholderImage:[UIImage imageNamed:@"icon_head_defaul"]];
            headView.viewFrameY = self.viewMidHeight - width/2  ;
            headView.viewFrameWidth = width ;
            headView.viewFrameHeight = width  ;
            headView.hidden = NO;
            headView.layer.cornerRadius = width/2;
            headView.layer.masksToBounds = YES;
        }
    }
    else if (member.count == 3){
        
        width = [self getWidth:4] -5;
        
        float inv = self.viewMidHeight - width/2;
        
        FFUser *user = member[0];
        
        UIImageView * headView = self.headViews[0];
        headView.image = [UIImage imageNamed:@"icon_head_defaul"];
        [headView sd_setImageWithURL:[NSURL URLWithString:user.thumb] placeholderImage:[UIImage imageNamed:@"icon_head_defaul"]];
        headView.viewFrameX = inv;
        headView.viewFrameY = PADDING +3;
        headView.viewFrameWidth = width;
        headView.viewFrameHeight = width;
        headView.hidden = NO;
        headView.layer.cornerRadius = width/2;
        headView.layer.masksToBounds = YES;
        
        for (NSInteger i = 1; i < 3 ;i++) {
            
            FFUser *user = member[i];
            UIImageView * headView1 = self.headViews[i];
            headView1.image = [UIImage imageNamed:@"icon_head_defaul"];
            [headView sd_setImageWithURL:[NSURL URLWithString:user.thumb] placeholderImage:[UIImage imageNamed:@"icon_head_defaul"]];
            headView1.viewFrameX = PADDING * (i) + width * (i - 1) + 5;
            headView1.viewFrameY = headView.viewBottomY + PADDING ;
            headView1.viewFrameWidth = width;
            headView1.viewFrameHeight = width;
            headView1.hidden = NO;
            headView1.layer.cornerRadius = width/2;
            headView1.layer.masksToBounds = YES;
        }
    }
    else if (member.count >= 4){
        
        width = [self getWidth:4] - 5;
        
        NSInteger count = member.count > 4 ? 4 : member.count;
        
        for (int i = 0; i< count; i++) {
            
            FFUser *user = member[i];
            UIImageView * headView = self.headViews[i];
            headView.image = [UIImage imageNamed:@"icon_head_defaul"];
            [headView sd_setImageWithURL:[NSURL URLWithString:user.thumb] placeholderImage:[UIImage imageNamed:@"icon_head_defaul"]];
            headView.viewFrameX = i%2 * width + i%2 * PADDING + PADDING + 5;
            headView.viewFrameY = i/2 * width + i/2 * PADDING + PADDING + 5;
            headView.viewFrameWidth = width;
            headView.viewFrameHeight = width;
            headView.hidden = NO;
            headView.layer.cornerRadius = width/2;
            headView.layer.masksToBounds = YES;
        }
    }
    
}

-(float) getWidth:(NSInteger)mode
{
    if (mode == 1) {
        
        return self.viewFrameWidth - (PADDING * 2);
        
    }else if (mode == 2){
        
        return (self.viewFrameWidth - (PADDING * 3))/2;
        
    }else if (mode == 4){
        
        return (self.viewFrameWidth - (PADDING * 3))/2;
        
    }else if (mode == 9){
        
        return (self.viewFrameWidth - (PADDING * 4))/3;
    }
    
    return 0;
}

@end

