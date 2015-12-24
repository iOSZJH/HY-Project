//
//  HYNavigationController.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/4.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "HYNavigationController.h"
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

@interface HYNavigationController ()

@end

@implementation HYNavigationController

/**第一次使用这个类的时候会调用(1个类只会调用1次)*/
+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    
    // 2.设置导航栏按钮主题
    [self setupBarButtonItemTheme];
}

/**
 设置导航栏主题
 */
+ (void)setupNavBarTheme
{
    // 取出appearance对象
    
    UINavigationBar *nvaBar = [UINavigationBar appearance];
    //设置背景
    //    if (!iOS7) {
    //        [nvaBar setBackgroundImage:[UIImage imageNamed:@"bar_left"] forBarMetrics:UIBarMetricsDefault];
    //        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    //    }
    nvaBar.barTintColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];// nvaBar.translucent = NO;
    
    // 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor whiteColor];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:19];
    [nvaBar setTitleTextAttributes:textAttrs];
    
}

/**设置导航栏按钮主题*/
+ (void)setupBarButtonItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //    // 设置背景
    //    if (!iOS7) {
    //        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    //        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    //    }
    //
    // 设置文字属性
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor brownColor];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
}

//重写跳转
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {//如果站里有视图，我才影藏下面的控制器
        viewController.hidesBottomBarWhenPushed = YES;
    }//如果不判断那么就会一运行，影藏下面的条
    [super pushViewController:viewController animated:animated];
}

@end
