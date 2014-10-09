//
//  SYApiClient.h
//  syWebApp
//
//  Created by 立行 on 13-12-10.
//  Copyright (c) 2013年 com.syou.web. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "JSONKit.h"

@interface SYApiClient : AFHTTPClient
{
    NSInteger _operationID;
}
//property
@property (nonatomic,strong) NSMutableArray *operations;
//class method
+ (SYApiClient*)sharedClient;
+ (AFHTTPRequestOperation*)buildGetRequestOperationWithType:(NSString*)type parameters:(NSDictionary*)parameters;
+ (AFHTTPRequestOperation*)buildPostRequestOperationWithType:(NSString*)type parameters:(NSDictionary*)parameters;
+ (AFHTTPRequestOperation*)buildRequestOperationWithType:(NSString*)type parameters:(NSDictionary*)parameters AndTimeOut:(NSTimeInterval)timeout constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block;
+ (AFHTTPRequestOperation*)buildGetRequestOperationWithType:(NSString*)type parameters:(NSDictionary*)parameters andTimeOut:(NSTimeInterval)timeout;
//object method
- (void)addOperationWithIndentifier:(NSString*)type operation:(AFHTTPRequestOperation *)operation;
- (void)addOperationWithIndentifier:(NSString*)type operation:(AFHTTPRequestOperation *)operation AndRemoveRequestType:(BOOL)isRemove;
- (void)removeOperationWithIndentifier:(NSString*)type;
-(void)removeOperation:(long long)operationID;
@end