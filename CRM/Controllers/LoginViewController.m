//
//  LoginViewController.m
//  CRM
//
//  Created by 马峰 on 14-11-26.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "LoginViewController.h"
#import "PAImageView.h"
#import "BECheckBox.h"
#import "CoustomField.h"
#import "SVProgressHUD.h"
#import "MainMenuViewController.h"
#import "Toast+UIView.h"
#import "RRLoader.h"
#import "RRToken.h"
#import "NSString+MD5Addition.h"
#import "AppDelegate.h"
#import "UrlImageView.h"

#import "DejalActivityView.h"


@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) UIImageView* imageView;
@property(nonatomic,strong) UIImageView* leftImageView;
@property(nonatomic,strong) UITextField* userNameField;
@property(nonatomic,strong) UITextField* passwordFiled;

@property(nonatomic,strong) BECheckBox* box;
@property(nonatomic,strong) UrlImageView* urlImageView;


@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShowFrame:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHideFrame:) name:UIKeyboardWillHideNotification object:nil];
    
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    self.imageView.image = [UIImage imageNamed:@"background.png"];
   [self.view addSubview:self.imageView];
    
    UIImage* logImage = [UIImage imageNamed:@"logo_new.png"];
    self.leftImageView = [[UIImageView alloc]init];
    self.leftImageView.frame = CGRectMake(13, 13,logImage.size.width/2 ,logImage.size.height/2);
    self.leftImageView.image = logImage;
    [self.view addSubview:self.leftImageView];
    
    UILabel* mainLabel = [[UILabel alloc]init];
    mainLabel.frame = CGRectMake(CGRectGetMaxX(self.leftImageView.frame)+10, 10,200, 40);
    mainLabel.textColor = [UIColor whiteColor];
    mainLabel.text = @"伊示雅客服关系管理系统";
    mainLabel.font = [UIFont systemFontOfSize:18.0];
    [self.view addSubview:mainLabel];
    
    
    
    UIButton* aboutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutButton.frame = CGRectMake(840,20, 100, 40);
    [aboutButton setTitle:@"关于伊示雅" forState:UIControlStateNormal];
    aboutButton.titleLabel.font = [UIFont systemFontOfSize:19.0]
    ;
    [aboutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [aboutButton addTarget:self action:@selector(aboutMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aboutButton];
    
    

    UILabel* lineLabel = [[UILabel alloc]init];
    lineLabel.frame = CGRectMake(CGRectGetMaxX(aboutButton.frame)+20, 18, 2, 40);
    UIColor* colorone = [UIColor colorWithRed:193.0/255 green:193.0/255 blue:193.0/255 alpha:1.0];
    lineLabel.backgroundColor =colorone;
    [self.view addSubview:lineLabel];
    
    
    UIImage* helpImage = [UIImage imageNamed:@"help.png"];
    UIButton* helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    helpButton.frame = CGRectMake(CGRectGetMaxX(lineLabel.frame)+20,24, helpImage.size.width/2.0,helpImage.size.height/2.0);
    [helpButton setImage:helpImage forState:UIControlStateNormal];
    [helpButton addTarget:self action:@selector(helpButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:helpButton];
    
    
    UIView* loginView = [[UIView alloc]init];
    loginView.frame = CGRectMake(0, 0, 360, 360);
    loginView.center = self.imageView.center;
    loginView.layer.cornerRadius = 60.0;
    loginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loginView];
    
    
    
    CGFloat imageSize = 97;
    UIImage* avatorImage = [UIImage imageNamed:@"avator.png"];
//     PAImageView *avaterImageView = [[PAImageView alloc]initWithFrame:CGRectMake((loginView.frame.size.width-avatorImage.size.width/2.0)/2.0, 25.0, imageSize, imageSize) backgroundProgressColor:avatorColor progressColor:[UIColor clearColor]];
//    [loginView addSubview:avaterImageView];
//    [avaterImageView setDefaultImage:avatorImage];

    self.urlImageView = [[UrlImageView alloc] initWithFrame:CGRectMake((loginView.frame.size.width-avatorImage.size.width/2.0)/2.0, 25.0, imageSize, imageSize)];
    _urlImageView.layer.masksToBounds = YES;
    _urlImageView.layer.cornerRadius = 97/2.0;
    _urlImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _urlImageView.layer.borderWidth = 0.2f;
    _urlImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _urlImageView.layer.shouldRasterize = YES;
    _urlImageView.clipsToBounds = YES;
    [loginView addSubview:_urlImageView];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"avatarId"]) {
    
        NSString* url = [BASE_URL stringByAppendingFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"avatarId"]];
        [self.urlImageView setImageFromUrl:YES withUrl:url];
    
    }else {
        UIImage* avatorImage = [UIImage imageNamed:@"defaultavator.png"];

       self.urlImageView.image =avatorImage;
    }
    UILabel* loginLabel = [[UILabel alloc]init];
    loginLabel.frame = CGRectMake(CGRectGetMinX(self.urlImageView.frame), CGRectGetHeight(self.urlImageView.frame)+35, 200, 40);
    loginLabel.textColor = [UIColor colorWithRed:71.0/255 green:100.0/255 blue:111.0/255 alpha:1.0];
    loginLabel.text = @"登录系统";
    loginLabel.font = [UIFont systemFontOfSize:25.0];
    [loginView addSubview:loginLabel];
  
  
    
    self.userNameField = [[UITextField alloc] initWithFrame:CGRectMake(30.0, 195.0-15, 200, 30)];
    self.userNameField.backgroundColor = [UIColor clearColor];
    self.userNameField.returnKeyType = UIReturnKeyDone;
    self.userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userNameField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.userNameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.userNameField.delegate = self;
    self.userNameField.placeholder = @"用户名";
    [loginView addSubview:self.userNameField];
    UIColor* color = [UIColor colorWithRed:193.0/255 green:193.0/255 blue:193.0/255 alpha:1.0];
    [self.userNameField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [  self.userNameField setValue:[UIFont boldSystemFontOfSize:19] forKeyPath:@"_placeholderLabel.font"];
    
  
    UILabel* userlineLabel = [[UILabel alloc]init];
    userlineLabel.frame = CGRectMake(self.userNameField.frame.origin.x,CGRectGetMaxY(self.userNameField.frame)+10, loginView.frame.size.width-60, 1);
    userlineLabel.backgroundColor = [UIColor colorWithRed:193.0/255 green:193.0/255 blue:193.0/255 alpha:1.0];
    [loginView addSubview:userlineLabel];
    
    
    self.passwordFiled = [[UITextField alloc] initWithFrame:CGRectMake(30.0, CGRectGetMaxY(userlineLabel.frame)+15-12, 200, 30)];
     self.passwordFiled .backgroundColor = [UIColor clearColor];
      self.passwordFiled .returnKeyType = UIReturnKeyDone;
      self.passwordFiled .clearButtonMode = UITextFieldViewModeWhileEditing;
      self.passwordFiled .autocapitalizationType = UITextAutocapitalizationTypeWords;
      self.passwordFiled .contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.passwordFiled.delegate = self;
    self.passwordFiled.secureTextEntry = YES;
    self.passwordFiled.placeholder = @"密码";

   [loginView addSubview:self.passwordFiled];
    [self.passwordFiled setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    [  self.passwordFiled setValue:[UIFont boldSystemFontOfSize:19] forKeyPath:@"_placeholderLabel.font"];
    
    
    UIImage* normalImage = [UIImage imageNamed:@"enter.png"];
    UIImage* highedImage = [UIImage imageNamed:@"highenter.png"];
    UIButton* enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    enterButton.frame = CGRectMake(loginView.frame.size.width -60,CGRectGetMaxY(userlineLabel.frame)+7,normalImage.size.width/2.0, normalImage.size.height/2.0);
    [enterButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [enterButton setBackgroundImage:highedImage forState:UIControlStateHighlighted];
    [enterButton addTarget:self action:@selector(enterButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:enterButton];
    
    
    UILabel* passwordlineLabel = [[UILabel alloc]init];
    passwordlineLabel.frame = CGRectMake(self.userNameField.frame.origin.x,CGRectGetMaxY(self.passwordFiled.frame)+10, loginView.frame.size.width-60, 1);
    passwordlineLabel.backgroundColor = [UIColor colorWithRed:193.0/255 green:193.0/255 blue:193.0/255 alpha:1.0];
    [loginView addSubview:passwordlineLabel];
    
    UIImage* chectImage = [UIImage imageNamed:@"passwordmark.png"];
     self.box = [[BECheckBox alloc]initWithFrame:CGRectMake(34, CGRectGetMaxY(passwordlineLabel.frame)+30, chectImage.size.width-10, chectImage.size.height-10)];
    [self.box addTarget:self action:@selector(clickMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.box.isChecked = YES;
    [loginView addSubview:self.box];
    
    UILabel* remberLabel = [[UILabel alloc]init];
    remberLabel.frame = CGRectMake(CGRectGetMaxX(self.box.frame)+5, CGRectGetMaxY(passwordlineLabel.frame)+22, 200, 40);
    remberLabel.textColor = [UIColor colorWithRed:71.0/255 green:100.0/255 blue:111.0/255 alpha:1.0];
    remberLabel.text = @"记住登录名";
    remberLabel.font = [UIFont systemFontOfSize:17.0];
    [loginView addSubview:remberLabel];
    
    
    UIButton* findPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    findPasswordButton.frame = CGRectMake(CGRectGetMaxX(self.box.frame)+125, CGRectGetMaxY(passwordlineLabel.frame)+22, 200, 40);
    [findPasswordButton setTitle:@"找回密码?" forState:UIControlStateNormal];
    findPasswordButton.titleLabel.font = [UIFont systemFontOfSize:17.0]
    ;
    [findPasswordButton setTitleColor:[UIColor colorWithRed:71.0/255 green:100.0/255 blue:111.0/255 alpha:1.0] forState:UIControlStateNormal];
    [findPasswordButton addTarget:self action:@selector(findPasswordMethod:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:findPasswordButton];
    
    
    
    UILabel* downLabelOne = [[UILabel alloc]init];
    downLabelOne.frame = CGRectMake(500,self.imageView.frame.size.height-30, 600, 20);
    downLabelOne.textColor = [UIColor whiteColor];
    downLabelOne.text = @"伊示雅客服关系管理系统 ｜©伊示雅咖啡版权所有 Copyright ©2015 Ishijah Coffee";
    downLabelOne.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:downLabelOne];
    
    NSString* username = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    NSString* password = [[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    NSString* token =[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    self.userNameField.text = username;
    self.passwordFiled.text = password;
//    if (username && password && token) {
//       
//       [[AppDelegate getInstance]didLogin];
//    }
    
    
  
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
    
}
- (void)enterButtonMethod:(UIButton*)bt
{
    if (![self.userNameField.text length]) {
        [self.view makeToast:@"用户名不能为空"];
        return;
    }
    
    if (![self.passwordFiled.text length]) {
        [self.view makeToast:@"密码不能为空"];
        return;
    }
    [self.userNameField resignFirstResponder];
    [self.passwordFiled resignFirstResponder];
    
    [self login];
    
}
- (void)login
{
//    NSString* idfaString = [[UIDevice currentDevice].identifierForVendor UUIDString];
    
    
    NSString *deviceid;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceId"]) {
        deviceid = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceId"];
    }
    else
    {
        CFUUIDRef deviceId = CFUUIDCreate (NULL);
        CFStringRef deviceIdStringRef = CFUUIDCreateString(NULL,deviceId);
        CFRelease(deviceId);
        NSString *deviceIdString = (__bridge NSString *)deviceIdStringRef;
        CFRelease(deviceIdStringRef);
        deviceid = [deviceIdString stringFromMD5];
        [[NSUserDefaults standardUserDefaults] setObject:deviceid forKey:@"deviceId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    //[SVProgressHUD showWithStatus:@"登录中"];
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"登录中..." width:0];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, LOGIN_URL];
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
	[req setParam:self.userNameField.text forKey:@"loginName"];
	[req setParam:self.passwordFiled.text forKey:@"password"];
    [req setParam:deviceid forKey:@"deviceId"];
    [req setParam:DEVICETYPE forKey:@"deviceType"];
	[req setParam:[[UIDevice currentDevice] model] forKey:@"deviceDetail"];
	[req setParam:[NSString stringWithFormat:@"%lu*%lu",(unsigned long)[[[UIScreen mainScreen] currentMode]size].width,(unsigned long)[[[UIScreen mainScreen] currentMode]size].height] forKey:@"resolution"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]) {
        [req setParam:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"] forKey:@"deviceToken"];
    }
    
	[req setHTTPMethod:@"POST"];
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoaded:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];

}
- (void) onLoaded: (NSNotification *)notify
{
   
    [SVProgressHUD dismiss];
	RRLoader *loader = (RRLoader *)[notify object];
	
    NSDictionary *json = [loader getJSONData];
	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
	
	//login fail
	if (![[json objectForKey:@"success"] boolValue])
	{
        [DejalBezelActivityView removeViewAnimated:YES];
      //  [SVProgressHUD dismiss];
        if ([[json objectForKey:@"data"] objectForKey:@"msg"] )
       [self.view makeToast:[[json objectForKey:@"data"] objectForKey:@"msg"] ];
		return;
	}
	
	NSDictionary *data = [json objectForKey:@"data"];
    NSDictionary *user = [data objectForKey:@"user"];
    
    RRToken *token = [[RRToken alloc] initWithUID:[data objectForKey:@"id"]];
    
    //set token
    [token setProperty:[data objectForKey:@"token"] forKey:@"tokensn"];
    
    
    NSString* sessionName = [data objectForKey:@"SESSIONNAME"];
    [[NSUserDefaults standardUserDefaults]setObject:sessionName forKey:@"sessionName"];
    
    [[NSUserDefaults standardUserDefaults]setObject:[user objectForKey:@"avatarId"] forKey:@"avatarId"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    
    [token setProperty:[data objectForKey:@"id"] forKey:@"id"];
    [token setProperty:[user objectForKey:@"avatarId"] forKey:@"avatar"];
    [token setProperty:[user objectForKey:@"storeId"] forKey:@"storeId"];
    [token setProperty:[user objectForKey:@"storeName"] forKey:@"storeName"];
    [token setProperty:[user objectForKey:@"loginName"] forKey:@"loginName"];
    
    //write token to local file
    [token saveToFile];
    
    if (self.box.isChecked) {
        [[NSUserDefaults standardUserDefaults]setObject:self.userNameField.text forKey:@"username"];
        [[NSUserDefaults standardUserDefaults]setObject:self.passwordFiled.text forKey:@"password"];
        [[NSUserDefaults standardUserDefaults]setObject:[data objectForKey:@"token"] forKey:@"token"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }else {
        
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"username"];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [DejalBezelActivityView removeViewAnimated:YES];

    
    if ([_delegate respondsToSelector:@selector(didLogin)])
	{
		[_delegate performSelector:@selector(didLogin)];
	}
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void) onLoadFail: (NSNotification *)notify
{
    
   // [SVProgressHUD dismissWithError:@"登录失败!" afterDelay:1.5f];
    [DejalBezelActivityView removeViewAnimated:YES];
    [self.view makeToast:@"登录失败!" duration:2 position:@"center"];
	RRLoader *loader = (RRLoader *)[notify object];
	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
	
}
//记住登录名
- (void)clickMethod:(BECheckBox*)box
{
    if (box.isChecked==YES) {
    //保存用户名和密码。
  
        [[NSUserDefaults standardUserDefaults]setObject:self.userNameField.text forKey:@"username"];
        [[NSUserDefaults standardUserDefaults]setObject:self.passwordFiled.text forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] synchronize];
     }else {
         [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"username"];
         [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"password"];
         [[NSUserDefaults standardUserDefaults] synchronize];
        }
}

- (void)findPasswordMethod:(UIButton*)bt
{
   
}
- (void)keyboardShowFrame:(NSNotification*)notification
{
    
    NSDictionary* dic = notification.userInfo;
    
    CGFloat duration = [[dic objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect rect = [[dic objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
    [UIView animateWithDuration:duration animations:^{
        
        if (IOS7) {
            
            self.view.transform = CGAffineTransformMakeTranslation(0, -(rect.size.height-820.0));
        }
        if (IOS8) {
            
            self.view.transform = CGAffineTransformMakeTranslation(0, -160.0);
            
        }
    }];
    
}
- (void)keyboardHideFrame:(NSNotification*)notification
{
    NSDictionary* dic = notification.userInfo;
    
    CGFloat duration = [[dic objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
   // CGRect rect = [[dic objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
 
    
    [UIView animateWithDuration:duration animations:^{
        
        self.view.transform = CGAffineTransformIdentity;
    }];
}
- (void)helpButtonMethod:(UIButton*)bt
{
    

}
- (void)aboutMethod:(UIButton*)bt
{

 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
