//
//  HYGroupUserModel.h
//  HY_Project
//
//  Created by 张锦辉 on 15/5/5.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYGroupUserModel : NSObject

@property (nonatomic, copy) NSString* avatar_url;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) NSNumber* user_id;
@property (nonatomic, assign) BOOL user_verified;

@end
