//
//  LogoutViewController.m
//  diancha
//
//  Created by Fang on 14-7-8.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import "LogoutViewController.h"
#import "AppDelegate.h"
#import "RRToken.h"
#import "RRLoader.h"
#import "SVProgressHUD.h"
#import "Toast+UIView.h"
#import "DejalActivityView.h"



@interface LogoutViewController ()
@end

@implementation LogoutViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 12;

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_logout_click:(id)sender
{
   // [SVProgressHUD showWithStatus:@"退出登录中..."];
    
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"退出登录中..." width:0];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    
    AppDelegate *d = [AppDelegate getInstance];
    [d didLogin];
    
//    
//    
//    NSString* token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
//    [SVProgressHUD showWithStatus:@"退出登录中..."];
//    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, LOGOUT_URL];
//    
//	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
//    [req setParam:token forKey:@"token"];
//    [req setHTTPMethod:@"POST"];
//	
//	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
//	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLogOut:)];
//	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
//	[loader loadwithTimer];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [DejalBezelActivityView removeViewAnimated:YES];
    

}

- (void) onLogOut: (NSNotification *)notify
{
	RRLoader *loader = (RRLoader *)[notify object];
	
	NSDictionary *json = [loader getJSONData];
    
	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
	
        //login fail
	if (![[json objectForKey:@"success"] boolValue])
	{
        [SVProgressHUD dismissWithError:[[json objectForKey:@"data"] objectForKey:@"msg"]];
		return;
	}
    
    AppDelegate *d = [AppDelegate getInstance];
    [d showLoginView];
}

- (void) onLoadFail: (NSNotification *)notify
{
   // [SVProgressHUD dismissWithError:@"网络错误!" afterDelay:1.5f];
    [DejalBezelActivityView removeViewAnimated:YES];
    [self.view makeToast:@"网络错误!" duration:2 position:@"center"];
    
	RRLoader *loader = (RRLoader *)[notify object];
	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
}

- (IBAction)btn_cancel_click:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked)]) {
        [self.delegate cancelButtonClicked];
    }

}
@end
