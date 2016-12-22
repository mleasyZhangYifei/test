//
//  TitleData.m
//  test
//
//  Created by juefeng on 16/12/21.
//  Copyright © 2016年 张毅斐. All rights reserved.
//

#import "TitleData.h"

@implementation TitleData
@dynamic description;
+(NSDictionary *)replacedKeyFromPropertyName{
    
    return @{@"Description":@"description"};
    
}
@end
