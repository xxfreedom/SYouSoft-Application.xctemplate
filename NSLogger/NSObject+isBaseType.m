//
//  NSObject+isBaseType.m
//  LogMessage
//
//  Created by sy on 8/27/14.
//  Copyright (c) 2014 SY. All rights reserved.
//

#import "NSObject+isBaseType.h"
#import <objc/runtime.h>
@implementation NSObject (isBaseType)
+(BOOL)isBaseType:(id)object
{
    if([object isKindOfClass:[NSObject class]]
       &&![object isKindOfClass:[NSString class]]
       &&![object isKindOfClass:[NSDictionary class]]
       &&![object isKindOfClass:[NSArray class]])
    {
        return NO;
    }
    return YES;
    
}
+(NSDictionary *)getProperty:(id)object
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    unsigned int numIvars;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    
    Ivar *vars = class_copyIvarList([object class], &numIvars);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        Ivar thisValue=vars[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [object valueForKey:propertyName];
        NSString * dataType = [NSString stringWithCString:ivar_getTypeEncoding(thisValue) encoding:NSUTF8StringEncoding];
        NSString *dicKey=[NSString stringWithFormat:@"%@(%@)",propertyName,dataType];
        if (propertyValue)
        {
           [props setObject:propertyValue forKey:dicKey];
        }
        else [props setObject:@"nil" forKey:dicKey];
    }
    free(properties);
    return props;
}
/* 获取对象的所有方法 */
+(void)printMothList
{
    unsigned int mothCout_f =0;
    Method* mothList_f = class_copyMethodList([self class],&mothCout_f);
    for(int i=0;i<mothCout_f;i++)
    {
        Method temp_f = mothList_f[i];
//        IMP imp_f = method_getImplementation(temp_f);
//        SEL name_f = method_getName(temp_f);
        const char* name_s =sel_getName(method_getName(temp_f));
        int arguments = method_getNumberOfArguments(temp_f);
        const char* encoding =method_getTypeEncoding(temp_f);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
              arguments,
              [NSString stringWithUTF8String:encoding]);
    }
    free(mothList_f);
}
@end
