//
//  ViewController.m
//  XMNavigationDropdownMenu
//
//  Created by 谢满 on 16/8/31.
//  Copyright © 2016年 DGUT. All rights reserved.
//

#import "ViewController.h"
#import "XMNavigationDropdownMenu.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray  *items = @[@"Most Popular", @"Latest", @"Trending", @"Nearest", @"Top Picks"];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:180.0/255.0 blue:220.0/255.0 alpha:1];
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                            NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                    };
    
    XMNavigationDropdownMenu *menuView = [[XMNavigationDropdownMenu alloc] initWithNavigationController:self.navigationController containerView:[UIApplication sharedApplication].keyWindow title:@"Dropdown Menu" items:items];
    menuView.cellHeight = 50;
    menuView.cellBackgroundColor = self.navigationController.navigationBar.barTintColor;
    menuView.cellSelectionColor = [UIColor colorWithRed:0 green:160.0/255 blue:195.0/255 alpha:1];

    menuView.shouldKeepSelectedCellColor = YES;
    menuView.cellTextLabelColor = [UIColor whiteColor];
    menuView.cellTextLabelFont = [UIFont systemFontOfSize:17];
    menuView.cellTextLabelAlignment = NSTextAlignmentLeft; // .Center // .Right // .Left
    menuView.arrowPadding = 15;
    menuView.animationDuration = 0.5;
    menuView.maskBackgroundColor = [UIColor blackColor];
    menuView.maskBackgroundOpacity = 0.3;
    menuView.checkMarkImage = [UIImage imageNamed:@"abc_ic_star_black_16dp"];
    menuView.didSelectItemAtIndexHandler = ^(NSUInteger index){
        NSLog(@"%zd",index);
    };
    

    self.navigationItem.titleView = menuView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
