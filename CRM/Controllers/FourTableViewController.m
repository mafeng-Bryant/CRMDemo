//
//  FourTableViewController.m
//  CRM
//
//  Created by 马峰 on 14-11-27.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "FourTableViewController.h"
#import "FourTableViewCell.h"
#import "RRLoader.h"
#import "RRToken.h"
#import "RRURLRequest.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "DejalActivityView.h"

#import "Toast+UIView.h"


@interface FourTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UISegmentedControl *segmentedControl;
@property(nonatomic,strong) UITableView* mainTableView;
@property(nonatomic,strong) NSMutableArray* dataArray;
@property(nonatomic,strong) NSArray* titleArray;
@property(nonatomic,strong) UILabel* upLineLabel;
@property(nonatomic,strong) UILabel* downLineLabel;
@property(nonatomic,strong) NSString* typeString;
@property(nonatomic,strong) NSString* rankCount;
@property(nonatomic,strong)  UILabel* countLabel;
@property(nonatomic,strong)  UILabel* titleLabel;
@property(nonatomic,strong)   UILabel* mingLabel;



@end

@implementation FourTableViewController

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
  
    self.titleArray = @[@"排名",@"姓名",@"新增客户数",@"接送机数",@"维护客户数",@"销售业绩",@"绩效评分"];
    self.dataArray = [NSMutableArray array];
//    CGRect rect =self.view.frame;
//    rect.origin.x = 0;
//    rect.origin.y = 0;
//    rect.size.width = 1024;
//    rect.size.height = 768;
//    self.view.frame = rect;
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.frame = CGRectMake(380, 80,165, 40);
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:19.0];
    [self.view addSubview:_titleLabel];
    
    _countLabel = [[UILabel alloc]init];
    _countLabel.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame), 80,10, 40);
    _countLabel.textColor = [UIColor colorWithRed:255/255.0 green:174.0/255 blue:0 alpha:1.0];
    _countLabel.font = [UIFont systemFontOfSize:19.0];
    [self.view addSubview:_countLabel];
    
    self.mingLabel = [[UILabel alloc]init];
    _mingLabel.frame = CGRectMake(CGRectGetMaxX(_countLabel.frame),80,20, 40);
    _mingLabel.textColor = [UIColor whiteColor];
    _mingLabel.font = [UIFont systemFontOfSize:19.0];
    [self.view addSubview:_mingLabel];
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"按月份排名", @"按年份排名"]];
    _segmentedControl.frame = CGRectMake(1024-300-60, 80+30, 240, 40);
    _segmentedControl.tintColor = [UIColor whiteColor];
    [_segmentedControl setWidth:120.0 forSegmentAtIndex:0];
    [_segmentedControl setWidth:120.0 forSegmentAtIndex:1];
    [_segmentedControl setSelectedSegmentIndex:0];
    [_segmentedControl addTarget:self
                         action:@selector(segmentedControlChanged:)
               forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80+40+27+22, 1024-60*2, self.view.frame.size.height) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    self.mainTableView.separatorColor = [UIColor clearColor];
    [_mainTableView setShowsHorizontalScrollIndicator:NO];
    [_mainTableView setShowsVerticalScrollIndicator:NO];
    _mainTableView.scrollEnabled = NO;
    self.mainTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainTableView];
     //默认查询月份
    self.typeString = @"month";
    
    [self loadData];
}
- (void)loadData
{
    //[SVProgressHUD showWithStatus:@"获取数据中"];
    [DejalBezelActivityView activityViewForView:self.backView];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, HomePlandata_URL];
    RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:@"rank" forKey:@"type"];
    [req setParam:self.typeString forKey:@"order"];
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
        //[SVProgressHUD dismissWithError:@"获取数据失败!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"获取数据失败!" duration:1 position:@"center"];

		return;
	}
    
    NSDictionary *Dic = [data objectForKey:@"data"];
    if ([Dic count] == 0) {
//        [SVProgressHUD dismissWithError:@"暂无数据!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"暂无数据!" duration:1 position:@"center"];
        return;
    }
    [SVProgressHUD dismiss];
    NSArray* rankArray = [Dic objectForKey:@"ranks"];
    if (rankArray.count==0) {
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"暂无数据!" duration:1 position:@"center"];
        return;
    }
    NSArray* itemArray = [Dic objectForKey:@"ranks"];
    for (int i = 0; i < itemArray.count; i++) {
       
        NSDictionary* Dic = itemArray[i];
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
               [dic setObject:[Dic objectForKey:@"name"] forKey:@"name"];
               [dic setObject:[Dic objectForKey:@"newCus"] forKey:@"addcoustom"];
               [dic setObject:[Dic objectForKey:@"transfer"] forKey:@"jiesong"];
               [dic setObject:[Dic objectForKey:@"maintenance"] forKey:@"weihu"];
               [dic setObject:[Dic objectForKey:@"achievements"] forKey:@"xiaoshou"];
               [dic setObject:[Dic objectForKey:@"score"] forKey:@"score"];
               [dic setObject:[Dic objectForKey:@"no"] forKey:@"no"];
               [self.dataArray addObject:dic];
    }
    
     int count = [[Dic objectForKey:@"youRanking"] integerValue];
     self.rankCount = [[NSNumber numberWithInt:count] stringValue];
     [self updateRanking];
     NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"no"
                                                                   ascending:YES];//其中，price为数组中的对象的属性，这个针对数组中存放对象比较更简洁方便
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    [self.dataArray sortUsingDescriptors:sortDescriptors];
     [self.mainTableView reloadData];
    [DejalBezelActivityView removeViewAnimated:YES];
    
}
- (void)updateRanking
{
    if ([self.typeString isEqualToString:@"month"]) {
    
        _titleLabel.text = @"亲, 你本月的排名为";
        _countLabel.text = self.rankCount;
        _mingLabel.text = @"名";

        
    }else if ([self.typeString isEqualToString:@"year"]){
    
        _titleLabel.text = @"亲, 你本年的排名为";
        _countLabel.text = self.rankCount;
        _mingLabel.text = @"名";

    }
}
- (void) onLoadFail: (NSNotification *)notify
{
   // [SVProgressHUD dismissWithError:@"网络错误!" afterDelay:1.5f];
    [DejalBezelActivityView removeViewAnimated:YES];
    [self.view makeToast:@"网络错误!" duration:1 position:@"center"];
	RRLoader *loader = (RRLoader *)[notify object];
	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    FourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[FourTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier: SimpleTableIdentifier];
    }
    cell.userInteractionEnabled = NO;
    if (indexPath.row ==0) {
        
        if (self.upLineLabel==nil) {
        self.upLineLabel = [[UILabel alloc]init];
        self.upLineLabel.frame = CGRectMake(0, 10, 1024-60*2, 1);

        }
        self.upLineLabel.backgroundColor = [UIColor whiteColor];
        self.upLineLabel.alpha = 0.5;
        [cell.contentView addSubview:self.upLineLabel];
        
        UILabel* titleLabel;
        CGFloat X = 0.0;
        for (int i = 0; i <self.titleArray.count; i++) {
            
            NSString* titleString = self.titleArray[i];
            CGSize size = [titleString sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
            titleLabel = [[UILabel alloc]init];
            titleLabel.frame = CGRectMake(5+X, 17,size.width+10, 20);
            titleLabel.text = titleString;
            titleLabel.textColor = [UIColor whiteColor];
            [cell.contentView addSubview:titleLabel];
            X+=80.0+size.width;
        }

        if (self.downLineLabel==nil) {
            self.downLineLabel = [[UILabel alloc]init];
            self.downLineLabel.frame =CGRectMake(0, cell.frame.size.height-1, 1024-60*2, 1);

        }
        self.downLineLabel.backgroundColor = [UIColor whiteColor];
        self.downLineLabel.alpha = 0.5;
        [cell.contentView addSubview:self.downLineLabel];
    }
    
     if (indexPath.row !=0) {
         if (self.dataArray.count > 0) {
             
        [cell setcellInfomation:self.dataArray indexPath:indexPath];
     
         }
         
    }
     cell.backgroundColor = [UIColor clearColor];
     return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count+1;
}


#pragma mark - TableView Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0) {
        
        return 36.0;
    }
    
    return 44;
}

-(void)segmentedControlChanged:(UISegmentedControl*)segment
{
    if (segment.selectedSegmentIndex ==0) {
   
        self.typeString = @"month";
        
    }else {
        self.typeString = @"year";

    }
    [self.dataArray removeAllObjects];
    [self loadData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
