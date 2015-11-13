//
//  WViewController.m
//  CRM
//
//  Created by 马峰 on 15-1-10.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import "WViewController.h"
#import "RRToken.h"
#import "RRLoader.h"
#import "SVProgressHUD.h"
#import "Toast+UIView.h"
#import "AppDelegate.h"
#import "showViewController.h"
#import "MainMenuViewController.h"
#import "JSONKit.h"
#import "OrderHomeViewController.h"


@interface WViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIAlertViewDelegate,backDelegate>

{
    NSString* webViewUrl;
}
@property(nonatomic,strong) UIWebView* webView;
@property(nonatomic,assign) BOOL secondLoad;
@property(nonatomic,strong) NSString* jsString;
@property(nonatomic,strong) AppDelegate* shareAppDelegate;
@property(nonatomic,assign) BOOL hasEnter;

//扫描信息
@property(nonatomic,strong) NSDictionary* dicInfo;



@end

@implementation WViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
 
    self.secondLoad = NO;
    self.shareAppDelegate = [AppDelegate getInstance];
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
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    if (self.secondLoad) {
        
        NSString* jsonString = [self.dicInfo JSONString];
        NSString* s = [webViewUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        self.jsString  = [NSString stringWithFormat:@"myFunction('%@')", jsonString];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:s]]];
    }
    
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
        show.delegate = self;
        show.dataDic = [NSMutableDictionary dictionary];
    }];
}
- (void)sendMessageWithDic:(NSDictionary*)dic
{
   self.secondLoad = YES;
    self.dicInfo =dic;
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
       
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if ([subString isEqualToString:@"pad-login.jsp"])
        {
           [self.shareAppDelegate showLoginView];
        }
        return NO;
        
    }else if  ( [[[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"Crm.Order.PadServerList.mpp"].length>0){
        
        OrderHomeViewController* order = [[OrderHomeViewController alloc]initWithNibName:@"OrderHomeViewController" bundle:nil];
        [self.navigationController pushViewController:order animated:YES];
        
        return NO;
        
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithStatus:@"正在加载" maskType:SVProgressHUDMaskTypeNone];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.secondLoad) {
        
        [self.webView stringByEvaluatingJavaScriptFromString:
         self.jsString];
    }
    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
}
- (void)showMessage:(NSString*)msg
{
    UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    [alerview show];
}


@end
