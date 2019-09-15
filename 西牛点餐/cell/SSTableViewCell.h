//
//  SSTableViewCell.h
//  西牛点餐
//
//  Created by 叶凡 on 2019/8/7.
//  Copyright © 2019 yefan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *t1;
@property (weak, nonatomic) IBOutlet UILabel *t2;
@property (weak, nonatomic) IBOutlet UILabel *countss;
@end

NS_ASSUME_NONNULL_END
