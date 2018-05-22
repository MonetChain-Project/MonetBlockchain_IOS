//
//  FFFileInfo.m
//  FireFly
//
//  Created by Rain on 17/11/29.
//  Copyright © 2017年 MonetBlockchain Foundation. All rights reserved.
//

#import "FFFileInfo.h"

@implementation FFFileInfo

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        self.fid = [[[dic objectForKey:@"fid"] asNSNumber] integerValue];
        self.fileURL = [[dic objectForKey:@"fileurl"] asNSString];
        
        self.fileName = [self.fileURL lastPathComponent];
        
        self.userName = [[dic objectForKey:@"username"] asNSString];
        
        self.fileSize = [[dic objectForKey:@"filesize"] doubleValue];
        self.fileType = [[self.fileURL pathExtension] lowercaseString];
        self.fileSourceName = [[dic objectForKey:@"source"] asNSString];
        self.fileSource = [[dic objectForKey:@"filetype"] integerValue];
        
        self.isDel = [[dic objectForKey:@"isdel"] integerValue];
        self.isCollect = [[dic objectForKey:@"isCollect"] integerValue];
        
        self.collectTime = [[dic objectForKey:@"collecttime"] asNSString];
        
        NSInteger time = [[dic objectForKey:@"dateline"] integerValue];
//        self.dateline = [NADate dateSocialByDiffStr:[NADate dateStringByTimeStamp:time]];
        
        self.expireTime = [[dic objectForKey:@"expiretime"] asNSString];
        
        self.fileDate = [[dic objectForKey:@"fileDate"] asNSString];
        
    }
    
    return self;
}

-(void)setFileName:(NSString *)fileName
{
    _fileName = fileName;
    NSRange rang = [_fileName rangeOfString:@"_" options:NSBackwardsSearch];
    if (rang.location != NSNotFound) {
//        self.showFileName = [[_fileName substringFromIndex:rang.location + 1] URLDecoding];
    }
    else
    {
        self.showFileName = _fileName;
    }
}

-(void)setFileSize:(double)fileSize
{
    _fileSize = fileSize;
    self.formatFileSize = LC_NSSTRING_FORMAT(@"%f",fileSize);
}

-(void)setFormatFileSize:(NSString *)formatFileSize
{
    if ([formatFileSize containsString:@"B"] || [formatFileSize containsString:@"K"] || [formatFileSize containsString:@"M"] || [formatFileSize containsString:@"G"] || [formatFileSize containsString:@"T"]) {
        
        _formatFileSize = formatFileSize;
        return;
    }
    
    double size = [formatFileSize doubleValue];
    
    if (size > 0 && size < pow(2,10)) {
        
        _formatFileSize = LC_NSSTRING_FORMAT(@"%dB",(int)size);
    }
    else if (size >= pow(1,20) && size < pow(2,20)) {
        
        _formatFileSize = LC_NSSTRING_FORMAT(@"%.1fK",size * 1.0/pow(2,10));
    }
    else if(size >= pow(2,20) && size < pow(2,30))
    {
        _formatFileSize = LC_NSSTRING_FORMAT(@"%.1fM",size/pow(2,20));
    }
    else if (size >= pow(2,30) && size < pow(2,40))
    {
        _formatFileSize = LC_NSSTRING_FORMAT(@"%.1fG",size/pow(2,30));
    }
    else if (size >= pow(2,40) && size < pow(2,50))
    {
        _formatFileSize = LC_NSSTRING_FORMAT(@"%.1fT",size/pow(2,40));
    }
}

- (NSString *)fileType
{
    if (_fileType) {
        return [_fileType lowercaseString];
    }
    return _fileType;
}

- (void)setFileURL:(NSString *)fileURL
{
    _fileURL  = fileURL;
    if (_fileURL) {
        _fileType = [[_fileURL pathExtension] lowercaseString];
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    FFFileInfo * fileInfo = [[[self class] allocWithZone:zone] init];
    fileInfo.fid = self.fid;
    fileInfo.fileName = self.fileName;
    fileInfo.showFileName = self.showFileName;
    fileInfo.fileSize = self.fileSize;
    fileInfo.fileURL = self.fileURL;
    fileInfo.fileType = self.fileType;
    fileInfo.userName = self.userName;
    fileInfo.fileDate = self.fileDate;
    fileInfo.fileSource= self.fileSource;
    fileInfo.fileSourceName = self.fileSourceName;
    
    fileInfo.dateline = self.dateline;
    fileInfo.expireTime = self.expireTime;
    fileInfo.webFileURL = self.webFileURL;
    fileInfo.groupId = self.groupId;
    fileInfo.status = self.status;
    fileInfo.isDel = self.isDel;
    fileInfo.isCollect = self.isCollect;
    
    fileInfo.formatFileSize = self.formatFileSize;
    fileInfo.collectTime = self.collectTime;
    fileInfo.videoAsset = self.videoAsset;
    fileInfo.videoUrl = self.videoUrl;
    
    return fileInfo;
}

@end
