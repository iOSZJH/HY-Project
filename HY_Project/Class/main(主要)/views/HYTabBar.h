//
//  HYTabBar.h
//  HY_Project
//
//  Created by 张锦辉 on 15/5/4.
//  Copyright (c) 2015年 张锦辉. All rights reserved.

//对分栏控制器item进行封装

#import <UIKit/UIKit.h>

@protocol HYTabBarDelegate <NSObject>

-(void)pushSlectIndex :(NSInteger)index;
@end

@interface HYTabBar : UIView

@property (nonatomic, assign) id<HYTabBarDelegate>delegate;

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@end