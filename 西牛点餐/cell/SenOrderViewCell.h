//
//  SenderTableViewCell.h
//  西牛点餐
//
//  Created by 叶凡 on 2019/8/6.
//  Copyright © 2019 yefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SenOrderViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *text1;
@property (weak, nonatomic) IBOutlet UILabel *text2;
@property (weak, nonatomic) IBOutlet UILabel *nametxt;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *jianpush;

@property (nonatomic,strong)FoodModel *cellmodel;

@end

NS_ASSUME_NONNULL_END
