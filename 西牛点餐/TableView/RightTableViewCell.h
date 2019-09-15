//
//  RightTableViewCell.h
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import <UIKit/UIKit.h>

@class FoodModel;
typedef void(^ButtonClick)(UIButton * sender);
#define kCellIdentifier_Right @"RightTableViewCell"

@interface RightTableViewCell : UITableViewCell

@property (nonatomic, strong) FoodModel *model;
@property (nonatomic,copy) ButtonClick buttonAction;
@property (nonatomic,strong) UIButton *addBT;
/// 数量
@property (nonatomic,strong) UILabel *countLab;
/// 减少按钮
@property (nonatomic,strong) UIButton *reduceBT;

@property (copy, nonatomic) void (^plusBlock)(NSInteger count,NSString *str);
@end
