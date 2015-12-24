//
//  RootViewController.h
//  HY_Project
//
//  Created by 张锦辉 on 15/5/4.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property(strong,nonatomic)NSString *urlStr;//地址
@property(nonatomic,copy)NSString*min_time;//刷新
@property(nonatomic,copy)NSString*max_time;//加载
@property(nonatomic,copy)NSString*category_id;//类别
@property(nonatomic,copy)NSString*level;//分组
@property(nonatomic,strong)NSArray *arr1;
@property(nonatomic,strong)NSArray *arr2;
@property(nonatomic, strong)NSArray *arr3;
@property(nonatomic)NSInteger numOfVeiw;//判断是几级界面

@property(nonatomic, copy)NSString *titleStr;
@property(nonatomic, copy)NSString *desStr;
@property(nonatomic, copy)NSString *imageStr;
@end
