//
//  VideoModel.h
//  HY_Project
//
//  Created by 张锦辉 on 15/5/5.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HYGroupUserModel;

@interface VideoModel : NSObject
@property(nonatomic)id middle_image;

@property(nonatomic,copy)NSDictionary *_360p_video;
@property(nonatomic,copy)NSDictionary *_480p_video;
@property(nonatomic,copy)NSDictionary *_720p_video;

@property(nonatomic,copy)NSNumber *bury_count;
@property(nonatomic,assign)NSNumber *category_id;
@property(nonatomic,assign)NSNumber *category_type;
@property(nonatomic,copy)NSNumber *comment_count;
@property(nonatomic,copy)NSString *content;//内容
@property(nonatomic,copy)NSString *cover_image_uri;
@property(nonatomic,assign)NSNumber *create_time;
@property(nonatomic,copy)NSNumber *digg_count;
@property(nonatomic,assign)NSNumber *duration;
@property(nonatomic,copy)NSNumber *favorite_count;
@property(nonatomic,copy)NSString *flash_url;
@property(nonatomic,copy)NSNumber *go_detail_count;
@property(nonatomic,copy)NSNumber *group_id;
@property(nonatomic,assign)NSNumber *has_comments;
@property(nonatomic,assign)NSNumber *has_hot_comments;
@property(nonatomic,assign)NSNumber *is_can_share;
@property(nonatomic,assign)NSNumber *is_public_url;
@property(nonatomic,assign)NSNumber *is_video;
@property(nonatomic,copy)NSString *keywords;
@property(nonatomic,assign)NSNumber *label;
@property(nonatomic,strong)NSDictionary *large_cover;
@property(nonatomic,assign)NSNumber *level;
@property(nonatomic,copy)NSString *m3u8_url;
@property(nonatomic,strong)NSDictionary *medium_cover;
@property(nonatomic,copy)NSString *mp4_url;
@property(nonatomic,strong)NSDictionary *origin_video;
@property(nonatomic,assign)NSNumber *play_count;
@property(nonatomic,assign)NSNumber *publish_time;
@property(nonatomic,assign)NSNumber *repin_count;
@property(nonatomic,assign)NSNumber *share_type;
@property(nonatomic,copy)NSString *share_url;//分享
@property(nonatomic,assign)NSNumber *status;
@property(nonatomic,copy)NSString *status_desc;//描素
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *uri;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,strong)HYGroupUserModel *user;//使用者信息
@property(nonatomic,assign)NSNumber *user_bury;
@property(nonatomic,assign)NSNumber *user_digg;
@property(nonatomic,assign)NSNumber *user_favorite;
@property(nonatomic,assign)NSNumber *user_repin;
@property(nonatomic,assign)NSNumber *video_height;
@property(nonatomic,assign)NSNumber *video_width;

@end
