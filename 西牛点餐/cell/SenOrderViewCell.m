//
//  SenderTableViewCell.m
//  西牛点餐
//
//  Created by 叶凡 on 2019/8/6.
//  Copyright © 2019 yefan. All rights reserved.
//

#import "SenOrderViewCell.h"

@implementation SenOrderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _jianpush.contentMode = UIViewContentModeCenter;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCellmodel:(FoodModel *)cellmodel{
    _text1.text = cellmodel.name;
    
}

@end
