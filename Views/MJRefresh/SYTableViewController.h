//
//  SYTableViewController.h
//  MJRefreshExample
//
//  Created by sy on 14-10-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+MJRefresh.h"
@interface SYTableViewController : UITableViewController
@property (nonatomic,assign)BOOL isMore;
@property (nonatomic,assign)BOOL isRefresh;
-(void)headerRereshing:(SYTableViewController *)tableView;
-(void)footerRereshing:(SYTableViewController *)tableView;
@end
