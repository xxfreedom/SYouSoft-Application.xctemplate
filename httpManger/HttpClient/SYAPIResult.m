//
//  SYAPIResult.m
//  syWebApp
//
//  Created by 立行 on 13-12-10.
//  Copyright (c) 2013年 com.syou.web. All rights reserved.
//

#import "SYAPIResult.h"
#import "JSONKit.h"
@interface NSDictionary (FixedNULL)
-(NSDictionary*)fixNull;
@end
@implementation NSDictionary (FixedNULL)
-(NSDictionary*)fixNull
{
    NSString *jsonString = [self JSONString];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@":null," withString:@":\"\","];
    return [jsonString objectFromJSONString];
    return nil;
}

@end

@interface NSArray (FixedNULL)
-(NSDictionary*)fixNull;
@end
@implementation NSArray (FixedNULL)
-(NSDictionary*)fixNull
{
    NSString *jsonString = [self JSONString];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@":null," withString:@":\"\","];
    
    return [jsonString objectFromJSONString];
    
    return nil;
}
@end


@implementation SYAPIResult
- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        if (attributes)
        {
            _code = [[attributes objectForKey:@"code"] integerValue];
            _msg = [attributes objectForKey:@"msg"];
            if (_code)
            {
                _data = [attributes objectForKey:@"data"];
                if ([_msg isEqual:[NSNull null]])
                {
                     SYDLog(@"data = nil");
                    _data = nil;
                }
                @try
                {
                    if(_data==[NSNull null])
                    {
                        _data=nil;
                    }
                    if (_data != nil && [_data count] > 0)
                    {
                        [_data fixNull];
                    }
                }
                @catch (NSException *exception)
                {
                    _data = nil;
                }
                @finally
                {
                    
                }
            }
        }
        else
        {
            _code = [[attributes objectForKey:@"0"] integerValue];
            _msg= [attributes objectForKey:@"Json Error!"];
        }
        [SYAppUIConfig isErrorAccountFrom:_code];
    }
    return self;
}
- (BOOL)notError
{
    return _code==1;
}
- (id)initWithResponseObject:(id)responseObject
{
    if ([responseObject bytes]==0)
    {
        return [self initWithAttributes:nil];
    }
    
    return [self initWithAttributes:[responseObject objectFromJSONData]];
}

+ (SYAPIResult*)resultWithResponseObject:(id)responseObject
{
    return [[[self class] alloc] initWithResponseObject:responseObject];
    
}
+ (SYAPIResult*)resultIn404
{
    SYAPIResult *result  = [[[self class] alloc] initWithAttributes:@{@"code":@"0",@"msg":@"网络异常"}];
    return result;
}

@end
