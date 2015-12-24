//
//  DuanziCell.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/6.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "DuanziCell.h"

@interface DuanziCell()
{
    CustomView *customView;
    UIImageView *titleView;
    UILabel*titleLabe;
    UILabel*iconLable;
    UILabel*commentLabel;
    UILabel*shareLabel;
    
    //图片
    UIImageView*photoImageView;
    CGRect rect;
    UIImageView*bgImageView;
}

@end

@implementation DuanziCell

-(void)configModel:(HYGroupModel *)model {
    HYGroupUserModel *userModel = model.user;
    [titleView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar_url] placeholderImage:[UIImage imageNamed:@"big_defaulthead_head"]];
    titleLabe.text = userModel.name;
    titleLabe.font = [UIFont boldSystemFontOfSize:15];
    titleLabe.textColor = [UIColor grayColor];
    
    iconLable.text = model.content;
    rect = [model.content boundingRectWithSize:CGSizeMake(220, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil];
    iconLable.frame = CGRectMake(titleView.frame.origin.x + 5, 41, WIDTH-2*titleView.frame.origin.x-10, rect.size.height);
    
    bgImageView.frame = CGRectMake(2, 2, WIDTH-4, rect.size.height+45+44);
    bgImageView.backgroundColor = [UIColor lightGrayColor];
     self.H = bgImageView.frame.size.height;
    customView.frame = CGRectMake(0, rect.size.height+3+41, WIDTH, 40);
    [customView configModel:model];
    
    if (self.isDetails == YES) {
        [customView removeFromSuperview];
        bgImageView.frame = CGRectMake(2, 2, WIDTH-4, rect.size.height+45+20);
    }
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
        
    }
    return self;
}

-(void)makeUI {
    //背景
    bgImageView=[ZCControl createImageViewWithFrame:CGRectMake(3, 2, WIDTH-6, 100) ImageName:@"bgImageView"];
    bgImageView.layer.cornerRadius = 8;
    bgImageView.backgroundColor = [UIColor clearColor];
    bgImageView.layer.borderColor = [COLOR CGColor];
    bgImageView.layer.borderWidth = 2;
    [self.contentView addSubview:bgImageView];
    
    //用户头像
    titleView=[ZCControl createImageViewWithFrame:CGRectMake(10, 10, 30, 30) ImageName:nil];
    titleView.layer.cornerRadius=15;
    titleView.layer.masksToBounds=YES;
    [self.contentView addSubview:titleView];
    
    //用户昵称
    titleLabe=[ZCControl createLabelWithFrame:CGRectMake(50, 10, 200, 30) Font:14 Text:nil];
    [self.contentView addSubview:titleLabe];
    
    //内容页面
    iconLable=[ZCControl createLabelWithFrame:CGRectMake(15,36,WIDTH-20,30) Font:14 Text:nil];
    iconLable.numberOfLines = 0;
    iconLable.textColor = COLOR;
    [self.contentView addSubview:iconLable];
    
    //评论分享视图
    customView=[[CustomView alloc]initWithFrame:CGRectMake(0, 100, WIDTH, 40)];
    customView.tag=500;
    [self.contentView addSubview:customView];

}



- (void)awakeFromNib {
        // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
