//
//  CommentCell.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/12.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}

-(void)makeUI {

    titleImageView = [ZCControl createImageViewWithFrame:CGRectMake(10, 10, 30, 30) ImageName:@"big_defaulthead_head"];
    titleImageView.layer.cornerRadius=15;
    titleImageView.layer.masksToBounds=YES;
    [self.contentView addSubview:titleImageView];
    
    titleLabe = [ZCControl createLabelWithFrame:CGRectMake(50, 10, 200, 15) Font:15 Text:nil];
    [self.contentView addSubview:titleLabe];
    
    timelabel = [ZCControl createLabelWithFrame:CGRectMake(50, 40, 200, 10) Font:10 Text:nil];
    [self.contentView addSubview:timelabel];
    
    commentLable = [ZCControl createLabelWithFrame:CGRectMake(50, 60, WIDTH-60, 20) Font:12 Text:nil];
    commentLable.numberOfLines=0;
    [self.contentView addSubview:commentLable];
}

-(void)configModel:(HYCommentModel *)model {

    [titleImageView sd_setImageWithURL:[NSURL URLWithString:model.user_profile_image_url] placeholderImage:[UIImage imageNamed:@"big_defaulthead_head"]];
    titleLabe.text = model.user_name;
    titleLabe.textColor = COLOR;
    
    //时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    double time = (double)[model.create_time doubleValue];
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *timeStr = [formatter stringFromDate:timeDate];
    timelabel.text = timeStr;
    commentLable.text = model.text;
    CGRect rect = [model.text boundingRectWithSize:CGSizeMake(220, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName] context:nil];
    commentLable.frame=CGRectMake(50, 40, WIDTH-60,rect.size.height);
    timelabel.frame = CGRectMake(WIDTH-120, rect.size.height+40, 100, 20);
    CGFloat heiY=CGRectGetMaxY(commentLable.frame);
    bgImageView.frame=CGRectMake(3, 0, WIDTH-6, heiY);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
