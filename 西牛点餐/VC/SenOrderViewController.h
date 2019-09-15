//
//  SenderViewController.h
//  西牛点餐
//
//  Created by 叶凡 on 2019/8/5.
//  Copyright © 2019 yefan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SenOrderViewController : UIViewController

@property (nonatomic,strong)FoodModel *sendmodel;
@property (nonatomic,strong)NSMutableArray *mutablearr;
@property (nonatomic,strong)UITableView *tableview;
@end

NS_ASSUME_NONNULL_END
