//
//  VideowCell.h
//  HY_Project
//
//  Created by 张锦辉 on 15/5/6.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideowCell : UITableViewCell

-(void)configModel:(VideoModel *)model;
@property(nonatomic)BOOL isDetails;//判断是否是详情，如果是，则图片放大
@property (nonatomic, assign)NSInteger H;

@end
