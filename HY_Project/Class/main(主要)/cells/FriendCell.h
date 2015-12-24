//
//  FriendCell.h
//  HY_Project
//
//  Created by 张锦辉 on 15/5/14.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCell : UITableViewCell
{
    UIImageView *titleImage ;
    UILabel *nameLabel;
    UILabel *desLabel;
}

-(void)configModel:(HYGroupModel *)model;
@end
