//
//  ThirdViewController.m
//  西牛点餐
//
//  Created by 叶凡 on 2019/8/5.
//  Copyright © 2019 yefan. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "AboutViewController.h"
@interface PersonalCenterViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UILabel *fenqu;
@property (nonatomic,strong)UILabel *name1;
@property (nonatomic,strong)UILabel *bumen1;
@property (nonatomic,strong)UILabel *phone1;
@property (nonatomic,strong)NSUserDefaults *userde;
@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
     _userde = [NSUserDefaults standardUserDefaults];
    [self loadwithviesw];
    self.navigationItem.title = @"个人中心";
    [self laodtabview];
   
}

-(void)loadwithviesw{
    UIView *headview  = [[UIView alloc]initWithFrame:CGRectMake(20, 120, VCSelfWidth-40, 90)];
    headview.backgroundColor = [UIColor whiteColor];
    headview.layer.cornerRadius = 10;
    [self.view addSubview:headview];

    
    UILabel *names = [[UILabel alloc]initWithFrame:CGRectMake(20, 7.5, 50, 30)];
    names.text = @"姓名:";
    names.textAlignment = NSTextAlignmentRight;
    names.font = [UIFont systemFontOfSize:16.0f];
    [headview addSubview:names];
    
    _name1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 7.5, VCSelfWidth-20-90, 30)];
    _name1.text = [_userde objectForKey:@"name"];
    _name1.textAlignment = NSTextAlignmentLeft;
    _name1.font = [UIFont systemFontOfSize:16.0f];
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnclickdata:)];
    [_name1 addGestureRecognizer:tapGesture1];
    _name1.tag = 01;
    _name1.userInteractionEnabled = YES;
    [headview addSubview:_name1];
    
    UIView * lin2 = [[UIView alloc]initWithFrame:CGRectMake(0, 45, headview.frame.size.width, 1)];
    lin2.backgroundColor =[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [headview addSubview:lin2];

    
    UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(20, 52.5, 50, 30)];
    phone.text = @"手机:";
    phone.textAlignment = NSTextAlignmentRight;
    phone.font = [UIFont systemFontOfSize:16.0f];
    [headview addSubview:phone];
    
    _phone1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 52.5, VCSelfWidth-20-90, 30)];
    _phone1.text = [_userde objectForKey:@"phone"];
    _phone1.textAlignment = NSTextAlignmentLeft;
    _phone1.font = [UIFont systemFontOfSize:16.0f];
    UITapGestureRecognizer *tapGesture4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnclickdata:)];
    [_phone1 addGestureRecognizer:tapGesture4];
    _phone1.tag = 02;
    _phone1.userInteractionEnabled = YES;
    [headview addSubview:_phone1];
    
}

-(void)laodtabview{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 240, VCSelfWidth, VCSelfHeight-240)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.scrollEnabled = NO;
    _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableview];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
    NSArray *arr = @[@"关于我们",@"清除缓存",@"退出登录"];
    
    cell.textLabel.text = [arr objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.layer.borderColor = [UIColor colorWithRed:227/255.0 green:226/255.0 blue:229/255.0 alpha:1].CGColor;
    cell.layer.borderWidth = 1;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        AboutViewController *about = [[AboutViewController alloc]init];
        about.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:about animated:YES];
    }else if (indexPath.row == 1){
        [LCProgressHUD showLoading:@"正在清理"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [LCProgressHUD showMessage:@"清理成功"];
        });
    }else{
        UIActionSheet *myActionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                    destructiveButtonTitle:nil
                                                         otherButtonTitles:@"退出登录",nil];
        [myActionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self Exit];
            break;
        case 1:
            break;
    }
}
-(void)Exit{
    [_userde removeObjectForKey:@"name"];
    [_userde removeObjectForKey:@"p4"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"postviewflag"];
    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
            window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}
-(void)btnclickdata:(UITapGestureRecognizer *)gesture{
    if(gesture.view.tag == 01){
        [self jxt_showAlertWithTitle:@"请输入姓名"
                             message:nil
                   appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                       alertMaker.
                       addActionDestructiveTitle(@"取消").
                       addActionDestructiveTitle(@"确定");
                       [alertMaker addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                           textField.placeholder = @"支持汉字,字母";
                       }];
                   } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                       if(buttonIndex == 1){
                           UITextField *textField = alertSelf.textFields.firstObject;
                           NSString *fieText = textField.text;
                           if([fieText isEqualToString:@""]){
                               [LCProgressHUD showMessage:@"姓名不能为空"];
                           }else{
                               [LCProgressHUD showSuccess:@"修改成功"];
                               self.name1.text = fieText;
                               [self.userde setObject:fieText forKey:@"name"];
                           }
                       }
                   }];
    }else if (gesture.view.tag == 02){
        [self jxt_showAlertWithTitle:@"请输入手机号"
                             message:nil
                   appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                       alertMaker.
                       addActionDestructiveTitle(@"取消").
                       addActionDestructiveTitle(@"确定");
                       [alertMaker addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                           textField.placeholder = @"只支持数字";
                       }];
                   } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                       if(buttonIndex == 1){
                           UITextField *textField = alertSelf.textFields.firstObject;
                           NSString *fieText = textField.text;
                           if([fieText isEqualToString:@""]){
                               [LCProgressHUD showMessage:@"手机号不能为空"];
                           }else{
                               [LCProgressHUD showSuccess:@"修改成功"];
                               self.phone1.text = fieText;
                               [self.userde setObject:fieText forKey:@"phone"];
                           }
                       }
                   }];
    }
}
@end
