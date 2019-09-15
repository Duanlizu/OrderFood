//
//  SSViewController.h
//  西牛点餐
//
//  Created by 叶凡 on 2019/8/7.
//  Copyright © 2019 yefan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailsViewController : UIViewController
@property (nonatomic,strong)FoodModel *arraymol;
@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSArray *arrays;
@property (nonatomic,assign) NSInteger nuber;
@end

NS_ASSUME_NONNULL_END
