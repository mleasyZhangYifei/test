//
//  HTTPTools.m
//  BarCodeQuery
//
//  Created by edison on 15-11-27.
//  Copyright (c) 2015年 edison. All rights reserved.
//

#import "HTTPTools.h"

@implementation HTTPTools
+(void)facts:(NSString *)param success:(void (^)(TitleBean *Title))success failure:(void (^)(NSString *error))failure;
{
    [self post:GET_facts params:param resultClass:[TitleBean class] success:success failure:failure];
}
+(void) post:(NSString *)method params:(NSString *)params resultClass:(Class)resultCls success:(void (^)(id responseObject))success failure:(void (^)(NSString *))failure
{
    NSError *error;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:GET_facts]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (response !=nil ) {
        NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        id result = [resultCls mj_objectWithKeyValues:weatherDic];
        success(result);
    }else{
        failure(@"0");
    }    
}
@end
