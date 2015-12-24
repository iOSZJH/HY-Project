//
//  FriendCell.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/14.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}

-(void)makeUI {

    titleImage = [ZCControl createImageViewWithFrame:CGRectMake(10, 10, 60, 60) ImageName:nil];
    titleImage.layer.cornerRadius=30;
    titleImage.layer.masksToBounds=YES;
    [self.contentView addSubview:titleImage];
    
    nameLabel=[ZCControl createLabelWithFrame:CGRectMake(100, 10, 200, 30) Font:16 Text:nil];
    nameLabel.textColor= COLOR;
    [self.contentView addSubview:nameLabel];
    
    desLabel=[ZCControl createLabelWithFrame:CGRectMake(100, 48, 200, 20) Font:12 Text:nil];
    desLabel.textColor=[UIColor grayColor];
    [self.contentView addSubview:desLabel];
}

-(void)configModel:(HYGroupModel *)model {
    HYGroupUserModel *userModel = model.user;
    [titleImage sd_setImageWithURL:[NSURL URLWithString:userModel.avatar_url] placeholderImage:[UIImage imageNamed:@"big_defaulthead_head"]];
    nameLabel.text = userModel.name;
    nameLabel.textColor = COLOR;
    
    NSInteger i = arc4random() % 1000;
    desLabel.text = [NSString stringWithFormat:@"距离%ld米。",i];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
