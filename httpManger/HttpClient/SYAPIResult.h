//
//  SYAPIResult.h
//  syWebApp
//
//  Created by 立行 on 13-12-10.
//  Copyright (c) 2013年 com.syou.web. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SYAPIResult : NSObject
@property (nonatomic,assign) int code;
@property (nonatomic,strong) NSString *msg;
@property (nonatomic,strong) id data;
@property (nonatomic,assign,readonly) BOOL notError;

- (id)initWithAttributes:(NSDictionary *)attributes;
- (id)initWithResponseObject:(id)responseObject;

+ (SYAPIResult*)resultWithResponseObject:(id)responseObject;
+ (SYAPIResult*)resultIn404;
@end
