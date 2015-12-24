//
//  CustomView.h
//  HY_Project
//
//  Created by 张锦辉 on 15/5/6.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//
//cell 上视图的自定制，评论，分享

#import <UIKit/UIKit.h>

@interface CustomView : UIView
{
    UILabel *commentsLabel;
    UILabel *shareLabel;
}

@property (nonatomic, strong) UIControl *control;
-(void)configModel:(id)model;

@end
