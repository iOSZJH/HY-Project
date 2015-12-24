//
//  HYGroupModel.h
//  HY_Project
//
//  Created by 张锦辉 on 15/5/5.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HYGroupUserModel;
@class PictureModel;

@interface HYGroupModel : NSObject

@property(nonatomic,copy) NSNumber* bury_count;
@property(nonatomic,assign) NSNumber* category_id;
@property(nonatomic,assign) NSNumber* category_type;
@property(nonatomic,copy) NSNumber* comment_count;
@property(nonatomic,copy) NSString* content;//内容
@property(nonatomic,assign) NSNumber* create_time;
@property(nonatomic,copy) NSNumber* digg_count;
@property(nonatomic,copy) NSNumber* favorite_count;
@property(nonatomic,copy) NSNumber* go_detail_count;
@property(nonatomic,copy) NSNumber* group_id;
@property(nonatomic,assign) NSNumber* has_comments;
@property(nonatomic,assign) NSNumber* has_hot_comments;
@property(nonatomic,assign) NSNumber* is_can_share;
@property(nonatomic,assign) NSNumber* label;
@property(nonatomic,assign) NSNumber* level;
@property(nonatomic,assign) NSNumber* repin_count;
@property(nonatomic,assign) NSNumber* share_type;
@property(nonatomic,copy) NSString* share_url;//分享
@property(nonatomic,assign) NSNumber* status;
@property(nonatomic,copy) NSString* status_desc;//描素
@property(nonatomic,strong) HYGroupUserModel *user;//使用者信息
@property(nonatomic,assign) NSNumber* user_bury;
@property(nonatomic,assign) NSNumber* user_digg;
@property(nonatomic,assign) NSNumber* user_favorite;
@property(nonatomic,assign) NSNumber* user_repin;

//图片
@property(nonatomic,copy)NSString*description;
@property (nonatomic, assign) NSNumber* image_status;
@property (nonatomic, strong) PictureModel* large_image;
@property (nonatomic, strong) PictureModel* middle_image;
@property (nonatomic, strong)NSNumber *max_screen_width_percent;
@property (nonatomic, strong)NSNumber *min_screen_width_percent;

@end
