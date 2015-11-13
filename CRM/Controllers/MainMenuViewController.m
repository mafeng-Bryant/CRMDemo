//
//  MainMenuViewController.m
//  CRM
//
//  Created by 马峰 on 15-1-23.
//  Copyright (c) 2015年 马峰. All rights reserved.
//
#import "MainMenuViewController.h"
#import "SystemConfigContext.h"
#import "MenuPageView.h"
#import "CoustomPageControl.h"
#import "PAImageView.h"
#import "PopViewController.h"
#import "DropDownListView.h"
#import "AppDelegate.h"
#import "NotificationView.h"

#import "SecondTableViewController.h"
#import "FourTableViewController.h"
#import "ThreeViewController.h"
#import "OrderHomeViewController.h"
#import "MenuControl.h"
#import "RRURLRequest.h"
#import "SVProgressHUD.h"
#import "RRToken.h"
#import "RRLoader.h"

#import "MenuIcon.h"
#import "WebViewController.h"
#import "NotificationViewController.h"
#import "FileView.h"
#import "FileViewController.h"
#import "WebToViewController.h"

#import "CoustomWebViewController.h"
#import "WViewController.h"

#import "CycleScrollView.h"
#import "AppDelegate.h"
#import "NotificationCopyViewController.h"

#import "BackViewController.h"
//#import "MBProgressHUD.h"
#import "UrlImageView.h"
#import "DejalActivityView.h"
#import "Toast+UIView.h"
#import "RWHomeCache.h"
#import "AFHTTPRequestOperationManager.h"




@interface MainMenuViewController ()<UIScrollViewDelegate,clickLoginOutDelegate,UIAlertViewDelegate,UIPopoverControllerDelegate,clickSpaceDelegate>
@property(nonatomic,strong) UIImageView* bgImageView;
@property(nonatomic,strong) UIScrollView* mainScrollView;
@property(nonatomic,strong) CycleScrollView* cycleScrollView;


@property(nonatomic,strong) CoustomPageControl* coustomPageControl;
@property(nonatomic,strong) NSMutableArray* mainMenuArray;
@property(nonatomic,strong) UIImageView* leftImageView;
@property(nonatomic,strong) UIButton* systemButton;
@property(nonatomic,strong) UIPopoverController* popViewController;
@property(nonatomic,assign) BOOL hasRoulation;
@property(nonatomic,strong) NotificationView* notificationView;
@property(nonatomic,strong) UIButton* leftButton;
@property(nonatomic,strong) UIButton* rightButton;
@property(nonatomic,assign) NSInteger index;
@property(nonatomic,strong) UIButton* systemPersonButton;

@property(nonatomic,strong) NSMutableArray* menuArray;
@property(nonatomic,strong)  FileViewController* fileVC;
@property(nonatomic,strong)  UILabel* noticountLabel;
@property(nonatomic,strong) UIImageView* cycleImageView;
@property(nonatomic,strong) PAImageView *avaterImageView;
@property(nonatomic,strong) NSTimer* timer;
@property(nonatomic,strong)     MenuPageView *pageView;
@property(nonatomic,strong) NSMutableArray* addViewsArray;

//
@property(nonatomic,assign) BOOL lastPageScroll;
@property(nonatomic,assign) BOOL firstPageScroll;
@property(nonatomic,assign) BOOL hasShow;

@property(nonatomic,assign) NSInteger scrollIndex;

@property(nonatomic,strong)     UIPopoverPresentationController* presentVC;
@property(nonatomic,strong)   UIButton* btOne;
//@property(nonatomic,strong) MBProgressHUD* HUD;

@property(nonatomic,strong) UrlImageView* avatorMyImageView;

@property(nonatomic,assign) BOOL isConnect;

@end

@implementation MainMenuViewController

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
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.addViewsArray = [NSMutableArray array];
    self.lastPageScroll = NO;
    self.firstPageScroll = YES;
    self.hasShow = NO;
    self.hasRoulation = NO;
    self.mainMenuArray = [NSMutableArray array];
    self.index = 0;
    [self addUIViews];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.fileVC) {
        
        [self.fileVC.view removeFromSuperview];
        self.fileVC = nil;
    }
    [self getHomeData];
    

}
- (void)createCacheData:(NSMutableArray*)array
{
    NSMutableArray* menuIconArray = [NSMutableArray array];
    for (int i = 0; i<array.count; i++)
    {
        MenuIcon* menuIcon = [[MenuIcon alloc]init];
        NSDictionary* dic = array[i];
        if (![dic objectForKey:@"children"]) //不存在子文件夹。
        {
            
            menuIcon.iconString = [dic objectForKey:@"icon"];
            menuIcon.iconId = [dic objectForKey:@"id"];
            menuIcon.title = [dic objectForKey:@"text"];
            menuIcon.jumpPageString = [[dic objectForKey:@"data"] objectForKey:@"page"];
            if ([[dic objectForKey:@"data"] objectForKey:@"noticeCount"]) {
                
                menuIcon.noticeCount = [[[dic objectForKey:@"data"] objectForKey:@"noticeCount"]intValue];
            }
            
            [menuIconArray addObject:menuIcon];
            
        }else
        {
            
            menuIcon.iconString = [dic objectForKey:@"icon"];
            menuIcon.iconId = [dic objectForKey:@"id"];
            menuIcon.title = [dic objectForKey:@"text"];
            menuIcon.childArray = [NSMutableArray array];
            
            NSArray* listArray = [dic objectForKey:@"children"];
            for (NSDictionary* childDic in listArray) {
                
                MenuIcon* childIcon = [[MenuIcon alloc]init];
                childIcon.iconString = [childDic objectForKey:@"icon"];
                childIcon.iconId =[childDic objectForKey:@"id"];
                childIcon.title = [childDic objectForKey:@"text"];
                
                if ([childDic objectForKey:@"data"]) {
                    
                    childIcon.jumpPageString = [[childDic objectForKey:@"data"] objectForKey:@"page"];
                    
                }else {
                    
                    childIcon.jumpPageString =@"";
                }
                
                NSArray* keys = [[childDic objectForKey:@"data"] allKeys];
                childIcon.argsArray = [NSMutableArray array];
                
                if ([keys containsObject:@"args"]) {
                    
                    
                    NSDictionary* dic = [[childDic objectForKey:@"data"] objectForKey:@"args"];
                    [childIcon.argsArray addObject:dic];
                    
                }
                
                
                if ([[childDic objectForKey:@"data"] objectForKey:@"noticeCount"]) {
                    
                    childIcon.noticeCount = [[[childDic objectForKey:@"data"] objectForKey:@"noticeCount"]intValue];
                }
                
                [menuIcon.childArray addObject:childIcon];
            }
            
            [menuIconArray addObject:menuIcon];
        }
    }
    self.menuArray = menuIconArray;
    [self addMenuViews];
    [self loadNotificationBadgeNumber];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(loadNotificationBadgeNumber) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    //移除hud
    [DejalBezelActivityView removeViewAnimated:YES];
  
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.timer) [self.timer invalidate];
    self.timer = nil;
    
}
- (void)loadNotificationBadgeNumber
{
//    if (self.isConnect) {
        RRToken *token = [RRToken getInstance];
        NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, HomeUnReadMessage_URL];
        RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
        [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
        [req setHTTPMethod:@"POST"];
        RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
        [loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoadedNotification:)];
        [loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
        [loader loadwithTimer];
  
//    }else {
//        return;
//    }
    
}
- (void)onLoadedNotification:(NSNotification *)notify
{
    RRLoader *loader = (RRLoader *)[notify object];
    NSDictionary *json = [loader getJSONData];
    
    [loader removeNotificationListener:RRLOADER_COMPLETE target:self];
    [loader removeNotificationListener:RRLOADER_FAIL target:self];
    NSDictionary *data = [json objectForKey:@"data"];
    
    if ([[data objectForKey:@"ecode"] integerValue] ==401) {
        [DejalBezelActivityView removeViewAnimated:YES];
      AppDelegate *d = [AppDelegate getInstance];
        [d showLoginView];
        //移除token
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        return;
    }
 
    //login fail
    if (![[json objectForKey:@"success"] boolValue])
    {
       // [SVProgressHUD dismissWithError:@"获取数据失败!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"获取数据失败!" duration:2 position:@"center"];
        return;
    }
    
    NSDictionary *badgeDic = [data objectForKey:@"data"];
    if ([badgeDic count] == 0) {
       // [SVProgressHUD dismissWithError:@"暂无数据!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"暂无数据!" duration:2 position:@"center"];
        return;
    }
    [SVProgressHUD dismiss];
    
    NSString* badgeCount= [[badgeDic objectForKey:@"count"] stringValue];
    //test
    if ([badgeCount integerValue]> 0) {
        self.cycleImageView.hidden = NO;
        self.noticountLabel.text = [NSString stringWithFormat:@"%d",[badgeCount integerValue]];
        
    }else {
        
        self.cycleImageView.hidden = YES;
        
    }
}
- (void)getHomeData
{
 
   
     [DejalBezelActivityView activityViewForView:self.view];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;

    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, HomeMenudata_URL];
    RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    if ([token getProperty:@"tokensn"]) {
        [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    }else {
        [req setParam:[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]
               forKey:@"token"];
    }
    [req setHTTPMethod:@"POST"];
    RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
    [loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoaded:)];
    [loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
    [loader loadwithTimer];
    
}

- (void) onLoaded: (NSNotification *)notify
{
    
    [self.menuArray removeAllObjects];
    [self.addViewsArray removeAllObjects];
    RRLoader *loader = (RRLoader *)[notify object];
    NSDictionary *json = [loader getJSONData];
    
    [loader removeNotificationListener:RRLOADER_COMPLETE target:self];
    [loader removeNotificationListener:RRLOADER_FAIL target:self];
    NSDictionary *data = [json objectForKey:@"data"];
    
    if ([[data objectForKey:@"ecode"] integerValue] ==401) {
        
        [DejalBezelActivityView removeViewAnimated:YES];
        AppDelegate *d = [AppDelegate getInstance];
        [d showLoginView];
        //移除token
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        return;
    }
    
    //login fail
    if (![[json objectForKey:@"success"] boolValue])
    {
        //[SVProgressHUD dismissWithError:@"获取数据失败!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"获取数据失败!" duration:2 position:@"center"];
        return;
    }
    
    NSArray *arr = [data objectForKey:@"data"];
    if ([arr count] == 0) {
      //  [SVProgressHUD dismissWithError:@"暂无数据!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"暂无数据!" duration:2 position:@"center"];
        return;
    }
    [SVProgressHUD dismiss];
    //写到缓存中
    NSMutableArray* array = [NSMutableArray arrayWithArray:arr];
    [RWHomeCache writeToFile:array withName:@"Cache"];
    [self createCacheData:array];
}

- (void)addUIViews
{
    
    self.bgImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.bgImageView.image = [UIImage imageNamed:@"mainback.png"];
    [self.view addSubview:self.bgImageView];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.mainScrollView.delegate = self;
    self.mainScrollView.bounces = YES;
    [self.mainScrollView setBackgroundColor:[UIColor blackColor]];
    [self.mainScrollView setCanCancelContentTouches:NO];
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.mainScrollView.clipsToBounds = YES;
    self.mainScrollView.scrollEnabled = YES;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview: self.mainScrollView];
    
    UIImage* logImage = [UIImage imageNamed:@"logo_new.png"];
    self.leftImageView = [[UIImageView alloc]init];
    self.leftImageView.frame = CGRectMake(13, 13,logImage.size.width/2.0,logImage.size.height/2.0);
    self.leftImageView.image = logImage;
    [self.view addSubview:self.leftImageView];
    
    
    UILabel* mainLabel = [[UILabel alloc]init];
    mainLabel.frame = CGRectMake(CGRectGetMaxX(self.leftImageView.frame)+10, 10,200, 40);
    mainLabel.textColor = [UIColor whiteColor];
    mainLabel.text = @"伊示雅客服关系管理系统";
    mainLabel.font = [UIFont systemFontOfSize:18.0];
    [self.view addSubview:mainLabel];
    
    //    self.avaterImageView = [[PAImageView alloc]initWithFrame:CGRectMake(710.0+30, 10.0, avatorImage.size.width/2, avatorImage.size.height/2.0) backgroundProgressColor:avatorColor progressColor:[UIColor clearColor]];
    //    [self.view addSubview: self.avaterImageView];
    // [avaterImageView setDefaultImage:avatorImage];
    
    UIImage* avatorImage = [UIImage imageNamed:@"defaultavator.png"];
    self.avatorMyImageView = [[UrlImageView alloc] initWithFrame:CGRectMake(710.0+30, 10.0, avatorImage.size.width/2, avatorImage.size.height/2.0)];
    _avatorMyImageView.layer.masksToBounds = YES;
    _avatorMyImageView.layer.cornerRadius = 19;
    _avatorMyImageView.layer.borderColor = avatorColor.CGColor;
    _avatorMyImageView.layer.borderWidth = 0.0f;
    _avatorMyImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _avatorMyImageView.layer.shouldRasterize = YES;
    _avatorMyImageView.clipsToBounds = YES;
    [self.view addSubview:_avatorMyImageView];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"avatarId"]) {
        
        NSString* url = [BASE_URL stringByAppendingFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"avatarId"]];
        [self.avatorMyImageView setImageFromUrl:YES withUrl:url];
 
    }else {
        
        self.avatorMyImageView.image =avatorImage;
    }
    self.systemPersonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.systemPersonButton.frame = CGRectMake(CGRectGetMaxX( self.avatorMyImageView.frame)+10,8,120, 45);
    self.systemPersonButton.backgroundColor = [UIColor clearColor];
    [self.systemPersonButton setTitle:@"系统管理员" forState:UIControlStateNormal];
    self.systemPersonButton.titleLabel.font = [UIFont systemFontOfSize:22];
    [self.systemPersonButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.systemPersonButton addTarget:self action:@selector(clickSystemButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.systemPersonButton];
    
    
    
    UIImage* systemImage = [UIImage imageNamed:@"arrow.png"];
    self.systemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.systemButton.frame = CGRectMake(CGRectGetMaxX(self.systemPersonButton.frame), 27.0, systemImage.size.width/2.0, systemImage.size.height/2.0);
    [self.systemButton setImage:systemImage forState:UIControlStateNormal];
    self.systemButton.backgroundColor = [UIColor clearColor];
    [self.systemButton addTarget:self action:@selector(clickSystemButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.systemButton];
    
    
    UILabel* lineLabel = [[UILabel alloc]init];
    lineLabel.frame = CGRectMake(CGRectGetMaxX(self.systemButton.frame)+20,15, 2, 45);
    UIColor* color = [UIColor colorWithRed:193.0/255 green:193.0/255 blue:193.0/255 alpha:1.0];
    lineLabel.backgroundColor =color;
    [self.view addSubview:lineLabel];
    
    
    UIImage* notiImage = [UIImage imageNamed:@"naozhong.png"];
    self.notificationView = [[NotificationView alloc]init];
    self.notificationView.frame = CGRectMake(CGRectGetMaxX(lineLabel.frame)+25, 18,notiImage.size.width/2.0, notiImage.size.height/2.0);
    self.notificationView.userInteractionEnabled = YES;
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickNotificationClick:)];
    tapGesture.numberOfTapsRequired =1;
    [self.notificationView addGestureRecognizer:tapGesture];
    self.notificationView.image = notiImage;
    [self.view addSubview:self.notificationView];
    
    UIImage* cycleImage = [UIImage imageNamed:@"cycle.png"];
    self.cycleImageView = [[UIImageView alloc]init];
    self.cycleImageView.frame = CGRectMake(18.0, 0.0, cycleImage.size.width/2.0, cycleImage.size.height/2.0);
    self.cycleImageView.hidden = YES;
    self.cycleImageView.image = cycleImage;
    [self.notificationView addSubview:self.cycleImageView];
    
    self.noticountLabel = [[UILabel alloc]init];
    self.noticountLabel.frame = CGRectMake(5.0, 2.0, 20.0, 10.0);
    self.noticountLabel.textColor = [UIColor whiteColor];
    self.noticountLabel.font = [UIFont systemFontOfSize:10];
    [self.cycleImageView addSubview:self.noticountLabel ];
    
    UIImage* helpImage = [UIImage imageNamed:@"help.png"];
    UIButton* helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    helpButton.frame = CGRectMake(CGRectGetMaxX(self.notificationView.frame)+25,18, helpImage.size.width/2.0,helpImage.size.height/2.0);
    [helpButton setImage:helpImage forState:UIControlStateNormal];
    [helpButton addTarget:self action:@selector(helpButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    //  [self.view addSubview:helpButton];
    
    
    UIImage* leftImage = [UIImage imageNamed:@"leftarrow.png"];
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(30, 768/2.0, leftImage.size.width/2.0, leftImage.size.height/2.0);
    [self.leftButton setImage:leftImage forState:UIControlStateNormal];
    self.leftButton.backgroundColor = [UIColor clearColor];
    self.leftButton.tag = 1;
    [self.leftButton addTarget:self action:@selector(clickleftButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftButton];
    
    
    UIImage* rightImage = [UIImage imageNamed:@"rightarrow.png"];
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(self.bgImageView.frame.size.width-50, 768/2.0, rightImage.size.width/2.0, rightImage.size.height/2.0);
    [self.rightButton setImage:rightImage forState:UIControlStateNormal];
    self.rightButton.backgroundColor = [UIColor clearColor];
    self.rightButton.tag =2;
    [self.rightButton addTarget:self action:@selector(clickrightButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightButton];
    
}
- (void)addMenuViews
{
    for (UIView* view in self.mainScrollView.subviews) {
        
        if ([view isKindOfClass:[MenuPageView class]]) {
            
            [view removeFromSuperview];
        }
        [view removeFromSuperview];
    }
    //自定义PageControl
    if (!_coustomPageControl) {
        _coustomPageControl = [[CoustomPageControl alloc] init] ;
        
        _coustomPageControl.frame = CGRectMake(512, 680, 50, 36);
        [_coustomPageControl setCurrentPage: 0] ;
        [_coustomPageControl setDefersCurrentPageDisplay: YES] ;
        [_coustomPageControl setType: DDPageControlTypeOnFullOffEmpty] ;
        [_coustomPageControl setOnColor: [UIColor colorWithCGColor:
                                          UIColorFromRGB(255.0, 255.0, 255.0).CGColor]];
        [_coustomPageControl setOffColor:  [UIColor colorWithCGColor:
                                            [UIColor whiteColor].CGColor]];
        [_coustomPageControl setIndicatorDiameter: 10.0f] ;
        [_coustomPageControl setIndicatorSpace: 12.0f] ;
        [self.view addSubview:_coustomPageControl];
    }
    //读首页log
    for (int i = 0; i <5; i++) {
        if (i==0) {
            
            
            MenuPageView *pageView = [[MenuPageView alloc] initWithFrame:CGRectMake(1024+0, 100,1024, 768) andMenuPageInfo:self.menuArray andTarget:self andAction:@selector(toggleMenuControl:)];
            [self.mainScrollView addSubview:pageView];
            [self.mainMenuArray addObject:pageView];
            [self.addViewsArray addObject:pageView];
            
        }
        if (i==1) {
            
            SecondTableViewController* secondVC = [[SecondTableViewController alloc]init];
            secondVC.view.frame = CGRectMake(60+1024+1024*i, 30, 1024-60*2, 768-270);
            [self addChildViewController:secondVC];
            [self.mainScrollView addSubview:secondVC.view];
            [self.addViewsArray addObject:secondVC.view];
            
        }
        if (i==2) {
            
            ThreeViewController* threeVC = [[ThreeViewController alloc]init];
            threeVC.view.frame = CGRectMake(60+1024*i+1024, 30, 1024-60*2, 768-270);
            [self addChildViewController:threeVC];
            [self.mainScrollView addSubview:threeVC.view];
            [self.addViewsArray addObject:threeVC.view];
            
        }
        
        if (i ==3) {
            
            FourTableViewController* fourVC = [[FourTableViewController alloc]init];
            fourVC.view.frame = CGRectMake(60+1024*i+1024, 30, 1024-60*2, 768-270);
            [self addChildViewController:fourVC];
            fourVC.backView = self.view;
            [self.mainScrollView addSubview:fourVC.view];
            [self.addViewsArray addObject:fourVC.view];
            
            
        }
        if (i ==4) {
            NotificationViewController* notiVC = [[NotificationViewController alloc]init];
            notiVC.view.frame = CGRectMake(60+1024*i+1024, 130, 1024-60*2, 768-230);
            [self addChildViewController:notiVC];
            [self.mainScrollView addSubview:notiVC.view];
            [self.addViewsArray addObject:notiVC.view];
            
        }
    }
    NotificationCopyViewController* notiVC = [[NotificationCopyViewController alloc]init];
    notiVC.view.frame = CGRectMake(0+60, 130, 1024, 768); // 添加最后1页在首页 循环
    [self addChildViewController:notiVC];
    notiVC.view.tag =202;
    [self.mainScrollView addSubview:notiVC.view];
    
    MenuPageView *pageView = [[MenuPageView alloc] initWithFrame:CGRectMake(1024 * ([self.addViewsArray count] + 1), 100,1024, 768) andMenuPageInfo:self.menuArray andTarget:self andAction:@selector(toggleMenuControl:)];
    [self.mainScrollView addSubview:pageView];
    
    
    [self.mainScrollView setContentSize:CGSizeMake(1024 * 7, 768)]; //  +上第1页和第5页  原理：5-[1-2-3-4-5]-1
    [self.mainScrollView setContentOffset:CGPointMake(0, 0)];
    
    [self.mainScrollView scrollRectToVisible:CGRectMake(1024,0,1024,768) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第5页
    _coustomPageControl.numberOfPages =5;
    //显示未读通知
    [self showBadges];
}
- (void)showBadges
{
    for(MenuPageView *aPageView in _mainMenuArray){
        NSArray* childView = [aPageView subviews];
        for (UIView* view in childView) {
            if ([view isKindOfClass:[MenuControl class]]) {
                MenuControl* control = (MenuControl*)view;
                MenuIcon* menuIcon = control.menuIcon;
                if (menuIcon.noticeCount >0) {
                    [control showIconBadge:[[NSNumber numberWithInt:menuIcon.noticeCount] stringValue]];
                }
                NSArray* array = menuIcon.childArray;
                for (MenuIcon* icon in array) {
                    if (icon.noticeCount > 0) {
                     [control showIconBadge:[[NSNumber numberWithInt:icon.noticeCount] stringValue]];
                    }
                    
                }
            }
        }
    }
}
-(void)toggleMenuControl:(id)sender{
    
    MenuControl *ctrl  = (MenuControl*)sender;
    MenuIcon* menuIcon = ctrl.menuIcon;
    if (menuIcon.childArray.count > 0) {
        //截图
        UIGraphicsBeginImageContext(self.view.bounds.size);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.fileVC = [[FileViewController alloc]init];
        self.fileVC.backImage = screenImage;
        self.fileVC.spaceDelegate = self;
        self.fileVC.menuIcon = menuIcon;
        self.fileVC.view.frame = CGRectMake(0.0, 0.0, 1024, 768.0);
        [self addChildViewController:self.fileVC ];
        [self.view addSubview: self.fileVC.view];
    }else {
        
        WebToViewController* webVC = [[WebToViewController alloc]init];
        webVC.url = menuIcon.jumpPageString;
        webVC.titleString = menuIcon.title;
        if ([menuIcon.jumpPageString length]>0) {
            
            [self.navigationController pushViewController:webVC animated:YES];
        }
        
        if ([menuIcon.title isEqualToString:@"客户档案"]) //名片精灵
        {
            WViewController* TT = [[WViewController alloc]init];
            TT.url =menuIcon.jumpPageString;
            TT.titleString = menuIcon.title;
            
            if ([menuIcon.jumpPageString length]>0) {
                 [self.navigationController pushViewController:TT animated:NO];
            }
            
        }else { //名片全能王
            
            WebToViewController* webVC = [[WebToViewController alloc]init];
            webVC.url = menuIcon.jumpPageString;
            webVC.titleString = menuIcon.title;
            if ([menuIcon.jumpPageString length]>0) {
                
                [self.navigationController pushViewController:webVC animated:YES];
            }
            
        }
    }
}
- (void)clickSpacebackMethod
{
    if (self.fileVC) {
        
        [self.fileVC.view removeFromSuperview];
        self.fileVC = nil;
    }
    
}

- (void)clickNotificationClick:(UITapGestureRecognizer*)tap
{
    WebToViewController* webVC = [[WebToViewController alloc]init];
    webVC.url = @"Ecp.SystemMessage.PadSimpleList.mpp";
    webVC.titleString = @"系统消息";
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)helpButtonMethod:(UIButton*)bt
{
    NSLog(@"help");
}
- (void)loginOutBack:(UIButton*)bt
{
    [self didLoginOut];
}
- (void)clickSystemButtonMethod:(UIButton*)bt
{
    if (_hasShow==NO) {
        _hasShow = YES;
        
        self.btOne.hidden = NO;
        UIImage* popImage = [UIImage imageNamed:@"pop.png"];
        if (!self.btOne) {
            self.btOne = [UIButton buttonWithType:UIButtonTypeCustom];
            
        }
        _btOne.frame = CGRectMake(795, 40, popImage.size.width/2.0, popImage.size.height/2.0);
        [_btOne setImage:popImage forState:UIControlStateNormal];
        [_btOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btOne addTarget:self action:@selector(loginOutBack:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_btOne];
        
        UILabel* titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake(55, 18, 40, 30);
        titleLabel.text = @"注销";
        titleLabel.font = [UIFont systemFontOfSize:20];
        [_btOne addSubview:titleLabel];
        
        
    }else {
        _hasShow = NO;
        self.btOne.hidden = YES;
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (self.hasRoulation ==NO) {
            
            self.hasRoulation = YES;
            
            self.systemButton.imageView.transform = CGAffineTransformRotate(self.systemButton.imageView.transform, DEGREES_TO_RADIANS(180));
            
        }else {
            self.hasRoulation = YES;
            
            self.systemButton.imageView.transform = CGAffineTransformRotate(self.systemButton.imageView.transform, DEGREES_TO_RADIANS(180));
            
        }
    }];
    
}
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return YES;
}
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [UIView animateWithDuration:0.3 animations:^{
        
        if (self.hasRoulation ==YES) {
            
            self.systemButton.imageView.transform = CGAffineTransformRotate(self.systemButton.imageView.transform, DEGREES_TO_RADIANS(180));
        }
    }];
    
}
- (void)didLoginOut
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定退出当前系统吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertView show];
}
- (void)logout
{
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"退出登录中..." width:1];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, LOGOUT_URL];
    RRToken* token = [RRToken getInstance];
    RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    NSString* ken = [token getProperty:@"tokensn"];
    [req setParam:ken forKey:@"token"];
    [req setHTTPMethod:@"POST"];
    
    RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
    [loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLogOut:)];
    [loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
    [loader loadwithTimer];
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
       // [SVProgressHUD dismissWithError:[[json objectForKey:@"data"] objectForKey:@"msg"]];
        
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:[[json objectForKey:@"data"] objectForKey:@"msg"] duration:2 position:@"center"];

        return;
    }
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    AppDelegate *d = [AppDelegate getInstance];
    [d showLoginView];
    [DejalBezelActivityView removeViewAnimated:YES];

}

- (void) onLoadFail: (NSNotification *)notify
{
    [DejalBezelActivityView removeViewAnimated:YES];
    [self.view makeToast:@"网络错误!" duration:1 position:@"center"];
    RRLoader *loader = (RRLoader *)[notify object];
    [loader removeNotificationListener:RRLOADER_COMPLETE target:self];
    [loader removeNotificationListener:RRLOADER_FAIL target:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==0) {
        
        [self logout];
    }else {
        
        self.btOne.hidden = YES;
        self.hasShow = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.systemButton.imageView.transform = CGAffineTransformRotate(self.systemButton.imageView.transform, DEGREES_TO_RADIANS(180));
        }];
        
        
    }
    [self.popViewController dismissPopoverAnimated:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.systemButton.imageView.transform = CGAffineTransformRotate(self.systemButton.imageView.transform, DEGREES_TO_RADIANS(180));
    }];
}
- (void)clickleftButtonMethod:(UIButton*)bt
{
    
    NSInteger index = self.coustomPageControl.currentPage;
    CGRect rect= CGRectMake(1024*index, 0, 1024, 768);
    [self.mainScrollView scrollRectToVisible:rect animated:YES];
    
}
- (void)clickrightButtonMethod:(UIButton*)bt
{
    
    NSInteger index = self.coustomPageControl.currentPage;
    index++;
    if (index ==5) {
        index = 0;
    }
    CGRect rect= CGRectMake(1024*(index+1), 0, 1024, 768);
    [self.mainScrollView scrollRectToVisible:rect animated:YES];
    //进入主视图。
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = self.mainScrollView.frame.size.width;
    int page = floor((self.mainScrollView.contentOffset.x - pagewidth/([self.addViewsArray count]+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    self.coustomPageControl.currentPage = page;
    [_coustomPageControl setOnColor: [UIColor colorWithCGColor:
                                      UIColorFromRGB(255.0, 255.0, 255.0).CGColor]];
    [_coustomPageControl setOffColor:  [UIColor colorWithCGColor:
                                        [UIColor whiteColor].CGColor]];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.mainScrollView.frame.size.width;
    int currentPage = floor((self.mainScrollView.contentOffset.x - pagewidth/ ([self.addViewsArray count]+2)) / pagewidth) + 1;
    if (currentPage==0)
    {
        [self.mainScrollView scrollRectToVisible:CGRectMake(1024 * [self.addViewsArray count],0,1024,768) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([self.addViewsArray count]+1))
    {
        [self.mainScrollView scrollRectToVisible:CGRectMake(1024,0,1024,768) animated:NO]; // 最后+1,循环第1页
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

