//
//  SYTableViewController.m
//  MJRefreshExample
//
//  Created by sy on 14-10-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "SYTableViewController.h"

@interface SYTableViewController ()

@end

@implementation SYTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ---Refresh----
-(void)setIsMore:(BOOL)isMore
{
    _isMore=isMore;
    if(_isMore)
    {
        [self.tableView addFooterWithTarget:self action:@selector(footerRereshing:)];
        self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
        self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
        self.tableView.footerRefreshingText = @"MJ哥正在帮你加载中,不客气";
    }else
    {
        [self.tableView removeFooter];
    }
}
-(void)setIsRefresh:(BOOL)isRefresh
{
    _isRefresh=isRefresh;
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    if(_isRefresh)
    {
        [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing:) dateKey:@"table"];
        // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
        self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
        self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
        self.tableView.headerRefreshingText = @"MJ哥正在帮你刷新中,不客气";
        
    }else
    {
        [self.tableView removeHeader];
    }
}
-(void)headerRereshing:(SYTableViewController *)tableView
{
    [self.tableView headerEndRefreshing];
}
-(void)footerRereshing:(SYTableViewController *)tableView
{
    [self.tableView footerEndRefreshing];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
