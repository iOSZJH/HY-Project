//
//  CommentCell.h
//  HY_Project
//
//  Created by 张锦辉 on 15/5/12.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
{
    UIImageView*bgImageView;
    UIImageView*titleImageView;
    UILabel*titleLabe;
    UILabel*commentLable;
    UILabel*timelabel;
}

-(void)configModel:(HYCommentModel *)model;

@end
