//
//  HYCommentModel.h
//  HY_Project
//
//  Created by 张锦辉 on 15/5/5.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYCommentModel : NSObject

@property (nonatomic, copy) NSString* avatar_url;
@property (nonatomic, assign) NSNumber* comment_id;
@property (nonatomic, assign) NSNumber* create_time;
@property (nonatomic, copy) NSString* description;
@property (nonatomic, assign) NSNumber* digg_count;
@property (nonatomic, assign) NSNumber* is_digg;
@property (nonatomic, copy) NSString* platform_id;
@property (nonatomic, copy) NSString* text;
@property (nonatomic, assign) NSNumber* user_id;
@property (nonatomic, copy) NSString* user_name;
@property (nonatomic, copy) NSString* user_profile_image_url;
@property (nonatomic, assign) BOOL user_verified;

@end
