//
//  SSViewController.m
//  西牛点餐
//
//  Created by 叶凡 on 2019/8/7.
//  Copyright © 2019 yefan. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "SSTableViewCell.h"
@interface OrderDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *mutabarr;
@end

@implementation OrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = YES;
    [self loadingwithView];
//    jxt_showAlertTitle(@"高峰期间,请即时前往餐厅结账并就餐");
    
}
-(void)setNuber:(NSInteger)nuber{
    _nuber = nuber;
    NSLog(@"%li",(long)_nuber);
}
-(void)setArraymol:(FoodModel *)arraymol{
    _arraymol = arraymol;
    [self.mutabarr addObject:_arraymol];

    NSLog(@"model======%@",self.mutabarr);
}
-(void)setArrays:(NSArray *)arrays{
    _arrays = arrays;
}
-(NSMutableArray*)mutabarr{
    if(!_mutabarr){
        _mutabarr = [NSMutableArray new];
    }
    return _mutabarr;
}
-(void)loadingwithView{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, VCSelfWidth, VCSelfHeight-64)];
    _tableview.delegate =self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [UIColor whiteColor];
//    _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableview];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mutabarr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SSTableViewCell"];
    if(cell==nil){
        [_tableview registerNib:[UINib nibWithNibName:@"SSTableViewCell" bundle:nil] forCellReuseIdentifier:@"SSTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"SSTableViewCell"];
    }
    FoodModel *model= [_mutabarr objectAtIndex:indexPath.row];
    cell.t1.text = model.name;
    cell.t2.text = [NSString stringWithFormat:@"¥%@",[NSString stringWithFormat:@"%.1f",model.min_price]];
    cell.countss.text = [NSString stringWithFormat:@"x%@",[_arrays objectAtIndex:indexPath.row]];
    [cell.img setImageWithURL:[NSURL URLWithString:model.picture]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VCSelfWidth   , 60.0)];
    
    UILabel *la = [[UILabel alloc ]init ];
    la.frame = CGRectMake(VCSelfWidth-150, 10, 150 , 20);
    la.text = [NSString stringWithFormat:@"订单总额:%li",(long)_nuber];
    la.textColor = [UIColor redColor];
    la.font = [UIFont systemFontOfSize:15.f];
    la.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:la];
    
    return footerView;
}
@end
