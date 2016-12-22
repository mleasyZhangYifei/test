//
//  HTTPTools.h
//  BarCodeQuery
//
//  Created by edison on 15-11-27.
//  Copyright (c) 2015年 edison. All rights reserved.
//

#import "TestHeader.h"
#import "TitleBean.h"
@interface HTTPTools : NSObject
+(void)facts:(NSString *)param success:(void (^)(TitleBean *Title))success failure:(void (^)(NSString *error))failure;
@end
