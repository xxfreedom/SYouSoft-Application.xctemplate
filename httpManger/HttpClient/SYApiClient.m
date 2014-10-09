//
//  SYApiClient.m
//  syWebApp
//
//  Created by 立行 on 13-12-10.
//  Copyright (c) 2013年 com.syou.web. All rights reserved.
//

#import "SYApiClient.h"
#import "AFJSONRequestOperation.h"
#import "JSONKit.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "SYUserInfoSingleton.h"
#define SYWEB_REQUEST_METHOD @"GET"

@implementation SYApiClient
+(SYApiClient*)sharedClient{
    static SYApiClient* _client=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _client = [[SYApiClient alloc] initWithBaseURL:[NSURL URLWithString:kSYWEB_API_URL]];
    });
    return _client;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        
        _operations = [[NSMutableArray alloc] init];
        _operationID=0;
    }
    return self;
}

+ (AFHTTPRequestOperation*)buildGetRequestOperationWithType:(NSString*)type parameters:(NSDictionary*)parameters
{
    
    return [[self class] buildRequestOperationWithType:type parameters:parameters method:@"GET" andTimeOut:-1];
    
}

+ (AFHTTPRequestOperation*)buildGetRequestOperationWithType:(NSString*)type parameters:(NSDictionary*)parameters andTimeOut:(NSTimeInterval)timeout
{
    
    return [[self class] buildRequestOperationWithType:type parameters:parameters method:@"GET" andTimeOut:timeout];
}


+ (AFHTTPRequestOperation*)buildPostRequestOperationWithType:(NSString*)type parameters:(NSDictionary*)parameters
{
    return [[self class] buildRequestOperationWithType:type parameters:parameters method:@"POST" andTimeOut:-1];
}

+ (AFHTTPRequestOperation*)buildRequestOperationWithType:(NSString*)type parameters:(NSDictionary*)parameters method:(NSString*)method andTimeOut:(NSTimeInterval)timeout
{
    [[SYApiClient sharedClient] removeOperationWithIndentifier:type];
    NSMutableDictionary *param=[[NSMutableDictionary alloc] init];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    [param setObject:app_build forKey:@"version"];
    [param setObject:KI_PHONETYPE forKey:@"phoneType"];
    SYUserInfoSingleton *userInfo=[SYUserInfoSingleton shareUserInfoSingleton];
    [param setObject:userInfo.token forKey:@"token"];
    if (parameters)
        [param setObject:[parameters JSONString] forKey:@"params"];
    NSMutableURLRequest *request = [[SYApiClient sharedClient] requestWithMethod:method
                                                                            path:type
                                                                      parameters:param];
    if(timeout!=-1)
    {
        request.timeoutInterval=timeout;
    }
    else
    {
        request.timeoutInterval=10;
    }
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    return operation;
}

+ (AFHTTPRequestOperation*)buildRequestOperationWithType:(NSString*)type parameters:(NSDictionary*)parameters AndTimeOut:(NSTimeInterval)timeout constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
{
    [[SYApiClient sharedClient] removeOperationWithIndentifier:type];
    NSMutableDictionary *param=[[NSMutableDictionary alloc] init];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    [param setObject:app_build forKey:@"version"];
    [param setObject:KI_PHONETYPE forKey:@"phoneType"];
    SYUserInfoSingleton *userInfo=[SYUserInfoSingleton shareUserInfoSingleton];
    [param setObject:userInfo.token forKey:@"token"];
    if (parameters)
        [param setObject:[parameters JSONString] forKey:@"params"];
    NSMutableURLRequest *request =  [[SYApiClient sharedClient] multipartFormRequestWithMethod:@"POST" path:type parameters:param constructingBodyWithBlock:block];
    if(timeout!=-1)
    {
        request.timeoutInterval=timeout;
    }
    else
    {
        request.timeoutInterval=60;
    }
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    return operation;
}

- (void)addOperationWithIndentifier:(NSString*)type operation:(AFHTTPRequestOperation *)operation
{
    [self addOperationWithIndentifier:type operation:operation AndRemoveRequestType:YES];
}
- (void)addOperationWithIndentifier:(NSString*)type operation:(AFHTTPRequestOperation *)operation AndRemoveRequestType:(BOOL)isRemove
{
    if(isRemove)
    [self removeOperationWithIndentifier:type];
    _operationID++;
    operation.operationID=_operationID;
    operation.operationType=type;
    [self.operations addObject:operation];
    [self enqueueHTTPRequestOperation:operation];
}
-(void)removeOperation:(long long)operationID
{
    NSPredicate *predicate=[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"operationID == %lld",operationID]];
    NSArray *array= [self.operations filteredArrayUsingPredicate:predicate];
    AFHTTPRequestOperation *operation =[array lastObject];
    if(operation!=nil)
    {
        [operation cancel];
        [operation setCompletionBlockWithSuccess:nil failure:nil];
        [self.operations removeObject:operation];
    }
}
- (void)removeOperationWithIndentifier:(NSString*)type
{
    NSPredicate *predicate=[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"operationType == '%@'",type]];
    NSArray *array= [self.operations filteredArrayUsingPredicate:predicate];
    AFHTTPRequestOperation *operation =[array lastObject];
    if(operation!=nil)
    {
        [operation cancel];
        [operation setCompletionBlockWithSuccess:nil failure:nil];
        [self.operations removeObject:operation];
    }
}

@end
