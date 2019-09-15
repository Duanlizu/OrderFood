//
//  TableViewController.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "TableViewHeaderView.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
#import "CategoryModel.h"
#import "TableViewController.h"
static float kLeftTableViewWidth = 80.f;

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *categoryData;
@property (nonatomic, strong) NSMutableArray *foodData;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic,strong) UIButton *subbtn;
@property (nonatomic,strong) NSMutableArray *arrays;
@property (nonatomic,strong)NSMutableDictionary *Arrdic;
@property (nonatomic,strong) NSString *docDir;

@end

@implementation TableViewController
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"点餐";
    _selectIndex = 0;
    _isScrollDown = YES;
    _arrays = [[NSMutableArray alloc]init];
    
    //tableView边界设置
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO ;
    
    //解析数据
    _Arrdic = [[NSMutableDictionary alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"meituan" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *foods = dict[@"data"][@"food_spu_tags"];
    
    //遍历
    for (NSDictionary *dict in foods)
    {
        CategoryModel *model = [CategoryModel objectWithDictionary:dict];
        [self.categoryData addObject:model];
        
        NSMutableArray *datas = [NSMutableArray array];
        for (FoodModel *f_model in model.spus)
        {
            //初始化购买数量
            f_model.count=0;
            [datas addObject:f_model];
        }
        [self.foodData addObject:datas];
        NSLog(@"%@",self.foodData);
    }
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftTableViewWidth, SCREEN_HEIGHT-80)];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.rowHeight = 55;
    _leftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _leftTableView.tableFooterView = [UIView new];
    _leftTableView.showsVerticalScrollIndicator = NO;
    _leftTableView.separatorColor = [UIColor clearColor];
    [_leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left];
    [self.view addSubview:_leftTableView];
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(kLeftTableViewWidth, 0, SCREEN_WIDTH, SCREEN_HEIGHT -80)];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.rowHeight = 80;
    _rightTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _rightTableView.showsVerticalScrollIndicator = NO;
    [_rightTableView registerClass:[RightTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Right];
    [self.view addSubview:_rightTableView];
    [self.view addSubview:self.subbtn];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionNone];
    
    _docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //使用沙盒存储文件
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path1 = [paths objectAtIndex:0];
    NSString *filePath = [path1 stringByAppendingPathComponent:@"adds.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    if(!result){
        NSString *filepath = [_docDir stringByAppendingPathComponent:@"adds.plist"];
        NSMutableArray *arr = [NSMutableArray new];
        BOOL is1=[arr writeToFile:filepath atomically:YES];
    }
}

//每次进入此页面，都要先调用此方法，进行表格内容刷新

- (void)viewWillAppear:(BOOL)animated
{
    [_rightTableView reloadData];
}
#pragma mark - Getters

- (NSMutableArray *)categoryData
{
    if (!_categoryData)
    {
        _categoryData = [NSMutableArray array];
    }
    return _categoryData;
}

- (NSMutableArray *)foodData
{
    if (!_foodData)
    {
        _foodData = [NSMutableArray array];
    }
    return _foodData;
}

//- (UITableView *)leftTableView
//{
//    if (!_leftTableView)
//    {
//        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftTableViewWidth, SCREEN_HEIGHT-80)];
//        _leftTableView.delegate = self;
//        _leftTableView.dataSource = self;
//        _leftTableView.rowHeight = 55;
//        _leftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        _leftTableView.tableFooterView = [UIView new];
//        _leftTableView.showsVerticalScrollIndicator = NO;
//        _leftTableView.separatorColor = [UIColor clearColor];
//        [_leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left];
//    }
//    return _leftTableView;
//}
-(UIButton *)subbtn{
    if(!_subbtn){
        _subbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT-80-64-49+10, VCSelfWidth-20, 60)];
        _subbtn.backgroundColor = [UIColor orangeColor];
        [_subbtn setTitle:@"提交" forState:UIControlStateNormal];
        _subbtn.layer.cornerRadius = 10;
        [_subbtn addTarget:self action:@selector(subtnClcik) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subbtn;
}

//- (UITableView *)rightTableView
//{
//    if (!_rightTableView)
//    {
//
//    }
//    return _rightTableView;
//}

#pragma mark - TableView DataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_leftTableView == tableView)
    {
        return 1;
    }
    else
    {
        return self.categoryData.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_leftTableView == tableView)
    {
        return self.categoryData.count;
    }
    else
    {
        return [self.foodData[section] count];
    }
}
-(void)subtnClcik{
    NSLog(@"%@",_Arrdic);
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if(![user objectForKey:@"name"]){
        jxt_showAlertTitle(@"请先完善个人信息");
        self.tabBarController.selectedIndex =2;
    }else if(_Arrdic.count >0){
        NSString *filePath = [_docDir stringByAppendingPathComponent:@"adds.plist"];
        NSMutableArray *datasArr = [NSMutableArray arrayWithContentsOfFile:filePath];
        [datasArr addObject:_Arrdic];
        BOOL isq= [datasArr writeToFile:filePath atomically:YES];
         [LCProgressHUD showLoading:@"提交中"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [LCProgressHUD hide];
            if(isq){
                jxt_showAlertTitle(@"提交成功,请尽快前往餐厅付款并用餐");
            }
        });
       
    }else{
        [LCProgressHUD showMessage:@"您还没有选择菜品"];
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];
        FoodModel *model = self.categoryData[indexPath.row];
        cell.name.text = model.name;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Right forIndexPath:indexPath];
        FoodModel *model = self.foodData[indexPath.section][indexPath.row];
        cell.model = model;
//        cell.countLab.hidden = YES;
//        cell.reduceBT.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.plusBlock = ^(NSInteger count, NSString *str) {
            NSString *counts = [NSString stringWithFormat:@"%ld",(long)count];
            NSString *foodid = [NSString stringWithFormat:@"%@",model.foodId];
            if([str isEqualToString:@"增加"])
            {
                
                [self.Arrdic setObject:counts forKey:foodid];

            }else if ([str isEqualToString:@"减少"]){
                self.Arrdic[foodid] = counts;
                if([counts isEqualToString:@"0"]){
                    [self.Arrdic removeObjectForKey:foodid];
                }
            }
            NSLog(@"arrdic=%@",self.Arrdic);
        };
        
        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
        _selectIndex = indexPath.row;
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
    }else{
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_rightTableView == tableView)
    {
        return 20;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_rightTableView == tableView)
    {
        TableViewHeaderView *view = [[TableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        FoodModel *model = self.categoryData[section];
        view.name.text = model.name;
        return view;
    }
    return nil;
}

// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView)
        && !_isScrollDown
        && (_rightTableView.dragging || _rightTableView.decelerating))
    {
        [self selectRowAtIndexPath:section];
    }
}

// TableView分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView)
        && _isScrollDown
        && (_rightTableView.dragging || _rightTableView.decelerating))
    {
        [self selectRowAtIndexPath:section + 1];
    }
}



// 当拖动右边TableView的时候，处理左边TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UISrcollViewDelegate
// 标记一下RightTableView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;

    UITableView *tableView = (UITableView *) scrollView;
    if (_rightTableView == tableView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
