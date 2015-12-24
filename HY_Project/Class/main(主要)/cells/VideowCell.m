//
//  VideowCell.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/6.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "VideowCell.h"
#import "PlayViewController.h"
@interface VideowCell ()

{
    UIImageView*bgImageView;
    CustomView *customView;
    UIImageView *titleView;
    UILabel*titleLabe;
    UILabel*iconLable;
    UILabel*commentLabel;
    UILabel*shareLabel;
    UIButton *switchBtn;//开关
    UIButton*button;
    
    UIImageView*imageView;//图片
    CGRect rect;
    CGFloat height;
    CGFloat width;
}
@end

@implementation VideowCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
        
    }
    return self;
}

-(void)makeUI {

    bgImageView=[ZCControl createImageViewWithFrame:CGRectMake(3, 3, WIDTH-6, 100) ImageName:@"bgImageView"];
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
    iconLable=[ZCControl createLabelWithFrame:CGRectMake(15,41,WIDTH-20,30) Font:14 Text:nil];
    iconLable.numberOfLines = 0;
    iconLable.textColor = COLOR;
    [self.contentView addSubview:iconLable];
    
    //图片;
    imageView = [ZCControl createImageViewWithFrame:CGRectMake(5, 60, 300, 100) ImageName:nil];
    [self.contentView addSubview:imageView];
    
    //评论分享视图
    if (self.isDetails==NO) {
        customView=[[CustomView alloc] init];
        customView.tag = 700;
        [self.contentView addSubview:customView];
    }

    //播放开关
    
    switchBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    switchBtn.frame = CGRectMake(WIDTH/2-20, 20, 40, 40) ;
    [switchBtn setBackgroundImage:[UIImage imageNamed:@"playbutton_video_textpage_press@2x"] forState: UIControlStateNormal];
    switchBtn.tag = 2000;
    switchBtn.layer.cornerRadius=20;
    switchBtn.layer.masksToBounds=YES;
    [imageView addSubview:switchBtn];
}

-(void)controlClick:(UIControl*)control
{

}

-(void)configModel:(VideoModel *)model {
    
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
    
    //视频
    NSDictionary *dict1 = model.origin_video;//视频
    NSDictionary *dict2 = model.medium_cover;//图片（视频截图）
    NSDictionary *dict3 = dict2[@"url_list"][1];//视频链接
    NSString *str = dict3[@"url"];//第二个视频链接图片
    height = [dict1[@"height"] floatValue];
    width = [dict1[@"width"] floatValue];
    CGFloat num = 0;
    if (width > WIDTH) {
        num = (WIDTH - 10)/width;
        width = WIDTH- 10;
        height = height * num;
    }
    
    if (self.isDetails == NO) {
        if (height > 400) {
            height = 400;
        }
        height = height-1;
    }
    
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
    imageView.frame=CGRectMake(5, rect.size.height + 41, WIDTH-10, height);
    bgImageView.frame=CGRectMake(3, 3, WIDTH-6, rect.size.height+height +41+40-6);
    switchBtn.frame=CGRectMake(WIDTH/2-20, height/2-20, 40, 40);
    
    if (self.isDetails==NO) {
        customView.frame=CGRectMake(0, height + rect.size.height + 37, WIDTH, 40);
        [customView configModel:model];
    }
    else {
        [customView removeFromSuperview];
        bgImageView.frame = CGRectMake(3, 3, WIDTH-6, rect.size.height+height+45+20);
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
