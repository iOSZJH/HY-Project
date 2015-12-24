//
//  PictureCell.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/6.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "PictureCell.h"

@interface PictureCell ()
{
    CustomView *customView;
    UIImageView *titleView;
    UILabel*titleLabe;
    UILabel*iconLable;
    UILabel*commentLabel;
    UILabel*shareLabel;
    UIButton *btn;
    
    UIImageView*imageView;//图片
    CGRect rect;
    UIImageView*bgImageView;
    CGFloat height;
    CGFloat width;
}

@end

@implementation PictureCell

-(void)configModel:(HYGroupModel *)model {
    HYGroupUserModel *userModel = model.user;
    [titleView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar_url] placeholderImage:[UIImage imageNamed:@"big_defaulthead_head"]];
    titleLabe.text = userModel.name;
    titleLabe.font = [UIFont boldSystemFontOfSize:15];
    titleLabe.textColor = [UIColor grayColor];
    iconLable.text = model.content;
    
    //内容
    iconLable.text = model.content;
    iconLable.numberOfLines = 0;
    rect = [model.content boundingRectWithSize:CGSizeMake(220, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil];
    iconLable.frame = CGRectMake(titleView.frame.origin.x + 5, 41, WIDTH-2*titleView.frame.origin.x-10, rect.size.height);
    
    PictureModel *photoModel = [[PictureModel alloc] init];
    if (self.isDetails == NO) {
       photoModel = model.middle_image;
    } else {
    
        photoModel = model.large_image;
    }
    height = [photoModel.height floatValue];
    width = [photoModel.width floatValue];
    
    CGFloat num = [model.max_screen_width_percent floatValue];
    CGFloat num2 = [model.min_screen_width_percent floatValue];
    if (width>WIDTH) {
        if (self.isDetails == NO) {
            width = width * num;
        }else {
             width = width * num2;
            height = height * num;
        }
    }
   
    NSString*str= photoModel.url_list[1][@"url"];
    //图片自适配
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView sd_setImageWithURL:[NSURL URLWithString:str]];
    imageView.frame=CGRectMake(5, rect.size.height + 45, WIDTH-10, height);
    customView.frame=CGRectMake(0, height + rect.size.height + 50, WIDTH, 40);
    [customView configModel:model];
    bgImageView.frame=CGRectMake(3, 3, WIDTH-6, rect.size.height+height + 45 + 40);
    
    if (self.isDetails==NO) {
        [btn removeFromSuperview];
    }
    else {
        btn.frame = CGRectMake(WIDTH/2-20, height/2-20, 40, 40);
        if (model.middle_image == nil) {
            [btn removeFromSuperview];
        }
        [customView removeFromSuperview];
        bgImageView.frame = CGRectMake(3, 3, WIDTH-6, rect.size.height+height+45+20);
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

    bgImageView=[ZCControl createImageViewWithFrame:CGRectMake(3, 2, WIDTH-6, 100) ImageName:@"bgImageView"];
    bgImageView.layer.cornerRadius = 8;
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
    
    //文字
    iconLable=[ZCControl createLabelWithFrame:CGRectMake(15,36,WIDTH-20,30) Font:14 Text:nil];
    iconLable.numberOfLines = 0;
    iconLable.textColor = COLOR;
    [self.contentView addSubview:iconLable];
    
    //图片;
    imageView = [ZCControl createImageViewWithFrame:CGRectMake(5, 60, 300, 100) ImageName:nil];
    [self.contentView addSubview:imageView];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(WIDTH/2-20, 20, 40, 40);
    [btn setBackgroundImage:[UIImage imageNamed:@"downloadicon_textpage"] forState: UIControlStateNormal];
    btn.tag = 3000;
    [imageView addSubview:btn];
    
    //评论分享视图
    if (self.isDetails==NO) {
        customView=[[CustomView alloc]init];
        customView.tag=600;
        [self.contentView addSubview:customView];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
