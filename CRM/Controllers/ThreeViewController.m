//
//  ThreeViewController.m
//  CRM
//
//  Created by 马峰 on 14-11-27.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "ThreeViewController.h"
#import "RMDisplayLabel.h"
#import "RMDownloadIndicatorTwo.h"
#import "PNLineChartView.h"
#import "PNPlot.h"
#import "RRLoader.h"
#import "RRToken.h"
#import "RRURLRequest.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "DejalActivityView.h"

#import "Toast+UIView.h"


@interface ThreeViewController ()
@property (weak, nonatomic) RMDownloadIndicatorTwo *closedIndicator;
@property (weak, nonatomic) RMDownloadIndicatorTwo *filledIndicator;
@property (weak, nonatomic) RMDownloadIndicatorTwo *mixedIndicator;

@property (weak, nonatomic) RMDownloadIndicatorTwo *closedIndicatorTwo;
@property (weak, nonatomic) RMDownloadIndicatorTwo *filledIndicatorTwo;
@property (weak, nonatomic) RMDownloadIndicatorTwo *mixedIndicatorTwo;

@property(nonatomic,strong) PNLineChartView* lineChartView;

@property (assign, nonatomic)CGFloat downloadedBytes;

@property(nonatomic,strong) NSDictionary*  royaltyDic;//绩效提成
@property(nonatomic,strong) NSDictionary*  addCustomerDic;//新增客户
@property(nonatomic,strong) NSDictionary*  transferDic;//接送机数
@property(nonatomic,strong) NSDictionary*  maintenanceDic;//维护客户数
@property(nonatomic,strong) NSDictionary*  achievementDic;//销售业绩
@property(nonatomic,strong) NSDictionary* chatDic;
@property(nonatomic,strong) NSMutableArray* addCoustomArray;//新增客户点
@property(nonatomic,strong) NSMutableArray* transferArray;//接送机数点
@property(nonatomic,strong) NSMutableArray* maintenanceArray;//维护客户数点



@property(nonatomic,strong)   UILabel* firstmoneyLabel;
@property(nonatomic,strong)   UILabel* firstpercentLabel;
@property(nonatomic,strong)   UILabel* countLabel;
@property(nonatomic,strong)   UILabel* detailLabelOne;
@property(nonatomic,strong)   UILabel* detailLabelTwo;
@property(nonatomic,strong)   UILabel* yuanLabel;
@property(nonatomic,strong)   UILabel* titleLabel;

@end

@implementation ThreeViewController

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
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.frame = CGRectMake(370, 80,182, 40);
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = @"亲, 你本日绩效提成为";
    _titleLabel.font = [UIFont systemFontOfSize:19.0];
    [self.view addSubview:_titleLabel];
    
    self.countLabel = [[UILabel alloc]init];
    _countLabel.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame), 80,35, 40);
    _countLabel.textColor = [UIColor colorWithRed:255/255.0 green:174.0/255 blue:0 alpha:1.0];
    self.countLabel.text = @"100";
    _countLabel.font = [UIFont systemFontOfSize:19.0];
    [self.view addSubview:_countLabel];
    
    self.yuanLabel = [[UILabel alloc]init];
    _yuanLabel.frame = CGRectMake(CGRectGetMaxX(_countLabel.frame),80,20, 40);
    _yuanLabel.textColor = [UIColor whiteColor];
    _yuanLabel.text = @"元";
    _yuanLabel.font = [UIFont systemFontOfSize:19.0];
    [self.view addSubview:_yuanLabel];
    
    self.detailLabelOne = [[UILabel alloc]init];
    _detailLabelOne.frame = CGRectMake(130,CGRectGetMaxY(_yuanLabel.frame),1024-150*2, 30);
    _detailLabelOne.textColor = [UIColor whiteColor];
   _detailLabelOne.numberOfLines = 0;
    _detailLabelOne.lineBreakMode = NSLineBreakByTruncatingTail;
    _detailLabelOne.textAlignment = NSTextAlignmentCenter;
    _detailLabelOne.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:_detailLabelOne];
    
   self.detailLabelTwo = [[UILabel alloc]init];
    _detailLabelTwo.frame = CGRectMake(140,CGRectGetMaxY(_detailLabelOne.frame),1024-150*2, 30);
    _detailLabelTwo.textColor = [UIColor whiteColor];
   _detailLabelTwo.numberOfLines = 0;
    _detailLabelTwo.lineBreakMode = NSLineBreakByTruncatingTail;
    _detailLabelTwo.textAlignment = NSTextAlignmentCenter;
    _detailLabelTwo.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:_detailLabelTwo];
    
    
   // [self startAnimationOne];

    
    UIView* radiousOne = [[UIView alloc]init];
    radiousOne.frame = CGRectMake(640.0, 230+124+55, 7, 7);
    radiousOne.backgroundColor = UIColorFromRGB(243, 183, 51);
    radiousOne.layer.cornerRadius = 3.5;
    radiousOne.layer.masksToBounds = YES;
    radiousOne.clipsToBounds = NO;
    [self.view addSubview:radiousOne];
    
    UILabel* coustomLabel = [[UILabel alloc]init];
    coustomLabel.frame = CGRectMake(651,230+124+45,80, 30);
    coustomLabel.textColor = [UIColor whiteColor];
    coustomLabel.text = @"新增客户数";
    coustomLabel.font = [UIFont systemFontOfSize:13.0];
    [self.view addSubview:coustomLabel];
    
    
    UIView* radiousTwo = [[UIView alloc]init];
    radiousTwo.frame = CGRectMake(741, 230+124+55, 7, 7);
    radiousTwo.backgroundColor = UIColorFromRGB(13, 171, 230);
    radiousTwo.layer.cornerRadius = 3.5;
    radiousTwo.layer.masksToBounds = YES;
    radiousTwo.clipsToBounds = NO;
    [self.view addSubview:radiousTwo];
    
    UILabel* jiesongcountLabel = [[UILabel alloc]init];
    jiesongcountLabel.frame = CGRectMake(752,230+124+45,80, 30);
    jiesongcountLabel.textColor = [UIColor whiteColor];
    jiesongcountLabel.text = @"接送机数";
    jiesongcountLabel.font = [UIFont systemFontOfSize:13.0];
    [self.view addSubview:jiesongcountLabel];
    

    UIView* radiousThree = [[UIView alloc]init];
    radiousThree.frame = CGRectMake(752+80+5, 230+124+55, 7, 7);
    radiousThree.backgroundColor = UIColorFromRGB(18, 203, 67);
    radiousThree.layer.cornerRadius = 3.5;
    radiousThree.layer.masksToBounds = YES;
    radiousThree.clipsToBounds = NO;
    [self.view addSubview:radiousThree];
    
    UILabel* weihucountLabel = [[UILabel alloc]init];
    weihucountLabel.frame = CGRectMake(752+98,230+124+45,80, 30);
    weihucountLabel.textColor = [UIColor whiteColor];
    weihucountLabel.text = @"维护客户数";
    weihucountLabel.font = [UIFont systemFontOfSize:13.0];
    [self.view addSubview:weihucountLabel];
    
    //请求网络数据
    [self loadData];
    
}
- (void)loadData
{
    //[SVProgressHUD showWithStatus:@"获取数据中"];
    
    [DejalBezelActivityView activityViewForView:self.view];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, HomePlandata_URL];
    RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:@"performance" forKey:@"type"];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setHTTPMethod:@"POST"];
    RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoaded:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
}
- (void) onLoaded: (NSNotification *)notify
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
    
    NSDictionary *Dic = [data objectForKey:@"data"];
    if ([Dic count] == 0) {
       // [SVProgressHUD dismissWithError:@"暂无数据!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"暂无数据!" duration:2 position:@"center"];
        return;
    }
    [SVProgressHUD dismiss];
    self.achievementDic = [Dic objectForKey:@"achievements"];
    self.maintenanceDic= [Dic objectForKey:@"maintenance"];
    self.addCustomerDic = [Dic objectForKey:@"newCustomer"];
    self.royaltyDic = [Dic objectForKey:@"royalty"];
    self.transferDic = [Dic objectForKey:@"transfer"];
    self.chatDic = [Dic objectForKey:@"charts"];
    self.addCoustomArray = [NSMutableArray arrayWithArray:[self.chatDic objectForKey:@"newCustomer"]];
    self.transferArray = [NSMutableArray arrayWithArray:[self.chatDic objectForKey:@"transfer"]];
    self.maintenanceArray = [NSMutableArray arrayWithArray:[self.chatDic objectForKey:@"maintenance"]];
 

    //更新数据
    [self updateFirstCycle];
    [self startAnimationTwo];
    
    //添加折线图
    [self addLineChartView];
    [DejalBezelActivityView removeViewAnimated:YES];
    
}
- (void)updateFirstCycle
{
   
    NSString* priceString = [NSString stringWithFormat:@"%@",[self.royaltyDic objectForKey:@"value"]];
    CGSize size = [priceString sizeWithFont:[UIFont systemFontOfSize:19.0] constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
    self.countLabel.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame), 80,size.width, 40);
    self.countLabel.text = [NSString stringWithFormat:@"%@", [self.royaltyDic objectForKey:@"value"]];
    _yuanLabel.frame = CGRectMake(CGRectGetMaxX(_countLabel.frame),80,20, 40);
    //新增客户数,接送机数,维护客户数
    int newAddcustomCount,transerCount,maintenceCount;
    int mubiaoAddcustomCount,mubiaotranserCount,mubiaomaintenceCount;
    newAddcustomCount = [[self.addCustomerDic objectForKey:@"value"] integerValue];
    mubiaoAddcustomCount = [[self.addCustomerDic objectForKey:@"goal"] integerValue];

    transerCount =[[self.transferDic objectForKey:@"value"] integerValue];
    mubiaotranserCount =[[self.transferDic objectForKey:@"goal"] integerValue];
    maintenceCount = [[self.maintenanceDic objectForKey:@"value"] integerValue];
    mubiaomaintenceCount = [[self.maintenanceDic objectForKey:@"goal"] integerValue];
   _detailLabelOne.text = [NSString stringWithFormat:@"新增客户数%d个,离目标还差%d个;接送机数%d个,离目标数还差%d个;维护客户数%d个,离目标还差%d个;销",newAddcustomCount,mubiaoAddcustomCount-newAddcustomCount,transerCount,mubiaotranserCount-transerCount,maintenceCount,mubiaomaintenceCount-maintenceCount];
    int achiveCount = [[self.achievementDic objectForKey:@"value"] integerValue];
    int mubiaoCount =  [[self.achievementDic objectForKey:@"goal"] integerValue];
    _detailLabelTwo.text = [NSString stringWithFormat:@"售业绩%d元,离目标还差%d元。加油哦,再努力一点你就完成啦!",achiveCount,mubiaoCount-achiveCount];
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
- (void)addLineChartView
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
    
    NSUInteger numberOfDaysInMonth = range.length;
    NSMutableArray* dayArray = [NSMutableArray array];
    for (int i = 1; i <=numberOfDaysInMonth; i++) {
        
        [dayArray addObject:[[NSNumber numberWithInteger:i] stringValue]];
    }
    self.lineChartView = [[PNLineChartView alloc]init];
    self.lineChartView.frame = CGRectMake(10.0,230+124+45+44 , 1024-70*2, 240);
    self.lineChartView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.lineChartView];
    self.lineChartView.max = 300;
    self.lineChartView.min = 0;
    
    
    self.lineChartView.interval = (self.lineChartView.max-self.lineChartView.min)/6;
    
    NSMutableArray* yAxisValues = [@[] mutableCopy];
    for (int i=0; i<7; i++) {
        
        NSString* str = [NSString stringWithFormat:@"%.2f", self.lineChartView.min+self.lineChartView.interval*i];
        [yAxisValues addObject:str];
    }
    
    self.lineChartView.xAxisValues =dayArray;
    self.lineChartView.yAxisValues = yAxisValues;
    self.lineChartView.axisLeftLineWidth = 39;
    
    
    PNPlot *plot1 = [[PNPlot alloc] init];
    plot1.plottingValues = self.addCoustomArray;
    
    plot1.lineColor = [UIColor colorWithRed:18.0/255 green:203.0/255 blue:67.0/255 alpha:1.0];
    plot1.lineWidth = 1.0;
    
    [self.lineChartView addPlot:plot1];
    
    
    PNPlot *plot2 = [[PNPlot alloc] init];
    plot2.plottingValues = self.transferArray;
    plot2.lineColor = [UIColor colorWithRed:13.0/255 green:171.0/255 blue:230.0/255 alpha:1.0];
    plot2.lineWidth = 1;
    [self.lineChartView  addPlot:plot2];
    
    PNPlot *plot3 = [[PNPlot alloc] init];
    plot3.plottingValues = self.maintenanceArray;
    plot3.lineColor = [UIColor colorWithRed:243.0/255 green:183.0/255 blue:51.0/255 alpha:1.0];
    plot3.lineWidth = 1;
    [self.lineChartView  addPlot:plot3];
    
    
    UILabel* label = [[UILabel alloc]init];
    label.frame = CGRectMake(10, -10, 40,30);
    label.textColor = [UIColor whiteColor];
    label.text = @"数量";
    label.font = [UIFont systemFontOfSize:13];
    [self.lineChartView addSubview:label];
    
    
    UILabel* timelabel = [[UILabel alloc]init];
    timelabel.frame = CGRectMake(852, 205, 40,30);
    timelabel.textColor = [UIColor whiteColor];
    timelabel.text = @"日期";
    timelabel.font = [UIFont systemFontOfSize:13];
    [self.lineChartView addSubview:timelabel];
}
- (void)downLoadIndicator
{
    [_closedIndicatorTwo removeFromSuperview];
    _closedIndicatorTwo = nil;
    [_filledIndicatorTwo removeFromSuperview];
    _filledIndicatorTwo = nil;
    [_mixedIndicatorTwo removeFromSuperview];
    _mixedIndicatorTwo = nil;
    
    
    for (int i = 0; i < 5; i++) {
        
        RMDownloadIndicatorTwo *closedIndicatorTwo = [[RMDownloadIndicatorTwo alloc]initWithFrame:CGRectMake(15+124*i+68.0*i, 230, 124, 124) type:kRMClosedIndicator];
        [closedIndicatorTwo setBackgroundColor:[UIColor clearColor]];
        [closedIndicatorTwo setFillColor:[UIColor whiteColor]];
        [closedIndicatorTwo setStrokeColor:[UIColor whiteColor]];
        closedIndicatorTwo.radiusPercent = 0.45;
        [self.view addSubview:closedIndicatorTwo];
        [closedIndicatorTwo loadIndicator];
   
        UILabel* jixiaoLabel = [[UILabel alloc]init];
        jixiaoLabel.frame = CGRectMake(30, 35,70, 20);
        jixiaoLabel.font = [UIFont systemFontOfSize:14];
        jixiaoLabel.textColor = [UIColor whiteColor];
        [closedIndicatorTwo addSubview:jixiaoLabel];
        
        
        UILabel* moneyLabel = [[UILabel alloc]init];
        moneyLabel.frame = CGRectMake(CGRectGetMinX(jixiaoLabel.frame)+5+3, CGRectGetMaxY(jixiaoLabel.frame),70, 30);
        moneyLabel.font = [UIFont systemFontOfSize:16];
        moneyLabel.textColor =[UIColor whiteColor];
        [closedIndicatorTwo addSubview:moneyLabel];
        
        UILabel* percentLabel = [[UILabel alloc]init];
        percentLabel.frame = CGRectMake(CGRectGetMinX(jixiaoLabel.frame)+3, CGRectGetMaxY(moneyLabel.frame)-5,70, 30);
        percentLabel.font = [UIFont systemFontOfSize:13];
        percentLabel.textColor =[UIColor whiteColor];
        [closedIndicatorTwo addSubview:percentLabel];
  
        if (i==0) {
            
            jixiaoLabel.text = @"绩效提成";
            moneyLabel.frame = CGRectMake(CGRectGetMinX(jixiaoLabel.frame)+5+1, CGRectGetMaxY(jixiaoLabel.frame),70, 30);
            
            
            
           moneyLabel.text = [NSString stringWithFormat:@"%@元", [self.royaltyDic objectForKey:@"value"]];
            float percentOne = [[self.royaltyDic objectForKey:@"percentage"] floatValue];
            float percent = [[self.royaltyDic objectForKey:@"percentage"] floatValue]*100;
            percentLabel.text = [NSString stringWithFormat:@"占比%@%%",[[NSNumber numberWithFloat:percent] stringValue]];
           [closedIndicatorTwo updateWithTotalBytes:1.0 downloadedBytes:percentOne];
            
            
        
        }else if (i==1){
        
            float percent = [[self.addCustomerDic objectForKey:@"percentage"] floatValue];
            float percentOne = percent*100;
            jixiaoLabel.text = @"新增客户数";
            [closedIndicatorTwo updateWithTotalBytes:1.0 downloadedBytes:percent];
 
            if ([[self.addCustomerDic objectForKey:@"value"] length]==0) {
                
              moneyLabel.text = [NSString stringWithFormat:@"%@个", @"0"];
                
                    moneyLabel.frame = CGRectMake(CGRectGetMinX(jixiaoLabel.frame)+5+12, CGRectGetMaxY(jixiaoLabel.frame),70, 30);
                
            }else {
            
            moneyLabel.text = [NSString stringWithFormat:@"%@个", [self.addCustomerDic objectForKey:@"value"]];
            }
            
           
            percentLabel.text = [NSString stringWithFormat:@"占比%@%%",[[NSNumber numberWithFloat:percentOne] stringValue]];
            
          


        }else if (i==2){
          
            float percent = [[self.transferDic objectForKey:@"percentage"] floatValue];
            float percentOne = percent*100;
            jixiaoLabel.text = @"接送机数";
            [closedIndicatorTwo updateWithTotalBytes:1.0 downloadedBytes:percent];
           
            if ([[self.transferDic objectForKey:@"value"] length]==0) {
                
                moneyLabel.text = [NSString stringWithFormat:@"%@个", @"0"];
              moneyLabel.frame = CGRectMake(CGRectGetMinX(jixiaoLabel.frame)+5+12, CGRectGetMaxY(jixiaoLabel.frame),70, 30);
            }else {
             moneyLabel.text = [NSString stringWithFormat:@"%@个", [self.transferDic objectForKey:@"value"]];
            }
            percentLabel.text = [NSString stringWithFormat:@"占比%@%%",[[NSNumber numberWithFloat:percentOne] stringValue]];
            
           
            
          }else if (i==3){
         
              float percent = [[self.maintenanceDic objectForKey:@"percentage"] floatValue];
              float percentOne = percent*100;
              jixiaoLabel.text = @"维护客户数";
              [closedIndicatorTwo updateWithTotalBytes:1.0 downloadedBytes:percent];
           
              
              if ([[self.maintenanceDic objectForKey:@"value"] length]==0) {
                  
                  moneyLabel.text = [NSString stringWithFormat:@"%@个", @"0"];
                   moneyLabel.frame = CGRectMake(CGRectGetMinX(jixiaoLabel.frame)+5+12, CGRectGetMaxY(jixiaoLabel.frame),70, 30);
                  
              }else {
               moneyLabel.text = [NSString stringWithFormat:@"%@个", [self.maintenanceDic objectForKey:@"value"]];
              }
              
              percentLabel.text = [NSString stringWithFormat:@"占比%@%%",[[NSNumber numberWithFloat:percentOne] stringValue]];
            
          }else if (i==4){
              
              
              float percent = [[self.achievementDic objectForKey:@"percentage"] floatValue];
              float percentOne = percent*100;
              jixiaoLabel.text = @"销售业绩";
              [closedIndicatorTwo updateWithTotalBytes:1.0 downloadedBytes:percent];
               moneyLabel.frame = CGRectMake(CGRectGetMinX(jixiaoLabel.frame)+5+12, CGRectGetMaxY(jixiaoLabel.frame),70, 30);
              if ([[self.achievementDic objectForKey:@"value"] length]==0) {
                  
                  moneyLabel.text = [NSString stringWithFormat:@"%@元", @"0"];
                  
              }else {
                   moneyLabel.text = [NSString stringWithFormat:@"%@元", [self.achievementDic objectForKey:@"value"]];
              }
              percentLabel.text = [NSString stringWithFormat:@"占比%@%%",[[NSNumber numberWithFloat:percentOne] stringValue]];
              
        }
    }
}
- (void)startAnimationTwo
{
    [self downLoadIndicator];
    
       self.downloadedBytes = 0;
    typeof(self) __weak weakself = self;
    double delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakself updateView:10.0f];
    });
    
    double delayInSeconds1 = delayInSeconds + 1;
    dispatch_time_t popTime1 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds1 * NSEC_PER_SEC));
    dispatch_after(popTime1, dispatch_get_main_queue(), ^(void){
        [weakself updateView:30.0f];
    });
    
    double delayInSeconds2 = delayInSeconds1 + 1;
    dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds2 * NSEC_PER_SEC));
    dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
        [weakself updateView:10.0f];
    });
    
    double delayInSeconds3 = delayInSeconds2 + 1;
    dispatch_time_t popTime3 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds3 * NSEC_PER_SEC));
    dispatch_after(popTime3, dispatch_get_main_queue(), ^(void){
        [weakself updateView:50.0f];
    });}

#pragma mark - Update Views
- (void)startAnimationOne
{
    [_closedIndicator removeFromSuperview];
    _closedIndicator = nil;
    [_filledIndicator removeFromSuperview];
    _filledIndicator = nil;
    [_mixedIndicator removeFromSuperview];
    _mixedIndicator = nil;
    
    
    RMDownloadIndicatorTwo *closedIndicator = [[RMDownloadIndicatorTwo alloc]initWithFrame:CGRectMake(15, 224,142, 142) type:kRMFilledIndicator];
    [closedIndicator setBackgroundColor:[UIColor clearColor]];
    [closedIndicator setFillColor:[UIColor whiteColor]];
    [closedIndicator setStrokeColor:[UIColor whiteColor]];
    closedIndicator.radiusPercent = 0.45;
    [self.view addSubview:closedIndicator];
    [closedIndicator loadIndicator];
    _closedIndicator = closedIndicator;
    
    UILabel* jixiaoLabel = [[UILabel alloc]init];
    jixiaoLabel.frame = CGRectMake(34, 42,70, 20);
    jixiaoLabel.font = [UIFont systemFontOfSize:16];
    jixiaoLabel.text = @"绩效提成";
    jixiaoLabel.textColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    [closedIndicator addSubview:jixiaoLabel];
    
    
    self.firstmoneyLabel = [[UILabel alloc]init];
    _firstmoneyLabel.frame = CGRectMake(CGRectGetMinX(jixiaoLabel.frame)+5, CGRectGetMaxY(jixiaoLabel.frame),70, 30);
    _firstmoneyLabel.font = [UIFont systemFontOfSize:16];
    _firstmoneyLabel.textColor =[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    [closedIndicator addSubview:_firstmoneyLabel];
    
    self.firstpercentLabel = [[UILabel alloc]init];
    _firstpercentLabel.frame = CGRectMake(CGRectGetMinX(jixiaoLabel.frame)+3, CGRectGetMaxY(_firstmoneyLabel.frame)-5,70, 30);
    _firstpercentLabel.font = [UIFont systemFontOfSize:13];
    _firstpercentLabel.textColor =[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    [closedIndicator addSubview:_firstpercentLabel];
    [self updateViewOneTime];
    self.downloadedBytes = 0;
    typeof(self) __weak weakself = self;
    double delayInSeconds = 0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakself updateView:10.0f];
    });
    
    double delayInSeconds1 = delayInSeconds + 1;
    dispatch_time_t popTime1 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds1 * NSEC_PER_SEC));
    dispatch_after(popTime1, dispatch_get_main_queue(), ^(void){
        [weakself updateView:30.0f];
    });
    
    double delayInSeconds2 = delayInSeconds1 + 1;
    dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds2 * NSEC_PER_SEC));
    dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
        [weakself updateView:10.0f];
    });
    
    double delayInSeconds3 = delayInSeconds2 + 1;
    dispatch_time_t popTime3 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds3 * NSEC_PER_SEC));
    dispatch_after(popTime3, dispatch_get_main_queue(), ^(void){
        [weakself updateView:50.0f];

    });
}

- (void)updateView:(CGFloat)val
{
    self.downloadedBytes+=val;
    [_closedIndicator updateWithTotalBytes:75 downloadedBytes:self.downloadedBytes];
    [_filledIndicator updateWithTotalBytes:75 downloadedBytes:self.downloadedBytes];
    [_mixedIndicator updateWithTotalBytes:75 downloadedBytes:self.downloadedBytes];
}

- (void)updateViewOneTime
{
    [_closedIndicator setIndicatorAnimationDuration:1.0];
    [_filledIndicator setIndicatorAnimationDuration:1.0];
    [_mixedIndicator setIndicatorAnimationDuration:1.0];
    
    [_closedIndicator updateWithTotalBytes:100 downloadedBytes:100];
    [_filledIndicator updateWithTotalBytes:100 downloadedBytes:self.downloadedBytes];
    [_mixedIndicator updateWithTotalBytes:100 downloadedBytes:self.downloadedBytes];
}

@end
