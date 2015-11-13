//
//  WebToViewController.m
//  CRM
//
//  Created by 马峰 on 14-12-30.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "WebToViewController.h"
#import "RRToken.h"
#import "RRLoader.h"
#import "SVProgressHUD.h"
#import "Toast+UIView.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "OrderHomeViewController.h"
#import "LogoutViewController.h"
#import "DejalActivityView.h"



@interface WebToViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIAlertViewDelegate>

{
    NSString* webViewUrl;
}
@property(nonatomic,strong) UIWebView* webView;
@property(nonatomic,assign) BOOL secondLoad;
@property(nonatomic,strong) NSString* jsString;
@property(nonatomic,strong) AppDelegate* shareAppDelegate;
@property(nonatomic,assign) BOOL logOuted;


@end

@implementation WebToViewController

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
    
    self.secondLoad = NO;
    self.logOuted = NO;
    self.shareAppDelegate = [AppDelegate getInstance];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    self.webView.scrollView.scrollEnabled = NO;
    if (self.argsArr.count > 0) {
        
        NSString* url = [BASE_URL stringByAppendingString:self.url];
        NSMutableString* string = [NSMutableString string];
        for (NSDictionary* dic in self.argsArr) {
            NSString* s = [dic JSONString];
            [string appendString:s];
        }
        webViewUrl =[url stringByAppendingFormat:@"?args=%@",string];
     
    }else {
        
        webViewUrl = [BASE_URL stringByAppendingString:self.url];
    }
    
    [self loadWebView];
    
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveResponseFromCamCardOpenAPI:) name:CamCardOpenAPIDidReceiveResponseNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveRequestFromCamCardOpenAPI:) name:CamCardOpenAPIDidReceiveRequestNotification object:nil];
//}
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
    
     NSString* sesinonName = [[NSUserDefaults standardUserDefaults]objectForKey:@"sessionName"];
        NSString* token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    NSMutableDictionary *cookiePropertiesUser = [NSMutableDictionary dictionary];
    if ([sesinonName length]>0) {
        [cookiePropertiesUser setObject:sesinonName forKey:NSHTTPCookieName];
    
    }
    [cookiePropertiesUser setObject:token forKey:NSHTTPCookieValue];
    [cookiePropertiesUser setObject:Domain forKey:NSHTTPCookieDomain];
    [cookiePropertiesUser setObject:@"/" forKey:NSHTTPCookiePath];
    [cookiePropertiesUser setObject:@"0" forKey:NSHTTPCookieVersion];

    NSHTTPCookie* cookie = [NSHTTPCookie cookieWithProperties:cookiePropertiesUser];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage]setCookie:cookie];
    
    
    
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
        
    }else if([[[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"${appScan}"].length>0) {

        //    [self showInfo];
        return NO;
        
    }else if([[[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"Ecp.Homepage.PadIndex.mpp"].length>0)
    {
      [self.navigationController popViewControllerAnimated:YES];
        
        return NO;
        
    }else if ( [[[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"pad-login.jsp"].length>0){
   
        AppDelegate *d = [AppDelegate getInstance];
        [d showLoginView];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return NO;

        }else if ( [[[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:@"Crm.Order.EntitySelectList.mpp"].length>0){
    
        OrderHomeViewController* order = [[OrderHomeViewController alloc]initWithNibName:@"OrderHomeViewController" bundle:nil];
        [self.navigationController pushViewController:order animated:YES];
        
        return NO;
    
    }
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    [SVProgressHUD showWithStatus:@"正在加载" maskType:SVProgressHUDMaskTypeNone];
    [DejalBezelActivityView activityViewForView:self.view];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.secondLoad) {
        
        [self.webView stringByEvaluatingJavaScriptFromString:
         self.jsString];
        self.secondLoad = NO;
    }
   
   [SVProgressHUD dismiss];
    [DejalBezelActivityView removeViewAnimated:YES];
    
}

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
//        [self installCamCard];
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
//    // cardHolderReq.userID = UserID;
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
//        
//        self.secondLoad = YES;
//        NSString* s = [webViewUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        
//        self.jsString  = [NSString stringWithFormat:@"scanCallback(%@)", str];
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
//        hasInstall = YES;
//    }
//    else
//    {
//        hasInstall = NO;
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
//      
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[CCOpenAPI CCAppInstallUrl]]];
//}
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    
//}
@end
