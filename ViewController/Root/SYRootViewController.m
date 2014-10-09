//
//  SYRootViewController.m
//  Template
//
//  Created by sy on 14-10-8.
//  Copyright (c) 2014年 SY. All rights reserved.
//

#import "SYRootViewController.h"

@interface SYRootViewController ()

@end

@implementation SYRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIBarButtonItem *fixedSpaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpaceButtonItem.width = -10;
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        [backButton setImage:[UIImage imageNamed:@"fh_nor"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"fh_sel"] forState:UIControlStateSelected];
        [backButton addTarget:self action:@selector(backToPreController:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *temporaryBackButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        temporaryBackButtonItem.style = UIBarButtonItemStyleBordered;
        NSArray *leftBarButtonItems=@[fixedSpaceButtonItem,temporaryBackButtonItem];
        self.navigationItem.leftBarButtonItems=leftBarButtonItems;
    }
    return self;
}
-(IBAction)backToPreController:(id)sender
{
    @try {
        if(self.navigationController!=nil&&[self.navigationController.viewControllers indexOfObject:self]==0)
        {
            [self dismissViewControllerAnimated:YES completion:^{
                SYDLog(@"disMiss");
            }];
        }else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    @catch (NSException *exception) {
        SYDLog(@"back error")
    }
    @finally {
        SYDLog(@"undeal with this")
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
