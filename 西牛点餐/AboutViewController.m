//
//  AboutmeViewController.m
//  西牛点餐
//
//  Created by 叶凡 on 2019/8/7.
//  Copyright © 2019 yefan. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = YES;
    self.navigationItem.title = @"关于我们";
    [self laodview];
    
}

-(void)laodview{
    
    //默认图片
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_logo"]];
    img.frame = CGRectMake(VCSelfWidth/2-40, 100, 80, 80);
    img.layer.cornerRadius = 10;
    img.layer.masksToBounds = YES;
    [self.view addSubview:img];
    
    UILabel *Name = [[UILabel alloc]init];
    Name.text = [NSString stringWithFormat:@"ZebraRestaurant For iPhone V1.0"];
    Name.textColor = [UIColor blackColor];
    Name.textAlignment = NSTextAlignmentCenter;
    Name.font = [UIFont systemFontOfSize:13];
    Name.textColor = [UIColor grayColor];
    Name.frame = CGRectMake(VCSelfWidth/2-100, 190, 200, 20);
    [self.view addSubview:Name];
    
    UILabel *tiptext = [[UILabel alloc]init];
    tiptext.text = [NSString stringWithFormat:@"Copyright©2019-2028 ZebraRestaurant所有"];
    tiptext.textAlignment = NSTextAlignmentCenter;
    tiptext.textColor = [UIColor blackColor];
    tiptext.font = [UIFont systemFontOfSize:13];
    tiptext.textColor = [UIColor grayColor];
    tiptext.frame = CGRectMake(VCSelfWidth/2-150, VCSelfHeight-20, 300, 20);
    [self.view addSubview:tiptext];
}

@end
