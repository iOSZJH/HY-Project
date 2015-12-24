//
//  MainSliderViewController.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/4.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "MainSliderViewController.h"
#import "HYTabBarController.h"
#import "SettingViewController.h"

@interface MainSliderViewController ()

@end

@implementation MainSliderViewController

- (void)viewDidLoad {
    
    [self createViewController];
    [super viewDidLoad];

    
}


-(void)createViewController {

    HYTabBarController *tbc = [[HYTabBarController alloc] init];
    self.MainVC = tbc;
    
    SettingViewController *svc = [[SettingViewController alloc] init];
    self.LeftVC = svc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
