//
//  LoginViewController.m
//  快速报修
//
//  Created by 叶凡 on 2019/7/24.
//  Copyright © 2019 yefan. All rights reserved.
//

#import "LoginViewController.h"
#import "RootViewController.h"
#define loginViewHeight 130


#define loginTintColor [UIColor colorWithRed:44.0f/255.0f green:106.0f/255.0f blue:152.0f/255.0 alpha:1]
@interface LoginViewController ()<UITextFieldDelegate>{

    UIImageView *passwdIgmgs;
    UITextField *pwdField1;

    UITextField *userersfield;
    UIButton *loginsBtns;
    UIImageView *backImgsView;
    UIImageView *agentImage2;
    UIImageView *logoImagesViews;
    UIView *logviews;
    BOOL isAgreedAsgreementas;
    UIImageView *usersImages;
    UILabel *logoNametLbeler;
    UIView *xian2;
    
}

@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;
@property(nonatomic ,strong)NSString *code;
@property (nonatomic,strong)NSString *doucumentString;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isAgreedAsgreementas=NO;
    
    backImgsView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT)];
    backImgsView.image=[UIImage imageNamed:@"log_back"];
    [self.view addSubview:backImgsView];
    
    
    logoImagesViews=[[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2, 40, 80, 80)];
    [self.view addSubview:logoImagesViews];
    logoImagesViews.image=[UIImage imageNamed:@"app_logo"];
    logoImagesViews.layer.cornerRadius=40;
    logoImagesViews.layer.masksToBounds=YES;
    
    
    logoNametLbeler=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-250)/2 ,140, 250, 20)];
    logoNametLbeler.textAlignment=NSTextAlignmentCenter;
    logoNametLbeler.text=@"ZebraRestaurant";
    logoNametLbeler.textColor=[UIColor whiteColor];
    logoNametLbeler.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:logoNametLbeler];
    [self loadLoginViews];
    
    loginsBtns=[[UIButton alloc]initWithFrame:CGRectMake(20, 350, VCSelfWidth-40, 40)];
    loginsBtns.backgroundColor=[UIColor whiteColor];
    loginsBtns.alpha = 0.6;
    loginsBtns.layer.cornerRadius=6;
    loginsBtns.layer.masksToBounds=YES;
    [loginsBtns setTitle:@"注册/登录" forState:(UIControlStateNormal)];
    loginsBtns.titleLabel.font=[UIFont systemFontOfSize:18.0];
    [loginsBtns setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.view addSubview:loginsBtns];
    
    [loginsBtns addTarget:self action:@selector(Btnlogin) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *dissmiss = [[UIButton alloc]initWithFrame:CGRectMake(VCSelfWidth-50,30,40,30)];
    [dissmiss setTitle:@"关闭" forState:UIControlStateNormal];
    [dissmiss setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dissmiss.titleLabel.font = [UIFont systemFontOfSize:17];
    [dissmiss addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:dissmiss];
    
    
    _doucumentString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"ios.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    if(!result){
        NSString *filepath = [_doucumentString stringByAppendingPathComponent:@"ios.plist"];
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        [arr addObject:@"123456"];
        [arr writeToFile:filepath atomically:YES];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//设置状态栏的颜色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return NO;
}
#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)loadLoginViews{
    logviews=[[UIView alloc]initWithFrame:CGRectMake(20, 170, SCREEN_WIDTH-40, loginViewHeight)];
//    loginView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    logviews.layer.cornerRadius=10;
    logviews.layer.masksToBounds=YES;
    logviews.backgroundColor =[UIColor whiteColor];
    logviews.alpha = 0.6;
    [self.view addSubview:logviews];
    
    
    usersImages=[[UIImageView alloc]initWithFrame:CGRectMake(10, 17.5, 32, 32)];
    [logviews addSubview:usersImages];
    usersImages.image=[UIImage imageNamed:@"userimg"];
    
    userersfield=[[UITextField alloc]initWithFrame:CGRectMake(59, 19, VCSelfWidth-40-59, 23)];
    userersfield.placeholder=@"手机号";
    userersfield.textColor = [UIColor blackColor];
    [userersfield setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    [userersfield setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    userersfield.tintColor=loginTintColor;
    [userersfield setDelegate:self];
    
    
    userersfield.keyboardType = UIKeyboardTypeASCIICapable;
    userersfield.returnKeyType = UIReturnKeyDone;
    userersfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    userersfield.autocorrectionType = UITextAutocorrectionTypeNo;
    userersfield.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [logviews addSubview:userersfield];
    
    
    
    xian2=[[UIView alloc]initWithFrame:CGRectMake(0, loginViewHeight/2-1, VCSelfWidth-40, 1)];
    [logviews addSubview:xian2];
    xian2.backgroundColor=[UIColor lightGrayColor];
    
    passwdIgmgs=[[UIImageView alloc]initWithFrame:CGRectMake(10, 84.25, 32, 32)];
    [logviews addSubview:passwdIgmgs];
    passwdIgmgs.image=[UIImage imageNamed:@"pasimg"];
    
    
    pwdField1=[[UITextField alloc]initWithFrame:CGRectMake(59, 86, VCSelfWidth-40-59, 23)];
    pwdField1.placeholder=@"请输入密码";
    pwdField1.textColor = [UIColor blackColor];
    [pwdField1 setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    [pwdField1 setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    pwdField1.tintColor=loginTintColor;
    
    [pwdField1 setDelegate:self];
    
    pwdField1.secureTextEntry=YES;
    pwdField1.keyboardType = UIKeyboardTypeASCIICapable;
    pwdField1.returnKeyType = UIReturnKeyDone;
    pwdField1.clearButtonMode = UITextFieldViewModeWhileEditing;
    pwdField1.autocorrectionType = UITextAutocorrectionTypeNo;
    pwdField1.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [logviews addSubview:pwdField1];
    

    
}
-(void)dismiss:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)Btnlogin{
    NSString *filepath = [_doucumentString stringByAppendingPathComponent:@"ios.plist"];
    NSMutableArray *wrdataarr = [NSMutableArray arrayWithContentsOfFile:filepath];
    if ([userersfield.text isEqualToString:@""] || userersfield.text == nil) {
        [LCProgressHUD showMessage:@"请输入手机号"];
        
    } else if ([pwdField1.text isEqualToString:@""] || pwdField1.text == nil) {
        [LCProgressHUD showMessage:@"请输入密码"];
    }else{
        
        if ([userersfield.text isEqualToString:@"19988887777"] && [pwdField1.text isEqualToString:wrdataarr[0]]) {
            [LCProgressHUD showLoading:@"正在登陆"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [LCProgressHUD showMessage:@"登陆成功"];
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"postviewflag"];
                NSUserDefaults *userde = [NSUserDefaults standardUserDefaults];
                [userde setObject:@"19988887777" forKey:@"phone"];
                RootViewController *root = [[RootViewController alloc]init];
                [self.navigationController pushViewController:root animated:YES];
                NSString *strMess = @"本App是为周边客户提供美味佳肴的订单预约服务,节约周边客户排队等餐时间,也方便本餐厅准备新鲜的食材,本App不提供线上付款功能,客户需到餐厅付款并就餐";
                jxt_showAlertTitle(strMess);
            });
        }else{
            [LCProgressHUD showMessage:@"密码不对，请重试"];
        }
        
        
    }
    
    
}
-(void)getValidCode:(UIButton *)sender
{
    NSScanner *scans = [NSScanner scannerWithString:userersfield.text];
    int val;
    BOOL PureInta = [scans scanInt:&val]&&[scans isAtEnd];
    NSLog(@"%d",PureInta);
    if (!PureInta || userersfield.text.length !=11)
    {
        [LCProgressHUD showMessage:@"请输入正确的手机号"];
    }
    else
    {
        
        sender.userInteractionEnabled = YES;
        self.timeCount = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
        
        
    }
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBarHidden=YES;
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self.view endEditing:YES];
}

@end

