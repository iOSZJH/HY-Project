//
//  PictureModel.h
//  HY_Project
//
//  Created by 张锦辉 on 15/5/5.
//  Copyright (c) 2015年 张锦辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureModel : NSObject

@property (nonatomic, copy) NSNumber* height;
@property (nonatomic, copy) NSString* uri;
@property (nonatomic, strong) NSArray* url_list;
@property (nonatomic, copy) NSNumber* width;

@end
