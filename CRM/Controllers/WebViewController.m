//
//  WebViewController.m
//  CRM
//
//  Created by 马峰 on 14-12-22.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "WebViewController.h"
#import "RRToken.h"
#import "RRLoader.h"
#import "SVProgressHUD.h"
#import "Toast+UIView.h"
//#import <CamCardOpenAPIFramework/OpenAPI.h>
#import "AppDelegate.h"
#import "JSONKit.h"


@interface WebViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIAlertViewDelegate>

{
    NSString* webViewUrl;
}
@property(nonatomic,strong) UIWebView* webView;
@property(nonatomic,assign) BOOL secondLoad;
@property(nonatomic,strong) NSString* jsString;
@property(nonatomic,strong) AppDelegate* shareAppDelegate;


@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

      self.navigationItem.hidesBackButton = YES;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
     [[self navigationController] setNavigationBarHidden:YES animated:YES];
    self.secondLoad = NO;
    self.shareAppDelegate = [AppDelegate getInstance];

    // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationback.png"] forBarMetrics:UIBarMetricsDefault];

    
    UILabel* label = [[UILabel alloc]init];
    label.frame = CGRectMake(0.0, 0.0, 100, 20);
    label.font = [UIFont systemFontOfSize:18];
    label.text = self.titleString;
    label.textColor = [UIColor whiteColor];
   // self.navigationItem.titleView = label;
    
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
  //  self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
    
    [SVProgressHUD showWithStatus:@"加载中"];
//    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
   // self.view.backgroundColor = [UIColor whiteColor];
     self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
     self.webView.delegate = self;
     self.webView.scalesPageToFit = YES;
     self.webView.scrollView.scrollEnabled = NO;
    webViewUrl = [BASE_URL stringByAppendingString:self.url];
    [self loadWebView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveResponseFromCamCardOpenAPI:) name:CamCardOpenAPIDidReceiveResponseNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveRequestFromCamCardOpenAPI:) name:CamCardOpenAPIDidReceiveRequestNotification object:nil];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.navigationController.navigationBarHidden = YES;

}
- (void)backButtonMethod:(UIButton*)bt
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)loadWebView
{
    NSString* s = [webViewUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:s]]];
    [self.view addSubview: self.webView];
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
      //  [self showInfo];
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
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{}
////名片全能王method
//- (void)showInfo
//{
//    BOOL isStallCad = [self isCamCardInstall];
//    if (isStallCad) {
//        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//        imagePickerController.delegate = self;
//        [self presentViewController:imagePickerController animated:YES completion:NULL];
//    }else {
//        
//        NSString* msg = @"请先安装名片全能王客户端";
//        [self showMessage:msg];
//    }
//}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex ==0) {
//     [self installCamCard];
//    }
//}
//- (void) openCCWithoutImage
//{
//    CCOpenAPIRecogCardRequest *recogCardReq = [[CCOpenAPIRecogCardRequest alloc] init];
//    recogCardReq.appKey = MingPianQuanNengWangKey;
//    //recogCardReq.userID = UserID;
//    [CCOpenAPI sendRequest:recogCardReq];
//}
//- (void) openCCWithImage:(UIImage *) cardImage
//{
//    CCOpenAPIRecogCardRequest *recogCardReq = [[CCOpenAPIRecogCardRequest alloc] init];
//    recogCardReq.cardImage = cardImage;
//    recogCardReq.appKey = MingPianQuanNengWangKey;
//    //recogCardReq.userID = UserID;
//    [CCOpenAPI sendRequest:recogCardReq];
//}
//- (void) openCardHolder:(id)sender
//{
//    CCOpenAPIOpenCardHolderRequest *cardHolderReq = [[CCOpenAPIOpenCardHolderRequest alloc] init];
//    cardHolderReq.appKey = MingPianQuanNengWangKey;
//   // cardHolderReq.userID = UserID;
//    [CCOpenAPI sendRequest:cardHolderReq];
//}
//- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    UIImage *cardImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//    [self openCCWithImage:cardImage];
//}
//- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//}
//- (void) didReceiveResponseFromCamCardOpenAPI:(NSNotification *) notification
//{
//    if ([notification.object isKindOfClass:[CCOpenAPIRecogCardResponse class]] == YES)
//    {
//        CCOpenAPIRecogCardResponse *response = (CCOpenAPIRecogCardResponse *) notification.object;
//        NSString* content = response.vcfString;
//        
//        NSString* str = [content JSONString];
//        self.secondLoad = YES;
//         NSString* s = [webViewUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        
//        self.jsString  = [NSString stringWithFormat:@"myFunction('%@')", str];
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:s]]];
//
//    }
//}
//- (void) didReceiveRequestFromCamCardOpenAPI:(NSNotification *) notification
//{
//    
//}
//- (BOOL) isCamCardInstall
//{
//    BOOL hasInstall = NO;
//    if ([CCOpenAPI isCCAppInstalled])
//    {
//       hasInstall = YES;
//    }
//    else
//    {
//       hasInstall = NO;
//    }
//    return hasInstall;
//}
//- (void)showMessage:(NSString*)msg
//{
//    UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
//    [alerview show];
//}
//
//- (void) isCamCardSupportOpenApi
//{
//    NSString *msg = nil;
//    if ([CCOpenAPI isCCAppSupportAPI])
//    {
//        msg = @"CamCard support open api.";
//    }
//    else
//    {
//        msg = @"CamCard does not support open api.";
//    }
//    UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alerview show];
//}
//
//- (void) currentOpenApiVersion
//{
//    NSString *msg = [CCOpenAPI currentAPIVersion];
//    UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alerview show];
//}
//
//- (void) openCamCard{
//    
//    [CCOpenAPI openCCApp];
//}
//
//- (void) installCamCard{
//    
//[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[CCOpenAPI CCAppInstallUrl]]];
//}
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//
//}

@end
