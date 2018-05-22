//
//  FFGroupFileTypeView.h
//  MonetBlockchain
//
//  Created by Rain on 17/12/04.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFFileInfo;

@interface FFGroupFileTypeView : UIImageView

@property(nonatomic,assign) NSInteger fileType;
@property(nonatomic,strong) FFFileInfo * fileInfo;
@property(nonatomic,strong) FFFileInfo * bigIconFileInfo;

@end
