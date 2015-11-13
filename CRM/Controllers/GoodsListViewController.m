//
//  TeaListViewController.m
//  diancha
//
//  Created by Fang on 14-7-2.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import "GoodsListViewController.h"
#import "ACPScrollMenu.h"
#import "RRToken.h"
#import "RRLoader.h"
#import "SVProgressHUD.h"
#import "Toast+UIView.h"
#import "UrlImageView.h"
#import "TeaListTitleCell.h"
#import "TeaListContentCell.h"
#import "AppDelegate.h"
#import "DejalActivityView.h"


@interface GoodsListViewController ()<ACPScrollDelegate,refreShPriceInformationDelegate>
@property(nonatomic,strong) UIView* totalCountView;
@property(nonatomic,strong) UILabel* countLabel;
@property(nonatomic,strong) UILabel* priceLabel;
@property(nonatomic,strong) UIView* headView;



@end

@implementation GoodsListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationback.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *btn_cancel;
    if (IOS7) {
        btn_cancel = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navitem_back"] style:UIBarButtonItemStyleBordered target:self action:@selector(btn_cancel_click:)];
    }
    else
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"navitem_back"] forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(0.0f, 0.0f, 35, 28)];
        [btn addTarget:self action:@selector(btn_cancel_click:) forControlEvents:UIControlEventTouchUpInside];
        btn_cancel = [[UIBarButtonItem alloc] initWithCustomView:btn];
     }

 //   self.navigationItem.leftBarButtonItem = btn_cancel;
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
    
    
    self.title = @"我的订单";
    
    NSDictionary *textAttributes = nil;
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
                           NSForegroundColorAttributeName: [UIColor whiteColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:20],
                           UITextAttributeTextColor: [UIColor whiteColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
        
    }
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];

    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    
    self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"img32"]];
    buffer = [NSMutableArray array];
    payStatus = @"UnPay";
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([buffer count] == 0) {
        return 1;
    }
    return [buffer count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([buffer count] == 0) {
        return 1;
    }

    NSDictionary *dic = [buffer objectAtIndex:section];
    NSArray *array = [dic objectForKey:@"details"];
    return [array count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([buffer count] == 0) {
        static NSString *cell_id = @"empty_cell";
        
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell_id];
        if (nil == cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        }
        
        UIFont *font = [UIFont systemFontOfSize:15.0f];
        cell.textLabel.text = @"无数据";
        cell.textLabel.font = font;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    static NSString *cell_id = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell_id];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    
    if (0 == indexPath.row) {
        NSString *CellIdentifier = @"TeaListTitleCell";
        NSDictionary *dic = [buffer objectAtIndex:indexPath.section];
        
        TeaListTitleCell *cell = (TeaListTitleCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (nil == cell)
        {
            UIViewController *uc = [[UIViewController alloc] initWithNibName:CellIdentifier bundle:nil];
            
            cell = (TeaListTitleCell *)uc.view;
            [cell setContent:dic];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        NSString *CellIdentifier = @"TeaListContentCell";
        
        NSLog(@"buffer = %@",buffer);
        
        
        NSDictionary *dic = [[[buffer objectAtIndex:indexPath.section] objectForKey:@"details"] objectAtIndex:indexPath.row-1];
        
        TeaListContentCell *cell = (TeaListContentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (nil == cell)
        {
            UIViewController *uc = [[UIViewController alloc] initWithNibName:CellIdentifier bundle:nil];
            
            cell = (TeaListContentCell *)uc.view;
            cell.priceDelegate = self;

            [cell setContent:dic];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == section)
        return 128;
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (0 == section) {
        self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 128)];
        self.headView.backgroundColor = [UIColor clearColor];
        
        
        ACPScrollMenu *scrollMenuView = [[ACPScrollMenu alloc] initWithFrame:CGRectMake(0, 0, 1024, 64)];
      //  UIImage *originalImage = [UIImage imageNamed:@"img19"];
      //  UIEdgeInsets insets = UIEdgeInsetsMake(1, 1, 1, 1);
       // UIImage *stretchableImage = [originalImage resizableImageWithCapInsets:insets];
     //   scrollMenuView.backgroundColor = [UIColor colorWithPatternImage:stretchableImage];
        
        scrollMenuView.backgroundColor = [UIColor whiteColor];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        
        //Set the items
        ACPItem *item2 = [[ACPItem alloc] initACPItem:[UIImage imageNamed:@"img19"] iconImage:nil andLabel:@"已付款"];
        
        //Set highlighted behaviour
        [item2 setHighlightedBackground:[UIImage imageNamed:@"img20"] iconHighlighted:nil textColorHighlighted:[UIColor whiteColor]];
        
        ACPItem *item1 = [[ACPItem alloc] initACPItem:[UIImage imageNamed:@"img19"] iconImage:nil andLabel:@"未付款"];
        
        //Set highlighted behaviour
        [item1 setHighlightedBackground:[UIImage imageNamed:@"img20"] iconHighlighted:nil textColorHighlighted:[UIColor whiteColor]];

        [array addObject:item1];
        [array addObject:item2];

        [scrollMenuView setUpACPScrollMenu:array];
        
        //We choose an animation when the user touch the item (you can create your own animation)
        [scrollMenuView setAnimationType:ACPZoomOut];
        
        scrollMenuView.delegate = self;
        
        if ([payStatus isEqualToString:@"Payed"]) {
            [scrollMenuView setThisItemHighlighted:1];
        }
        else {
            [scrollMenuView setThisItemHighlighted:0];
        }
        self.totalCountView = [[UIView alloc]init];
        self.totalCountView.frame = CGRectMake(0.0, CGRectGetHeight(scrollMenuView.frame), 1024, 64);
        self.totalCountView.backgroundColor = UIColorFromRGB(241.0, 241.0, 241.0);
        [ self.headView addSubview:self.totalCountView];
        
        [ self.headView addSubview:scrollMenuView];
        self.countLabel = [[UILabel alloc]init];
        _countLabel.frame = CGRectMake(20.0, 25.0, 100.0, 20);
        _countLabel.font = [UIFont systemFontOfSize:18.0];
        _countLabel.textColor = [UIColor blackColor];
        [self.totalCountView addSubview:_countLabel];
        self.priceLabel = [[UILabel alloc]init];
        _priceLabel.frame = CGRectMake(900.0, 25.0, 300.0, 20);
        _priceLabel.font = [UIFont systemFontOfSize:15.0];
        _priceLabel.textColor =  [UIColor colorWithRed:244.0/255 green:111.0/255 blue:34.0/255 alpha:1.0];
        [self.totalCountView addSubview:_priceLabel];
        
        
        NSMutableArray* countArray = [NSMutableArray array];
        int totalPrice=0;
        for (NSDictionary* dic in buffer) {
            
            NSArray* array = [dic objectForKey:@"details"];
            for (int i = 0; i<array.count; i++) {
                
                [countArray addObject:[NSNumber numberWithInt:i]];
            }
            int price = [[dic objectForKey:@"FIncomeAmount"] integerValue];
            
            totalPrice+=price;
        }
        self.countLabel.text = [NSString stringWithFormat:@"合计: %d份",countArray.count];
        self.priceLabel.text = [NSString stringWithFormat:@"小计:￥%d",totalPrice];
        
        return  self.headView;

    }
    return nil;
}

- (void)btn_cancel_click:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)backButtonMethod:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}
- (void)scrollMenu:(ACPItem *)menu didSelectIndex:(NSInteger)selectedIndex
{
    if (1 == selectedIndex) {
        payStatus = @"Payed";
    }
    else {
        payStatus = @"UnPay";
    }
    [buffer removeAllObjects];
    [self.tableView reloadData];
    [self loadData];
}

- (void)loadData
{
        
    if ([buffer count] == 0)
//        [SVProgressHUD showWithStatus:@"获取数据中"];
    [DejalBezelActivityView activityViewForView:self.view];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, ProductOrderList_URL];
    
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:payStatus forKey:@"status"];
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
      //  [SVProgressHUD dismissWithError:@"获取数据失败!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"获取数据失败!" duration:2 position:@"center"];
		return;
	}
    
    NSArray* array = [[json objectForKey:@"data"] objectForKey:@"orderList"];
    if ([array count] == 0) {
       // [SVProgressHUD dismissWithSuccess:@"无数据!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"无数据!" duration:2 position:@"center"];
        return;
    }
    [DejalBezelActivityView removeViewAnimated:YES];
    
    //[SVProgressHUD dismiss];
    [buffer removeAllObjects];
    [buffer addObjectsFromArray:array];
    [self filtBuffer];
    [self.tableView reloadData];

}

- (void) onLoadFail: (NSNotification *)notify
{
//    [SVProgressHUD dismissWithError:@"网络错误!" afterDelay:1.5f];
    [DejalBezelActivityView removeViewAnimated:YES];
    [self.view makeToast:@"网络错误!" duration:2 position:@"center"];
	RRLoader *loader = (RRLoader *)[notify object];
	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
}

- (void)filtBuffer
{
    NSSortDescriptor  *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"FCreateTime" ascending:NO];
    NSArray *tempArray = [buffer sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [buffer removeAllObjects];
    [buffer addObjectsFromArray:tempArray];
    
}

@end
