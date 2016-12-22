//
//  TitleBean.m
//  test
//
//  Created by juefeng on 16/12/21.
//  Copyright © 2016年 张毅斐. All rights reserved.
//

#import "TitleBean.h"
#import "TitleData.h"
@implementation TitleBean

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"rows":[TitleData class]};
}
@end
