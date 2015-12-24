//
//  CustomView.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/6.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "CustomView.h"


@implementation CustomView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
}

-(void)makeUI {
    NSArray *arr = @[@"mainCellCommentN@2x",@"mainCellShare@2x"];
    for (int i = 0; i < arr.count; i++) {
        UIImageView *imgeView = [ZCControl createImageViewWithFrame:CGRectMake(50+i*WIDTH/2, 10, 20, 20) ImageName:arr[i]];
        imgeView.tag = 100+i;
        [self addSubview:imgeView];
        
        UIImageView *lineView = [ZCControl createImageViewWithFrame:CGRectMake(WIDTH/2, 10, 1, 20) ImageName:@"Profile_lineN.png"];
        [self addSubview:lineView];
        
        if (i == 0) {
        
            commentsLabel = [ZCControl createLabelWithFrame:CGRectMake(80+WIDTH*i/2, 10, 80, 20) Font:14 Text:nil];
            commentsLabel.textColor = [UIColor brownColor];
            [self addSubview:commentsLabel];
        } else if (i == 1) {
        
            shareLabel = [ZCControl createLabelWithFrame:CGRectMake(80+WIDTH*i/2, 10, 80, 20) Font:14 Text:nil];
            shareLabel.textColor = [UIColor brownColor];
            [self addSubview:shareLabel];
        }
        
        self.control = [[UIControl alloc] initWithFrame:CGRectMake(WIDTH*i/2, 0, WIDTH/2, 40)];
        self.control.tag = 1000+i;
        [self addSubview:self.control];
    }
}

-(void)configModel:(HYGroupModel *)model {

    commentsLabel.text = [NSString stringWithFormat:@"评论%@",model.comment_count];
    shareLabel.text = @"分享";
    
}

@end
