//
//  HYTabBarController.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/4.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "HYTabBarController.h"
#import "DuanziViewController.h"
#import "FindViewController.h"
#import "PictureViewController.h"
#import "VideoViewController.h"

#import "HYNavigationController.h"
#import "HYTabBar.h"

@interface HYTabBarController()<HYTabBarDelegate>
{
    HYTabBar *custTabBar;
}

@property (nonatomic, weak)HYTabBar *custTabBar;
@end

@implementation HYTabBarController


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self addTabBar];
    [self createChildViewController];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

-(void)addTabBar {
   custTabBar = [[HYTabBar alloc] init];
    custTabBar.delegate = self;
    custTabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
    custTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:custTabBar];
    self.custTabBar = custTabBar;
}

-(void)pushSlectIndex:(NSInteger)index {
    
    self.selectedIndex = index;
}

-(void)createChildViewController
{
    NSDate*dateNow=[NSDate date];
    NSString*nowTimeStr=[NSString stringWithFormat:@"%ld",(long)[dateNow timeIntervalSince1970]];
//    NSString*timeStr=[NSString stringWithFormat:@"%ld",[nowTimeStr integerValue]-1000];
    
    //段子
    DuanziViewController *duanziVC = [[DuanziViewController alloc] init];
    duanziVC.urlStr = MAIN_URL;
    duanziVC.category_id = @"1";//duanziVC.arr1[arc4random()%duanziVC.arr1.count];
    duanziVC.level = @"6";
    duanziVC.numOfVeiw = 1;
    duanziVC.min_time = nowTimeStr;
    duanziVC.title = @"搞笑段子";
    [self setupChildViewController:duanziVC imageName:@"article_night" selectedImageName:@"article_press"withTitle:duanziVC.title];
    
    //图片
    PictureViewController *pictureVC = [[PictureViewController alloc] init];
    pictureVC.urlStr = MAIN_URL;
    pictureVC.category_id =@"2"; //pictureVC.arr2[arc4random()%pictureVC.arr2.count];
    pictureVC.level = @"6";
    pictureVC.numOfVeiw = 1;
    pictureVC.min_time = nowTimeStr;
    pictureVC.title = @"搞笑图片";
    [self setupChildViewController:pictureVC imageName:@"picture_night.png" selectedImageName:@"picture_press.png"withTitle:pictureVC.title];
    
    //视频
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    videoVC.urlStr = MAIN_URL;
    videoVC.category_id = @"18";//videoVC.arr3[arc4random()%videoVC.arr3.count];
    videoVC.level = @"6";
    videoVC.numOfVeiw = 1;
    videoVC.title = @"搞笑视频";
    videoVC.min_time = nowTimeStr;
    [self setupChildViewController:videoVC imageName:@"video_night.png" selectedImageName:@"video_press.png"withTitle:videoVC.title];
}

- (void)setupChildViewController:(UIViewController *)vc imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName withTitle :(NSString *)title
{
    //设置数据
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    HYNavigationController *nvc = [[HYNavigationController alloc] initWithRootViewController:vc];
    vc.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc]
                                            initWithTitle:nil style:UIBarButtonItemStyleDone target:nil action:nil];
    vc.title = title;
    vc.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background@2x"]];
    [self addChildViewController:nvc];
    
    [self.custTabBar addTabBarButtonWithItem:vc.tabBarItem];
}

@end
