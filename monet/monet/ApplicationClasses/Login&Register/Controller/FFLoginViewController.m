//
//  FFLoginViewController.m
//  MonetBlockchain
//
//  Created by Megan on 2017/9/20.
//  Copyright © 2017年 MonetBlockchain Foundation All rights reserved.
//

#import "FFLoginViewController.h"
#import "WSPageView.h"
#import "WSIndexBanner.h"
#import "FFSignUpViewController.h"
#import "FFUserLoginViewController.h"
#import "FFSignUpVC.h"

@interface FFLoginViewController ()<WSPageViewDelegate,WSPageViewDataSource>
{
    UILabel  * _tipsLabel;
    UIButton * _sighLabel;
    UIButton * _loginLabel;
}

@property (nonatomic,strong) WSPageView * pageView;

@property (nonatomic,strong) NSMutableArray * imgURLArray;

@property (nonatomic,strong) NSMutableArray * imageArray;

@end

@implementation FFLoginViewController

- (void)dealloc
{
    if (_pageView.timer) {
        
        [_pageView.timer invalidate];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.imgURLArray = [NSMutableArray arrayWithObjects:@"http://beta.youxi01.cn/Uploads/avatar/2/13969_CvlTDa.jpg",@"http://beta.youxi01.cn/Uploads/avatar/2/13969_CvlTDa.jpg",@"http://beta.youxi01.cn/Uploads/avatar/2/13969_CvlTDa.jpg", nil];
    
    self.imageArray = [[NSMutableArray alloc] initWithObjects:@"pageView1",@"pageView2",@"pageView3" ,nil];
    
    [self creatUI];
}

- (void)creatUI {
    
    _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, DDYSCREENW - 20, 35)];
    _tipsLabel.text = @"Welcome to MonetBlockchain!";
    _tipsLabel.font = NA_FONT(32);
    _tipsLabel.textColor = LC_RGB(42, 42, 42);
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_tipsLabel];
    
    _pageView = [[WSPageView alloc]initWithFrame:CGRectMake(0, 120, DDYSCREENW, DDYSCREENH*0.52)];
    _pageView.delegate = self;
    _pageView.dataSource = self;
    _pageView.minimumPageAlpha = 0.4;   //非当前页的透明比例
    _pageView.minimumPageScale = 0.85;  //非当前页的缩放比例
    _pageView.orginPageCount = self.imageArray.count; //原始页数
    _pageView.autoTime = 3;    //自动切换视图的时间,默认是5.0
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _pageView.frame.size.height - 10, DDYSCREENW, 8)];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    _pageView.pageControl = pageControl;
    [_pageView addSubview:pageControl];
    [_pageView startTimer];
    [self.view addSubview:_pageView];
    
    _sighLabel = [[UIButton alloc] initWithFrame:CGRectMake(37.5, DDYSCREENH - 130, DDYSCREENW - 75, 50)];
    [_sighLabel setTitle:DDYLocalStr(@"GuideSignup") forState:UIControlStateNormal];
    _sighLabel.titleLabel.font = [UIFont systemFontOfSize: 18];
    _sighLabel.backgroundColor = LC_RGB(248, 220, 74);
    [_sighLabel setTitleColor:LC_RGB(51, 51, 51) forState:UIControlStateNormal];
    _sighLabel.layer.cornerRadius = 25;
    _sighLabel.layer.masksToBounds = YES;
    [self.view addSubview:_sighLabel];
    
    _loginLabel = [[UIButton alloc] initWithFrame:CGRectMake(37.5, DDYSCREENH - 70, DDYSCREENW - 75, 50)];
    [_loginLabel setTitle:DDYLocalStr(@"GuideLogin") forState:UIControlStateNormal];
    _loginLabel.titleLabel.font = [UIFont systemFontOfSize: 18];
    [_loginLabel setTitleColor:LC_RGB(51, 51, 51) forState:UIControlStateNormal];
    _loginLabel.backgroundColor = LC_RGB(248, 220, 74);
    _loginLabel.layer.cornerRadius = 25;
    _loginLabel.layer.masksToBounds = YES;
    [self.view addSubview:_loginLabel];
    
    [_sighLabel addTarget:self action:@selector(signAction) forControlEvents:UIControlEventTouchUpInside];
    [_loginLabel addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(WSPageView *)flowView {
    return CGSizeMake(DDYSCREENW - 84, DDYSCREENH*0.45);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(WSPageView *)flowView {
    return self.imageArray.count;
}

- (UIView *)flowView:(WSPageView *)flowView cellForPageAtIndex:(NSInteger)index{
    WSIndexBanner *bannerView = (WSIndexBanner *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[WSIndexBanner alloc] initWithFrame:CGRectMake(0, 0, DDYSCREENW - 84, DDYSCREENH*0.45)];
        bannerView.layer.cornerRadius = 20;
        bannerView.layer.masksToBounds = YES;
    }
    
        bannerView.mainImageView.image = [UIImage imageNamed:self.imageArray[index]];
//    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.imgURLArray[index]]];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(WSPageView *)flowView {
    
}

- (void)signAction
{
    FFSignUpVC * controller = [[FFSignUpVC alloc] init];
    controller.viewType = SignupType;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)loginAction
{
    FFSignUpVC * controller = [[FFSignUpVC alloc] init];
    controller.viewType = LoginType;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
