
//
//  FFNavigationController.m
//  MonetBlockchain
//
//  Created by RainDou on 18/1/16.
//  Copyright © 2015年 RainDou All rights reserved.
//

#import "FFNavigationController.h"

@interface FFNavigationController ()

@end

@implementation FFNavigationController


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 为0则代表进入二级界面，需要设置返回样式
    if (self.viewControllers.count > 0) {
        /* 左按钮 */
        DDYButton *backBtn = [DDYButton customDDYBtn].btnImgNameN(@"icon_back").btnAction(self, @selector(backBtnClick:)).btnW(30).btnH(30);
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        backBtn.backgroundColor = [UIColor redColor];
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        // push后页面隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 如果把判断写到前面，当单个页面在自己的控制器中修改时又被覆盖掉，导致更换失败
    [super pushViewController:viewController animated:animated];
}

#pragma mark - leftButtonTouch
- (void)backBtnClick:(DDYButton *)button
{
    [self popViewControllerAnimated:YES];

    if (self.popClicked) {
        self.popClicked();
    }
}

#pragma mark - 控制旋转屏幕
#pragma mark 支持旋转的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}
#pragma mark 是否支持自动旋转
- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}
#pragma mark 状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.topViewController preferredStatusBarStyle];
}

@end
