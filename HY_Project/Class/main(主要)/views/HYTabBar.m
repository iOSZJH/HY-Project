//
//  HYTabBar.m
//  HY_Project
//
//  Created by 张锦辉 on 15/5/4.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import "HYTabBar.h"

@implementation HYTabBar

- (void)addTabBarButtonWithItem:(UITabBarItem *)item {
    //创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    
    //设置数据
    [btn setImage:item.image forState:UIControlStateNormal];
    [btn setImage:item.selectedImage forState:UIControlStateSelected];
    [btn setTitle:item.title forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(20, -31, -20, 31)];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    //btn.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnY = 0;
    CGFloat btnW = (self.frame.size.width-50) / self.subviews.count;
    CGFloat btnH = self.frame.size.height-10;
    for (int i = 0; i < self.subviews.count; i ++) {
        //取出按钮
        UIButton *btn = self.subviews[i];
        if (i == 0) {
            btn.selected = YES;
        }
        btn.tag  =100 + i;
        //设置按钮的frame
        CGFloat btnX = i * btnW+35;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)btnClick:(UIButton *)btn {
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:100+i];
        button.selected = NO;
    }
    btn.selected = YES;
    
    [self.delegate pushSlectIndex:btn.tag - 100];
    
}


@end
