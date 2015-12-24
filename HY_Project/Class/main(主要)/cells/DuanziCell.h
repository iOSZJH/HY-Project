//
//  DuanziCell.h
//  HY_Project
//
//  Created by 张锦辉 on 15/5/6.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DuanziCell : UITableViewCell

@property(nonatomic)BOOL isDetails;//是否进入详情
@property(nonatomic,assign) CGFloat H;

-(void)configModel:(HYGroupModel *)model;


@end
