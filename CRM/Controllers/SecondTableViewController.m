//
//  SecondTableViewController.m
//  CRM
//
//  Created by 马峰 on 14-11-27.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "SecondTableViewController.h"
#import "SecondTableViewCell.h"
#import "RRLoader.h"
#import "RRToken.h"
#import "RRURLRequest.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "DejalActivityView.h"
#import "Toast+UIView.h"



@interface SecondTableViewController ()
@property(nonatomic,strong) UITableView* mainTableView;
@property(nonatomic,strong) NSArray* sectionTitlesArray;
@property(nonatomic,strong) NSMutableArray* sectionOneContentArray;
@property(nonatomic,strong) NSMutableArray* sectionTwoContentArray;
@property(nonatomic,strong) UIView* backGroundView;
@property(nonatomic,strong) NSMutableArray* dataArray;

@property(nonatomic,strong)   UILabel* lineLabelOne;
@property(nonatomic,strong)   UILabel* linLabelTwo;
@property(nonatomic,strong)   UILabel* lineLabelThree;
@property(nonatomic,strong)   UILabel* linLabelFour;




@end

@implementation SecondTableViewController

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

    self.sectionTitlesArray = @[@"科目",@"公司目标",@"个人目标",@"今日完成",@"完成率",@"公司目标绩效",@"个人目标绩效",@"实际绩效提成"];
    self.sectionOneContentArray = [NSMutableArray array];
    self.sectionTwoContentArray = [NSMutableArray array];
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, 1024-60*2, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    self.mainTableView.separatorColor = [UIColor clearColor];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.userInteractionEnabled = NO;
    [_mainTableView setShowsHorizontalScrollIndicator:NO];
    [_mainTableView setShowsVerticalScrollIndicator:NO];
    _mainTableView.scrollEnabled = NO;
    self.mainTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainTableView];
    self.dataArray = [NSMutableArray array];
    [self loadPlanData];
}
- (void)loadPlanData
{
   // [SVProgressHUD showWithStatus:@"获取数据中"];
    [DejalBezelActivityView activityViewForView:self.view];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, HomePlandata_URL];
    RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:@"plan" forKey:@"type"];
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
//        [SVProgressHUD dismissWithError:@"获取数据失败!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"获取数据失败!" duration:2 position:@"center"];
		return;
	}
    
    NSDictionary *Dic = [data objectForKey:@"data"];
    if ([Dic count] == 0) {
        //[SVProgressHUD dismissWithError:@"暂无数据!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"暂无数据!" duration:2 position:@"center"];
        return;
    }
    [SVProgressHUD dismiss];
    
    NSArray* dayArray = [Dic objectForKey:@"day"];
    NSArray* monthArray = [Dic objectForKey:@"month"];

    if ([dayArray count]==0 && monthArray.count==0) {
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"暂无数据!" duration:2 position:@"center"];
        
        return;
    }
    
     NSMutableArray* dataArray = [NSMutableArray array];
        NSArray* itemArray = [Dic objectForKey:@"day"];
            for (NSDictionary* smallDic in itemArray)
            {
                    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
                    [dic setObject:[smallDic objectForKey:@"subject"] forKey:@"subject"];
                    [dic setObject:[smallDic objectForKey:@"cGoal"] forKey:@"cGoal"];
                    [dic setObject:[smallDic objectForKey:@"pGoal"] forKey:@"pGoal"];
                    [dic setObject:[smallDic objectForKey:@"finish"] forKey:@"finish"];
                    [dic setObject:[smallDic objectForKey:@"rate"] forKey:@"rate"];
                    [dic setObject:[smallDic objectForKey:@"cPerformanceGoal"] forKey:@"cPerformanceGoal"];
                    [dic setObject:[smallDic objectForKey:@"pPerformanceGoal"] forKey:@"pPerformanceGoal"];
                    [dic setObject:[smallDic objectForKey:@"actualPerformance"] forKey:@"actualPerformance"];
                    [dataArray addObject:dic];
            }
          [self.dataArray addObject:dataArray];
          NSArray* itemArrayTwo = [Dic objectForKey:@"month"];
            for (NSDictionary* smallDic in itemArrayTwo)
            {
            NSMutableDictionary* dic = [NSMutableDictionary dictionary];
            [dic setObject:[smallDic objectForKey:@"subject"] forKey:@"subject"];
            [dic setObject:[smallDic objectForKey:@"cGoal"] forKey:@"cGoal"];
            [dic setObject:[smallDic objectForKey:@"pGoal"] forKey:@"pGoal"];
            [dic setObject:[smallDic objectForKey:@"finish"] forKey:@"finish"];
            [dic setObject:[smallDic objectForKey:@"rate"] forKey:@"rate"];
            [dic setObject:[smallDic objectForKey:@"cPerformanceGoal"] forKey:@"cPerformanceGoal"];
            [dic setObject:[smallDic objectForKey:@"pPerformanceGoal"] forKey:@"pPerformanceGoal"];
            [dic setObject:[smallDic objectForKey:@"actualPerformance"] forKey:@"actualPerformance"];
            [dataArray addObject:dic];
            
            }
            
    [self.dataArray addObject:dataArray];
    [self.mainTableView reloadData];
    [DejalBezelActivityView removeViewAnimated:YES];

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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        UILabel* mainLabel = [[UILabel alloc]init];
        mainLabel.frame = CGRectMake(0, 10,200, 40);
        mainLabel.textColor = [UIColor whiteColor];
        mainLabel.text = @"今日计划:";
        mainLabel.font = [UIFont systemFontOfSize:18.0];
        return mainLabel;
        
    }else {
        UILabel* mainLabel = [[UILabel alloc]init];
        mainLabel.frame = CGRectMake(0, 10,200, 40);
        mainLabel.textColor = [UIColor whiteColor];
        mainLabel.text = @"本月计划:";
        mainLabel.font = [UIFont systemFontOfSize:18.0];
       return mainLabel;

    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[SecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: SimpleTableIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];

    if (indexPath.section ==0 && indexPath.row ==0 ) {
    
        if (!self.lineLabelOne) {
         self.lineLabelOne = [[UILabel alloc]init];
            
        }
        _lineLabelOne.frame = CGRectMake(0, 10, 1024-60*2, 1);
        _lineLabelOne.backgroundColor = [UIColor whiteColor];
        _lineLabelOne.alpha = 0.5;
        [cell.contentView addSubview:_lineLabelOne];
         UILabel* titleLabel;
        CGFloat X = 0.0;
        
         for (int i = 0; i <self.sectionTitlesArray.count; i++) {
             
            NSString* titleString = self.sectionTitlesArray[i];
            CGSize size = [titleString sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
             titleLabel = [[UILabel alloc]init];
             titleLabel.frame = CGRectMake(5+X, 17,size.width+10, 20);
             titleLabel.text = titleString;
             titleLabel.font = [UIFont systemFontOfSize:16.0];
             titleLabel.textColor = [UIColor whiteColor];
             [cell.contentView addSubview:titleLabel];
              X+=47.0+size.width;
        }
        if (!self.linLabelTwo) {
            self.linLabelTwo = [[UILabel alloc]init];
            
        }
        self.linLabelTwo.frame = CGRectMake(0, cell.frame.size.height, 1024-60*2, 1);
         self.linLabelTwo.backgroundColor = [UIColor whiteColor];
          self.linLabelTwo.alpha = 0.5;
        [cell.contentView addSubview: self.linLabelTwo];
    }
    
    if (indexPath.row !=0) {
        
        if (self.dataArray.count > 0) {
            [cell setcellInfomation:self.dataArray[indexPath.section] indexPath:indexPath];
    
        }
    }
    if (indexPath.row!=0) {
  
      if (indexPath.row ==2){
            self.backGroundView = [[UIView alloc]init];
            self.backGroundView.backgroundColor = [UIColor blackColor];
            self.backGroundView.alpha = 0.15;
          cell.backgroundView = self.backGroundView;
      }
       if (indexPath.row ==4){
        
            self.backGroundView = [[UIView alloc]init];
            self.backGroundView.backgroundColor = [UIColor blackColor];
            self.backGroundView.alpha = 0.15;
            cell.backgroundView = self.backGroundView;

    }
    }
    if (indexPath.section ==1 && indexPath.row ==0) {
        
        UILabel* lineLabelThree = [[UILabel alloc]init];
        lineLabelThree.frame = CGRectMake(0, 10, 1024-60*2, 1);
        lineLabelThree.backgroundColor = [UIColor whiteColor];
         lineLabelThree.alpha = 0.5;
        [cell.contentView addSubview:lineLabelThree];
        
        UILabel* titleLabel;
        
        CGFloat X = 0.0;
        
        for (int i = 0; i <self.sectionTitlesArray.count; i++) {
            
            NSString* titleString = self.sectionTitlesArray[i];
            CGSize size = [titleString sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
            titleLabel = [[UILabel alloc]init];
            titleLabel.frame = CGRectMake(5+X, 17,size.width+10, 20);
            titleLabel.text = titleString;
            titleLabel.textColor = [UIColor whiteColor];
            X+=47.0+size.width;
            [cell.contentView addSubview:titleLabel];
            
        }
        if (!self.linLabelFour) {
            self.linLabelFour = [[UILabel alloc]init];
        }
        self.linLabelFour.frame = CGRectMake(0, cell.frame.size.height, 1024-60*2, 1);
        self.linLabelFour.backgroundColor = [UIColor whiteColor];
        self.linLabelFour.alpha = 0.5;
        [cell.contentView addSubview: self.linLabelFour];
        
    }
     return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        
        return @"今日计划:";
        
    }else if (section ==1){
        
        return @"本月计划:";
        
    }
    return nil;
}


#pragma mark - TableView Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row ==0) {
        return 36.0;
    }
    return 44;
}




@end
