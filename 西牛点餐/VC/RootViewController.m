//
//  RootViewController.m
//  西牛点餐
//
//  Created by 叶凡 on 2019/8/5.
//  Copyright © 2019 yefan. All rights reserved.
//

#import "RootViewController.h"
#import "SenOrderViewController.h"
#import "PersonalCenterViewController.h"
#import "TableViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self laodwithView];
}
-(void)laodwithView{
    TableViewController *mainv = [TableViewController new];
    UINavigationController *mainVC = [[UINavigationController alloc]initWithRootViewController:mainv];
    mainVC.tabBarItem.title = @"点餐";
    mainVC.hidesBottomBarWhenPushed = NO;
    
    SenOrderViewController *newv = [SenOrderViewController new];
    UINavigationController *newVc = [[UINavigationController alloc]initWithRootViewController:newv];
    newVc.tabBarItem.title = @"订单";
    newVc.hidesBottomBarWhenPushed = NO;
    
    PersonalCenterViewController *mev = [PersonalCenterViewController new];
    UINavigationController *meVc = [[UINavigationController alloc]initWithRootViewController:mev];
    meVc.tabBarItem.title = @"我的";
    meVc.hidesBottomBarWhenPushed = NO;
    
    
    
    mainVC.tabBarItem.image = [[UIImage imageNamed:@"one_img"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mainVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"one_img1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    newVc.tabBarItem.image = [[UIImage imageNamed:@"two_img"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    newVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"two_img1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    meVc.tabBarItem.image = [[UIImage imageNamed:@"the_img"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    meVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"the_img1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
    
    
    self.viewControllers = @[mainVC,newVc,meVc];
}

@end
