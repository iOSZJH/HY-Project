//
//  FindCell.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/5.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "FindCell.h"


@implementation FindCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
        
    }
    return self;
}

-(void)makeUI
{
    tpImageView=[ZCControl createImageViewWithFrame:CGRectMake(10, 10, 60, 60) ImageName:@"bgImageView"];
    tpImageView.layer.cornerRadius=8;
    tpImageView.layer.masksToBounds=YES;
    [self.contentView addSubview:tpImageView];
    
    nameLabel=[ZCControl createLabelWithFrame:CGRectMake(140, 10, WIDTH-140, 30) Font:15 Text:nil];
    nameLabel.textColor=[UIColor blackColor];
    [self.contentView addSubview:nameLabel];
    
    desLabel=[ZCControl createLabelWithFrame:CGRectMake(140, 48, WIDTH-150, 20) Font:12 Text:nil];
    desLabel.textColor=[UIColor grayColor];
    [self.contentView addSubview:desLabel];
}
-(void)config:(NSArray *)array
{
    tpImageView.image=[UIImage imageNamed:array[0]];
    nameLabel.text=array[1];
    desLabel.text = array[2];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end