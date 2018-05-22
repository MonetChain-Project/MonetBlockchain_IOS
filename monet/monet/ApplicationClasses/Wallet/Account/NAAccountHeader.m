//
//  NAAccountHeader.m
//  MonetBlockchain
//
//  Created by Rain on 15/9/11.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.

#import "NAAccountHeader.h"
#import "AvatarImg.h"

@interface NAAccountHeader ()

@property (nonatomic, strong) UIImageView *avatarView;

@property (nonatomic, strong) DDYButton *btnName;

@property (nonatomic, strong) UILabel *labKey;

@property (nonatomic, strong) DDYButton *btnQRCode;

@property (nonatomic, strong) DDYButton *btnTransaction;

@property (nonatomic, strong) DDYButton *btnCopy;

@property (nonatomic, strong) UILabel *tipLab;

@property (nonatomic, strong) UILabel *statusLab;

@end

@implementation NAAccountHeader

+ (instancetype)headView:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame])
    {
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView
{
    _avatarView = UIImageViewNew;
    _avatarView.image = [UIImage imageNamed:@"defaul_head_icon"];
    _avatarView.userInteractionEnabled = YES;
    [_avatarView addTapTarget:self action:@selector(handleNameClick:)];
    
    _btnName = [DDYButton customDDYBtn].btnFont(NAFont(16)).btnTitleColorN([UIColor blackColor]).btnAction(self, @selector(handleNameClick:));
    
    _statusLab = UILabelNew.labFont(NAFont(9)).labTextColor([UIColor blackColor]).labAlignmentCenter();
#warning tmp: 暂时隐藏;
    _statusLab.hidden = YES;
    
    _labKey = [[UILabel alloc] init];
    _labKey.font = NAFont(13);
    _labKey.textColor = rgba(51,51,51,1);
    _labKey.textAlignment = NSTextAlignmentCenter;
    _labKey.lineBreakMode = NSLineBreakByTruncatingMiddle;
    
    _btnQRCode = [DDYButton customDDYBtn].btnImgNameN(@"wallet_qrcode_icon").btnTitleN(@"QR code").btnFont(NAFont(12)).btnTitleColorN(LC_RGB(51, 51, 51));
    _btnQRCode.btnAction(self, @selector(handleCode));
    
    _btnTransaction = [DDYButton customDDYBtn].btnImgNameN(@"wallet_record_icon").btnTitleN(@"Transaction").btnFont(NAFont(12)).btnTitleColorN(LC_RGB(51, 51, 51));
    _btnTransaction.btnAction(self, @selector(handleTransaction));
    
    _btnCopy = [DDYButton customDDYBtn].btnImgNameN(@"wallet_address_icon").btnTitleN(@"Copy the address").btnFont(NAFont(12)).btnTitleColorN(LC_RGB(51, 51, 51));
    _btnCopy.btnAction(self, @selector(handleCopy));
    
    [self addSubview:_avatarView];
    [self addSubview:_btnName];
    [self addSubview:_labKey];
    [self addSubview:_btnQRCode];
    [self addSubview:_btnTransaction];
    [self addSubview:_btnCopy];
    [self addSubview:_statusLab];
}

- (void)layoutContentView
{
    _avatarView.viewSetFrame(NASCREENW/2-25, 15, 60, 60);
    
    [_btnName sizeToFit];
    _btnName.btnFrame(0, _avatarView.ddy_bottom+15, _btnName.ddy_w+4, 17);
    _btnName.ddy_centerX = NASCREENW/2.0;
    
    _labKey.frame = CGRectMake(50, _btnName.ddy_bottom+8, NASCREENW - 50 * 2, 15);
    
    _btnQRCode.btnFrame(0, _labKey.ddy_bottom+25, 60, 60).btnLayoutStyle(DDYBtnStyleImgTop).btnPadding(7);
    
    _btnTransaction.btnFrame(0, _labKey.ddy_bottom+25, 60, 60).btnLayoutStyle(DDYBtnStyleImgTop).btnPadding(7);
    
    _btnCopy.btnFrame(0, _labKey.ddy_bottom+25, 60, 60).btnLayoutStyle(DDYBtnStyleImgTop).btnPadding(7);
    
    _btnQRCode.ddy_centerX = NASCREENW/6.0;
    
    _btnTransaction.ddy_centerX = 3 * NASCREENW/6.0;
    
    _btnCopy.ddy_centerX = 5 * NASCREENW/6.0;
    
    NABorderRadius(_avatarView, 30, 0, [UIColor clearColor]);
    
    [_statusLab sizeToFit];
    _statusLab.frame = CGRectMake(_btnName.ddy_right+9, 0, _statusLab.ddy_w+14, 17);
    _statusLab.ddy_centerY = _btnName.ddy_centerY;
    NABorderRadius(_statusLab, _statusLab.ddy_h/2.0, 0.56, [UIColor whiteColor]);
}

- (void)handleNameClick:(UIButton *)sender {
    if (_address && self.accountBlock) {
        self.accountBlock(_address);
    }
}

- (void)handleCode {
    if (self.qrCodeBlock) {
        self.qrCodeBlock();
    }
}

- (void)handleTransaction
{
    if (self.transactionBlock) {
        self.transactionBlock();
    }
}

- (void)handleCopy
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _labKey.text;
    
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    if (!keyWindow) { keyWindow = [[UIApplication sharedApplication] keyWindow];}
    [keyWindow addSubview:self.tipLab];
    self.tipLab.hidden = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideTip) object:nil];
    [self performSelector:@selector(hideTip) withObject:nil afterDelay:2];
}

- (UILabel *)tipLab
{
    if (!_tipLab) {
        _tipLab = [[UILabel alloc] init];
        _tipLab.text = @"已复制到剪切板";
        _tipLab.font = NAFont(13);
        _tipLab.textAlignment = NSTextAlignmentCenter;
        _tipLab.textColor = [UIColor whiteColor];
        _tipLab.backgroundColor = [UIColor blackColor];
        _tipLab.frame = CGRectMake(0, 0, 125, 30);
        _tipLab.center = CGPointMake(NASCREENW/2.0, self.ddy_h+25+64);
        NABorderRadius(_tipLab, 4, 0, [UIColor clearColor]);
    }
    return _tipLab;
}

- (void)hideTip
{
    self.tipLab.hidden = YES;
    [self.tipLab removeFromSuperview];
    self.tipLab = nil;
}

- (void)setAddress:(Address *)address
{
    _address = address;
    _btnName.btnTitleN([WALLET nicknameForAccount:address]);
    
    _labKey.text = address.checksumAddress;
    _avatarView.image = [AvatarImg avatarImgFromAddress:address];
//    _avatarView.image = [UIImage imageNamed:@"defaul_head_icon"];
    
    _statusLab.labText(@"观察");
    
    [self layoutContentView];
}

@end
