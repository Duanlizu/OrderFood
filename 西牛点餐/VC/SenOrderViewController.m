//
//  SenderViewController.m
//  西牛点餐
//
//  Created by 叶凡 on 2019/8/5.
//  Copyright © 2019 yefan. All rights reserved.
//

#import "SenOrderViewController.h"
#import "SenOrderViewCell.h"
#import "OrderDetailsViewController.h"
@interface SenOrderViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _counts;
    int nub ;
}
@property (nonatomic,strong)NSMutableArray *mutableArrays;
@property (nonatomic,strong)UILabel *labtext;
@end

@implementation SenOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadingwithView];
    self.navigationItem.title = @"我的订单";
    nub = 0;
    _mutableArrays = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"meituan" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *foods = dict[@"data"][@"food_spu_tags"];
    
    for (NSDictionary *dict in foods){
        CategoryModel *model = [CategoryModel objectWithDictionary:dict];
        NSMutableArray *datas = [NSMutableArray array];
        for (FoodModel *f_model in model.spus)
        {
            [datas addObject:f_model];
        }
        [_mutableArrays addObject:datas];
        
    }
    _labtext = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, VCSelfWidth, 40)];
    _labtext.textAlignment = NSTextAlignmentCenter;
    _labtext.text = @"暂时没有订单哦";
    [_labtext setFont:[UIFont fontWithName:@"Helvetica-Bold" size:23]];
    [self.view addSubview:_labtext];
}

-(NSMutableArray*)mutablearr{
    if(!_mutablearr){
        _mutablearr = [[NSMutableArray alloc]init];
    }
    return _mutablearr;
}

//接收tabbarItem1z传过来的数据
- (void)viewWillAppear:(BOOL)animated
{
    nub = 0;
    NSString *doucumentString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filepath = [doucumentString stringByAppendingPathComponent:@"adds.plist"];
    self.mutablearr = [NSMutableArray arrayWithContentsOfFile:filepath];
    if(self.mutablearr.count >0){
        _labtext.hidden = YES;
        [self.tableview reloadData];
    }else{
        _labtext.hidden = NO;
    }
}

-(void)loadingwithView{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, VCSelfWidth, VCSelfHeight-64)];
    _tableview.delegate =self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [UIColor whiteColor];
    _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableview];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mutablearr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 103;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SenOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SenOrderViewCell"];
    if(cell==nil){
        [_tableview registerNib:[UINib nibWithNibName:@"SenOrderViewCell" bundle:nil] forCellReuseIdentifier:@"SenOrderViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"SenOrderViewCell"];
    }
    
    //NSMutableArray *priceass = [[NSMutableArray alloc]init];
  
    NSDictionary *array = [self.mutablearr objectAtIndex:indexPath.row];
    //NSArray *arr =array.allKeys;
    
    NSArray *countss = array.allValues;
    NSNumber *sum = [countss valueForKeyPath:@"@sum.self"];
    for(NSInteger a=0;a<_mutableArrays.count;a++){
        NSArray *as = [_mutableArrays objectAtIndex:a];
        for(NSInteger i=0;i<as.count;i++){
            FoodModel *models = as[i];
            NSString *foods = [NSString stringWithFormat:@"%@",models.foodId];
            [array enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if([foods isEqualToString:key])
                {
                    cell.cellmodel = models;
                    NSString *price = [NSString stringWithFormat:@"%.1f",models.min_price];
                    int ivalue1 = [price intValue];
                    int ivalue = [obj intValue];
                    int nubs = ivalue *ivalue1;
                    nub += nubs ;
                    cell.text2.text = [NSString stringWithFormat:@"等%@件商品",sum];
                }
            }];
        }
    }
    cell.price.text = [NSString stringWithFormat:@"%d元",nub];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    cell.nametxt.text = [user objectForKey:@"name"];
    return cell;
}
- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath{
    return YES;
}

//移除单元格数据处理
- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath{
    [self.mutablearr removeObject:self.mutablearr[indexPath.row]];
    [self.tableview reloadData];
    NSLog(@"mutablearr======%@",self.mutablearr);
    if(self.mutablearr.count <1){
        _labtext.hidden = NO;
    }
    //将沙盒文件中所存的数据清理掉
    NSString *doucumentString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filepath = [doucumentString stringByAppendingPathComponent:@"adds.plist"];
    NSMutableArray *wrdataarr = [NSMutableArray arrayWithContentsOfFile:filepath];
    [wrdataarr removeObjectAtIndex:indexPath.row];
    [wrdataarr writeToFile:filepath atomically:YES];
}
- (NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath{
    return@"取消预约";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailsViewController *ssview = [[OrderDetailsViewController alloc]init];
    NSDictionary *array = [self.mutablearr objectAtIndex:indexPath.row];
    NSArray *arr =array.allKeys;
    NSArray *arrcouns = array.allValues;
    for(NSInteger a=0;a<_mutableArrays.count;a++){
        NSArray *as = [_mutableArrays objectAtIndex:a];
        for(NSInteger i=0;i<as.count;i++){
            FoodModel *models = as[i];
            for(NSInteger j=0;j<arr.count;j++){
                NSString *foods = [NSString stringWithFormat:@"%@",models.foodId];
                if([foods isEqualToString:arr[j] ] )
                {
                    ssview.arraymol = models;
                    ssview.arrays = arrcouns;
                }
            }
        }
    }
    ssview.hidesBottomBarWhenPushed = YES;
    ssview.nuber = nub;
    [self.navigationController pushViewController:ssview animated:YES];
}
@end
