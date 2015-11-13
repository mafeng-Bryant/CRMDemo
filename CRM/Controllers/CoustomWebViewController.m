//
//  CoustomWebViewController.m
//  CRM
//
//  Created by 马峰 on 15-1-10.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import "CoustomWebViewController.h"
#import "RRToken.h"
#import "RRLoader.h"
#import "SVProgressHUD.h"
#import "Toast+UIView.h"
#import "AppDelegate.h"
#import "showViewController.h"

@interface CoustomWebViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIAlertViewDelegate>

{
    NSString* webViewUrl;
}
@property(nonatomic,strong) UIWebView* webView;
@property(nonatomic,assign) BOOL secondLoad;
@property(nonatomic,strong) NSString* jsString;
@property(nonatomic,strong) AppDelegate* shareAppDelegate;

@end

@implementation CoustomWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.navigationItem.hidesBackButton = YES;
    
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationback.png"] forBarMetrics:UIBarMetricsDefault];
    self.secondLoad = NO;
    self.shareAppDelegate = [AppDelegate getInstance];
    UILabel* label = [[UILabel alloc]init];
    label.frame = CGRectMake(0.0, 0.0, 100, 20);
    label.font = [UIFont systemFontOfSize:18];
    label.text = self.titleString;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    
    UIImage* backImage = [UIImage imageNamed:@"navitem_back"];
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 80.0, 40.0);
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, -35.0, 0.0, 0.0);
    backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
    backButton.backgroundColor = [UIColor clearColor];
    backButton.tag = 1;
    [backButton addTarget:self action:@selector(backButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [SVProgressHUD showWithStatus:@"加载中"];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    self.webView.scrollView.scrollEnabled = NO;
    webViewUrl = [BASE_URL stringByAppendingString:self.url];
    [self.view addSubview:self.webView];
    [self loadWebView];

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    
}
-(void)dealloc
{
    self.webView.delegate = nil;
  
    
}
//名片全能王method
- (void)showInfo
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:NULL];
    
}
- (void)inputImage
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController*  imagePickController = [[UIImagePickerController alloc] init];
        imagePickController.delegate = self;
        [self presentViewController:imagePickController animated:YES completion:nil];
        self.view.userInteractionEnabled = NO;
    }
    
}
#pragma mark UIImageControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:^{
        
        
        showViewController* show = [[showViewController alloc]initWithNibName:@"showViewController" bundle:nil];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.view.userInteractionEnabled = YES;
    }];
}

- (void)backButtonMethod:(UIButton*)bt
{
  [self.navigationController popViewControllerAnimated:NO];
}
- (void)loadWebView
{
    NSString* s = [webViewUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:s]]];
    [SVProgressHUD dismiss];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"url = %@",request.URL);
    if ([[[request URL] absoluteString] isEqualToString:webViewUrl]) {
        
        return  YES;
        
    }else if([[[[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] substringFromIndex:30] isEqualToString:@"${app}"]) {
        
        NSString *requestString = [[request URL] absoluteString];
        NSString* s = [requestString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString* subString = [s substringFromIndex:30];
        if ([subString isEqualToString:@"${app}"])
            [self showInfo];
        
        return NO;
    }else if([[[[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] substringFromIndex:30] isEqualToString:@"Ecp.Homepage.PadIndex.mpp"]){
        
        NSString *requestString = [[request URL] absoluteString];
        NSString* s = [requestString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString* subString = [s substringFromIndex:30];
        if ([subString isEqualToString:@"Ecp.Homepage.PadIndex.mpp"])
        {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        return NO;
        
    }else if ([[[[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] substringFromIndex:30] isEqualToString:@"pad-login.jsp"]){
        NSString *requestString = [[request URL] absoluteString];
        NSString* s = [requestString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString* subString = [s substringFromIndex:30];
        if ([subString isEqualToString:@"pad-login.jsp"])
        {
            
            [self.shareAppDelegate showLoginView];
        }
        return NO;
        
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.secondLoad) {
        
        [self.webView stringByEvaluatingJavaScriptFromString:
         self.jsString];
    }
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
}
- (void)showMessage:(NSString*)msg
{
    UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    [alerview show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
