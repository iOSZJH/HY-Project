//
//  HYModel.h
//  HY_Project
//
//  Created by 张锦辉 on 15/5/5.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYModel : NSObject

@property(nonatomic,strong)NSMutableArray *comments;
@property(nonatomic,assign)NSNumber *display_time;
@property(nonatomic,strong)NSDictionary *group;
@property(nonatomic,assign)NSNumber *online_time;
@property(nonatomic,assign)NSNumber *type;


@end
