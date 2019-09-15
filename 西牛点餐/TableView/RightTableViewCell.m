//
//  RightTableViewCell.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "RightTableViewCell.h"
#import "CategoryModel.h"

@interface RightTableViewCell ()
{
    NSUInteger  _count ;
}
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic,strong) UIButton *canbtn;



@end

@implementation RightTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
        [self.contentView addSubview:self.imageV];

        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 30)];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.nameLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, 200, 30)];
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        self.priceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.priceLabel];
        
        _addBT =[UIButton buttonWithType:UIButtonTypeCustom];
        [_addBT addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _addBT.frame = CGRectMake(260, 50, 22, 22);
        [_addBT setImage:[UIImage imageNamed:@"but_add_yellow"] forState:UIControlStateNormal];
        _addBT.imageView.contentMode = UIViewContentModeScaleAspectFill;
        _addBT.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_addBT];
        _addBT.tag = 1;

        //数量
        _countLab = [[UILabel alloc] initWithFrame:CGRectMake(220, 52, 40, 20)];
        _countLab.font = [UIFont systemFontOfSize:14.0f];
        _countLab.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        _countLab.textAlignment = NSTextAlignmentCenter;
        _countLab.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview: _countLab];
//        _countLab.text = @"1";
//        _countLab.hidden = YES;
        //    //减少按钮
        _reduceBT = [UIButton buttonWithType:UIButtonTypeCustom];
        _reduceBT.frame=CGRectMake(200, 50, 22, 22);
        [_reduceBT addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_reduceBT setImage:[UIImage imageNamed:@"but_reduce"] forState:UIControlStateNormal];
        _reduceBT.imageView.contentMode = UIViewContentModeScaleAspectFill;
        _reduceBT.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_reduceBT];
        _reduceBT.tag = 2;
        _reduceBT.hidden = YES;

    }
    return self;
}
-(void)btnClick:(UIButton *)button{
//    self.buttonAction(button);
    switch (button.tag) {
        case 1:
        {//增加
            _count ++;
            if (_count > 0) {
                _countLab.hidden        = NO;
                _reduceBT.hidden        = NO;
            }
//            if(_count ==1){
//                _countLab.text = [NSString stringWithFormat:@"%ld",_count];
//                self.plusBlock(_count,@"增加");
//            }
//            if (_count >1 ){
//                _count = 1;
//                [LCProgressHUD showMessage:@"高峰期间,每样餐最多可点一份"];
//            }
            if (self.plusBlock) {
                self.plusBlock(_count,@"增加");
                 _countLab.text = [NSString stringWithFormat:@"%ld",_count];
            }
        }
            break;
        case 2:
        {//减少
            NSLog(@"减少---------");
            _count--;
            if (_count <= 0) {
                _countLab.hidden        = YES;
                _reduceBT.hidden        = YES;
            }
            _countLab.text = [NSString stringWithFormat:@"%ld",_count];
            
            if (self.plusBlock) {
                self.plusBlock(_count,@"减少");
            }
        }
            break;
        case 3:
        {//选规格
            NSLog(@"选规格---------");
        }
            break;
            
        default:
            break;
    }
}



- (void)setModel:(FoodModel *)model
{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.picture]];
    self.nameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",@(model.min_price)];
    
    //NSLog(@"%@",self.priceLabel.text);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
