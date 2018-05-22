//
//  FFGroupFileTypeView.m
//  MonetBlockchain
//
//  Created by Rain on 17/12/04.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFGroupFileTypeView.h"
#import "FFFileInfo.h"

@implementation FFGroupFileTypeView

-(instancetype) init
{
    if (self = [super init]) {
        
        //        self.viewFrameWidth = 12;
        //        self.viewFrameHeight= 12;
    }
    
    return self;
}

-(void) setFileType:(NSInteger)fileType
{
    if (fileType == 1) {
        
        self.image = [UIImage imageNamed:@"group_file_word_little.png"];
    }
    else  if (fileType == 2) {
        
        self.image = [UIImage imageNamed:@"group_file_excel_little.png"];
        
    }
    else  if (fileType == 3) {
        
        self.image = [UIImage imageNamed:@"group_file_txt_little.png"];
        
    }
    else  if (fileType == 4) {
        
        self.image = [UIImage imageNamed:@"group_file_pdf_little.png"];
        
    }
    else  if (fileType == 5) {
        
        self.image = [UIImage imageNamed:@"group_file_ppt_little.png"];
        
    }
    else  if (fileType == 6) {
        
        self.image = [UIImage imageNamed:@"group_file_music_little.png"];
        
    }
    else  if (fileType == 7) {
        
        self.image = [UIImage imageNamed:@"group_file_voide_little.png"];
        
    }
    else  if (fileType == 8) {
        
        self.image = [UIImage imageNamed:@"group_file_other_little.png"];
        
    }
    else
    {
        self.image = nil;
    }
}

- (void)setFileInfo:(FFFileInfo *)fileInfo
{
    if ([fileInfo.fileType isEqualToString:@"wps"] || [fileInfo.fileType isEqualToString:@"doc"] || [fileInfo.fileType isEqualToString:@"docx"] ) {
        
        [self setFileType:1];
    }
    else if ([fileInfo.fileType isEqualToString:@"xls"] || [fileInfo.fileType isEqualToString:@"xlsx"])
    {
        [self setFileType:2];
    }
    else if ([fileInfo.fileType isEqualToString:@"txt"] || [fileInfo.fileType isEqualToString:@"html"])
    {
        [self setFileType:3];
    }
    else if ([fileInfo.fileType isEqualToString:@"pdf"])
    {
        [self setFileType:4];
    }
    else if ([fileInfo.fileType isEqualToString:@"ppt"] || [fileInfo.fileType isEqualToString:@"pptx"])
    {
        [self setFileType:5];
    }
    else if ([fileInfo.fileType isEqualToString:@"mp3"] || [fileInfo.fileType isEqualToString:@"cda"] || [fileInfo.fileType isEqualToString:@"wav"] || [fileInfo.fileType isEqualToString:@"wma"] || [fileInfo.fileType isEqualToString:@"ra"] || [fileInfo.fileType isEqualToString:@"rma"] || [fileInfo.fileType isEqualToString:@"wma"] || [fileInfo.fileType isEqualToString:@"asf"] || [fileInfo.fileType isEqualToString:@"mid"]|| [fileInfo.fileType isEqualToString:@"midi"] || [fileInfo.fileType isEqualToString:@"rmi"] || [fileInfo.fileType isEqualToString:@"xmi"] || [fileInfo.fileType isEqualToString:@"mid"] || [fileInfo.fileType isEqualToString:@"ogg"] || [fileInfo.fileType isEqualToString:@"vqf"] || [fileInfo.fileType isEqualToString:@"mod"] || [fileInfo.fileType isEqualToString:@"ape"] || [fileInfo.fileType isEqualToString:@"aiff"] || [fileInfo.fileType isEqualToString:@"aac"] || [fileInfo.fileType isEqualToString:@"au"])
    {
        [self setFileType:6];
    }
    else if ([fileInfo.fileType isEqualToString:@"mp4"] || [fileInfo.fileType isEqualToString:@"mov"] || [fileInfo.fileType isEqualToString:@"wmv"] || [fileInfo.fileType isEqualToString:@"asf"] || [fileInfo.fileType isEqualToString:@"rm"] || [fileInfo.fileType isEqualToString:@"avi"] || [fileInfo.fileType isEqualToString:@"vob"] || [fileInfo.fileType isEqualToString:@"dat"])
    {
        [self setFileType:7];
    }
    else
    {
        [self setFileType:8];
    }
    
}


- (void)setBigIconFileInfo:(FFFileInfo *)bigIconFileInfo
{
    if ([bigIconFileInfo.fileType isEqualToString:@"wps"] || [bigIconFileInfo.fileType isEqualToString:@"doc"] || [bigIconFileInfo.fileType isEqualToString:@"docx"] || [bigIconFileInfo.fileType isEqualToString:@"wps"] ) {
        
        self.image = [UIImage imageNamed:@"group_file_word_big.png"];
    }
    else if ([bigIconFileInfo.fileType isEqualToString:@"xls"] || [bigIconFileInfo.fileType isEqualToString:@"xlsx"])
    {
        self.image = [UIImage imageNamed:@"group_file_excel_big.png"];
    }
    else if ([bigIconFileInfo.fileType isEqualToString:@"txt"] || [bigIconFileInfo.fileType isEqualToString:@"html"])
    {
        self.image = [UIImage imageNamed:@"group_file_txt_big.png"];
    }
    else if ([bigIconFileInfo.fileType isEqualToString:@"pdf"])
    {
        self.image = [UIImage imageNamed:@"group_file_pdf_big.png"];
    }
    else if ([bigIconFileInfo.fileType isEqualToString:@"ppt"] || [bigIconFileInfo.fileType isEqualToString:@"pptx"])
    {
        self.image = [UIImage imageNamed:@"group_file_ppt_big.png"];
    }
    else if ([bigIconFileInfo.fileType isEqualToString:@"mp3"] || [bigIconFileInfo.fileType isEqualToString:@"cda"] || [bigIconFileInfo.fileType isEqualToString:@"wav"] || [bigIconFileInfo.fileType isEqualToString:@"wma"] || [bigIconFileInfo.fileType isEqualToString:@"ra"] || [bigIconFileInfo.fileType isEqualToString:@"rma"] || [bigIconFileInfo.fileType isEqualToString:@"wma"] || [bigIconFileInfo.fileType isEqualToString:@"asf"] || [bigIconFileInfo.fileType isEqualToString:@"mid"]|| [bigIconFileInfo.fileType isEqualToString:@"midi"] || [bigIconFileInfo.fileType isEqualToString:@"rmi"] || [bigIconFileInfo.fileType isEqualToString:@"xmi"] || [bigIconFileInfo.fileType isEqualToString:@"mid"] || [bigIconFileInfo.fileType isEqualToString:@"ogg"] || [bigIconFileInfo.fileType isEqualToString:@"vqf"] || [bigIconFileInfo.fileType isEqualToString:@"mod"] || [bigIconFileInfo.fileType isEqualToString:@"ape"] || [bigIconFileInfo.fileType isEqualToString:@"aiff"] || [bigIconFileInfo.fileType isEqualToString:@"aac"] || [bigIconFileInfo.fileType isEqualToString:@"au"])
    {
        self.image = [UIImage imageNamed:@"group_file_music_big.png"];
    }
    else if ([bigIconFileInfo.fileType isEqualToString:@"mp4"] || [bigIconFileInfo.fileType isEqualToString:@"mov"] || [bigIconFileInfo.fileType isEqualToString:@"wmv"] || [bigIconFileInfo.fileType isEqualToString:@"asf"] || [bigIconFileInfo.fileType isEqualToString:@"rm"] || [bigIconFileInfo.fileType isEqualToString:@"avi"] || [bigIconFileInfo.fileType isEqualToString:@"vob"] || [bigIconFileInfo.fileType isEqualToString:@"dat"])
    {
        self.image = [UIImage imageNamed:@"group_file_voide_big.png"];
    }
    else
    {
        self.image = [UIImage imageNamed:@"group_file_other_big.png"];
    }
    
}

@end
