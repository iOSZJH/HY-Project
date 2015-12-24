//
//  HYDelailsViewController.h
//  HY_Project
//
//  Created by 张锦辉 on 15/5/11.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYDelailsViewController : UIViewController

@property(nonatomic,copy)NSString*group_id;
@property(nonatomic,copy)NSString*UrlStr;//地址
@property(nonatomic,assign)NSInteger category;//判断是文字还是图片
@property(nonatomic,strong)HYGroupModel *model;
@property(nonatomic,strong)VideoModel *vModel;
@property(nonatomic,assign)NSNumber*numComments;


@end
