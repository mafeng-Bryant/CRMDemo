//
//  OrderHomeViewController.m
//  CRM
//
//  Created by 马峰 on 14-11-27.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "OrderHomeViewController.h"
#import "CheckListCell.h"
#import "LogoutViewController.h"
#import "UIViewController+MJPopupViewController.h"

#import "SVProgressHUD.h"
#import "RRToken.h"
#import "RRLoader.h"
#import "RRURLRequest.h"

#import "MMGridViewDefaultCell.h"
#import "Toast+UIView.h"

#import "SystemConfigContext.h"
#import "Product.h"
#import "ChildProduct.h"
#import "DetailProduct.h"
#import "JsonMa.h"
#import "ProductButton.h"

#import "GoodsFilterViewController.h"
#import "GoodsListViewController.h"
#import "EScrollerView.h"
#import "ConfirmOrderViewController.h"

#import "MySQLite.h"


#import "TFHpple.h"
#define PageSize 6 //默认一页显示6个
#import "AppDelegate.h"
#import "DejalActivityView.h"


@interface OrderHomeViewController ()<LogoutViewControllerDelegate,MMGridViewDefaultCellDelegate,OrderViewControllerDelegate>
{
    BOOL is_detail;
    NSUInteger sumPrice;
    UIView* tableView_head;
    NSString *catalogName;


}
@property(nonatomic,strong) NSMutableArray* orderListArray;
@property(nonatomic,strong) LogoutViewController* logoutViewController;
@property(nonatomic,strong) NSMutableArray* productListArray;
@property(nonatomic,strong) NSMutableArray* allProductArray;
@property(nonatomic,strong)IBOutlet EScrollerView *imageArrayView;
@property(nonatomic,strong) ConfirmOrderViewController* confirmOrderVC;
//商品选择。
@property(nonatomic,strong) GoodsFilterViewController* filterVC;
@property(nonatomic,strong) UIView* maskView;

@property(nonatomic,assign) NSInteger pageSize;
@property(nonatomic,assign) NSInteger pageIndex;
@property(nonatomic,assign) NSInteger pageCount;
@property(nonatomic,strong) ProductButton* productsButton;

//收集动态创建的按钮
@property(nonatomic,strong) NSMutableArray* dynamicButtonArray;

@property(nonatomic,assign) BOOL hasCreateDynamicButton;

@property(nonatomic,strong) NSDictionary* detailProductDic;

//排序字段
@property(nonatomic,strong) NSString* orderString;
//分类字段,记录当前在哪个字段
@property(nonatomic,strong) NSString* categoryString;

@property(nonatomic,strong) NSString* currentClickProductId;

//是否已经下单了
@property(nonatomic,assign) BOOL has_OrederGoods;

@property(nonatomic,assign) BOOL hasEnter;

@property(nonatomic,assign) BOOL renqiRuation;
@property(nonatomic,assign) BOOL sellRuation;
@property(nonatomic,assign) BOOL priceRuation;
@property(nonatomic,assign) BOOL timeRuation;

@property(nonatomic,strong) NSString* segmentControlType;
@property(nonatomic,strong)  UISegmentedControl *segmentControl;

@property(nonatomic,strong) DetailProduct* currentClickProduct;

@property(nonatomic,strong) NSMutableArray* clickDetailArray;
@property(nonatomic,assign) BOOL clickDetailed;//是否点击了商品详情页面。



@end

@implementation OrderHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)initViews
{
    //下单页面
    self.successHeadView.backgroundColor =  UIColorFromRGB(241.0, 241.0, 241.0);
    self.successView.layer.cornerRadius = 8.0;
    self.successHeadView.layer.cornerRadius = 8.0;
    self.view.backgroundColor = UIColorFromRGB(229, 229, 229);
    self.dynamicButtonArray = [NSMutableArray array];
    self.orderListArray = [NSMutableArray array];
    self.allProductArray = [NSMutableArray array];
    self.navigationImageView.backgroundColor = [UIColor colorWithRed:244.0/255 green:111.0/255 blue:34.0/255 alpha:1.0];
    UIImage* homelogImage = [UIImage imageNamed:@"homelogo.png"];
    self.homeLogoImageview.frame = CGRectMake(10, 12, homelogImage.size.width/2.0, homelogImage.size.height/2.0);
    self.homeLogoImageview.image = homelogImage;
    
    
    self.myOrderButton.backgroundColor = UIColorFromRGB(219, 90, 15);
    [self.myOrderButton setTitle:@"我的订单" forState:UIControlStateNormal];
    [self.myOrderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.myOrderButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.myOrderButton.layer.cornerRadius = 4.0;
    
    
    self.loginOut.backgroundColor = UIColorFromRGB(133, 139, 149);
    [self.loginOut setTitle:@"退出" forState:UIControlStateNormal];
    [self.loginOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginOut.titleLabel.font = [UIFont systemFontOfSize:16];
    self.loginOut.layer.cornerRadius = 4.0;
    
    
    self.orderingButton.backgroundColor = [UIColor colorWithRed:244.0/255 green:111.0/255 blue:34.0/255 alpha:1.0];
    [self.orderingButton setTitle:@"下单" forState:UIControlStateNormal];
    [self.orderingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.orderingButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.orderingButton.layer.cornerRadius = 4.0;
    
    self.refrehButton.backgroundColor = UIColorFromRGB(34, 89, 160);
    [self.refrehButton setTitle:@"清除" forState:UIControlStateNormal];
    [self.refrehButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.refrehButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.refrehButton.layer.cornerRadius = 4.0;
    
    
    self.bottomView.layer.borderColor = [UIColor colorWithRed:178.0/255 green:178.0/255 blue:178.0/255 alpha:1.0].CGColor;
    self.bottomView.layer.borderWidth = 0.5;
    
    self.orderTableView.separatorColor = [UIColor clearColor];
    
    
    
    self.defaultpaixunButton.backgroundColor = [UIColor clearColor];
    [self.defaultpaixunButton setTitle:@"默认排序" forState:UIControlStateNormal];
    [self.defaultpaixunButton setTitleColor:UIColorFromRGB(34, 30, 31) forState:UIControlStateNormal];
    [self.defaultpaixunButton setTitleColor: UIColorFromRGB(244, 111, 34) forState:UIControlStateSelected];
    self.defaultpaixunButton.selected = YES;
    
    
    UIImage* normalImage = [UIImage imageNamed:@"paixundefault.png"];
    UIImage* highImage = [UIImage imageNamed:@"paixun.png"];
    self.renqiButton.backgroundColor = [UIColor clearColor];
    [self.renqiButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [ self.renqiButton setBackgroundImage:highImage forState:UIControlStateSelected];
    self.renqiButton.selected = NO;
  
    self.sellButton.backgroundColor = [UIColor clearColor];
    [self.sellButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [ self.sellButton setBackgroundImage:highImage forState:UIControlStateSelected];
    self.sellButton.selected = NO;
 
    UIImage* normalImageone = [UIImage imageNamed:@"upimagedefault.png"];
    UIImage* highImageone = [UIImage imageNamed:@"upimage.png"];
    self.priceButton.backgroundColor = [UIColor clearColor];
    [self.priceButton setBackgroundImage:normalImageone forState:UIControlStateNormal];
    [ self.priceButton setBackgroundImage:highImageone forState:UIControlStateSelected];
    self.priceButton.selected = NO;

    self.timeButton.backgroundColor = [UIColor clearColor];
    [self.timeButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [ self.timeButton setBackgroundImage:highImage forState:UIControlStateSelected];
    self.timeButton.selected = NO;
   
    [self.renqiLabelButton setTitleColor:UIColorFromRGB(34, 30, 31) forState:UIControlStateNormal];
    [self.renqiLabelButton setTitleColor:UIColorFromRGB(244, 111, 34) forState:UIControlStateSelected];
    [self.sellLabelButton setTitleColor:UIColorFromRGB(34, 30, 31) forState:UIControlStateNormal];
    [self.sellLabelButton setTitleColor:UIColorFromRGB(244, 111, 34) forState:UIControlStateSelected];
    [self.priceLabelButton setTitleColor:UIColorFromRGB(34, 30, 31) forState:UIControlStateNormal];
    [self.priceLabelButton setTitleColor:UIColorFromRGB(244, 111, 34) forState:UIControlStateSelected];
    [self.timeLabelButton setTitleColor:UIColorFromRGB(34, 30, 31) forState:UIControlStateNormal];
    [self.timeLabelButton setTitleColor:UIColorFromRGB(244, 111, 34) forState:UIControlStateSelected];
    self.pictureLabel.textColor = [UIColor lightGrayColor];

   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.segmentControlType = @"hasClicked";
    self.productListArray = [NSMutableArray array];
    self.hasCreateDynamicButton = NO;
    self.hasEnter = NO;
    self.renqiRuation = NO;
    self.sellRuation = NO;
    self.priceRuation = NO;
    self.timeRuation = NO;
    self.clickDetailed = NO;
    self.clickDetailArray = [NSMutableArray array];
    [self initViews];
    _gridView.cellMargin = 10;
    _gridView.numberOfRows = 3;
    _gridView.numberOfColumns = 2;
    _gridView.layoutStyle = HorizontalLayout;
    
    //正式方法
    [self loadComendData];
    
    //测试方法
    [self setupPageControl];
    
    //加载点选的商品，从数据库中
  //  [self loadProdect];
}

- (void)setupPageControl
{
    self.pageControl.numberOfPages = _gridView.numberOfPages;
    self.pageControl.currentPage = _gridView.currentPageIndex;
}
- (void)loadComendData
{
//    if (self.productListArray.count ==0) {
        [DejalBezelActivityView activityViewForView:self.view];
        [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
        
    //}
    
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, RECOMMEND_allData_URL];
    RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    
    [req setHTTPMethod:@"POST"];

    RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoaded:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
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
        [self reload];
		return;
	}
    
    NSArray *arr = [data objectForKey:@"catalogs"];
    if ([arr count] == 0) {
      //  [SVProgressHUD dismissWithError:@"暂无数据!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"暂无数据!" duration:2 position:@"center"];
        [self reload];
        return;
    }
    //[SVProgressHUD dismiss];
    [self.productListArray removeAllObjects];
    
    [DejalBezelActivityView removeViewAnimated:YES];
    
    //获取首页默认推荐数据。 //测试
    NSArray* menuConfigs = nil;
    menuConfigs = [[SystemConfigContext sharedInstance] getTestMenuConfigs];
//    NSDictionary* dic = [menuConfigs objectAtIndex:0];
//    NSArray* newArray = [dic objectForKey:@"data"];
    
    
   for (NSDictionary* newdic in arr) {
        Product* product = [[Product alloc]init];
        product.comendProductId =[newdic objectForKey:@"id"];
        product.commendTitle = [newdic objectForKey:@"text"];
        product.childArray = [NSMutableArray array];
        NSArray* listArray = [newdic objectForKey:@"children"];
        for (NSDictionary* childDic in listArray) {
         
            ChildProduct* childProduct = [[ChildProduct alloc]init];
            if ([childDic objectForKey:@"children"]) {
                childProduct.secondProductId = [childDic objectForKey:@"id"];
                childProduct.secondProductTitle = [childDic objectForKey:@"text"];
                childProduct.secondChildArray = [NSMutableArray array];
                NSArray* arr = [childDic objectForKey:@"children"];
                for (NSDictionary* smallDic  in arr) {
                    DetailProduct* detailProduct = [[DetailProduct alloc]init];
                    detailProduct.detailProductId = [smallDic objectForKey:@"id"];
                    detailProduct.detailProductTitle = [smallDic objectForKey:@"text"];
                    [childProduct.secondChildArray addObject:detailProduct];
                }
                [product.childArray addObject:childProduct];
             }else {
          
                childProduct.secondProductId = [childDic objectForKey:@"id"];
                childProduct.secondProductTitle = [childDic objectForKey:@"text"];
                [product.childArray addObject:childProduct];
            }
        }
        
      [self.productListArray addObject:product];
       Product* productone = self.productListArray[0];
       self.categoryString = productone.comendProductId;
    }
    JsonMa* jsonMa = [[JsonMa alloc]init];
    BOOL success =[jsonMa jsonOk:self.productListArray];
    NSLog(@"success = %d",success);
    [self createDynamicButton];
    
    self.orderString = @"FCreateTime desc";

    //获取推荐列表
    [self getBaseProducts];
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
- (void)getBaseProducts
{

   // [SVProgressHUD showWithStatus:@"获取数据中"];
    
    [DejalBezelActivityView activityViewForView:self.view];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, ProductCategoryList_URL];
    RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:self.categoryString forKey:@"catalogId"];
	[req setParam:@"1" forKey:@"pageIndex"];
	[req setParam:@"100" forKey:@"pageSize"];
	[req setParam:self.orderString forKey:@"order"];
    [req setHTTPMethod:@"POST"];
    
    RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onCommendLoaded:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
}
- (void)getCategoryGoods:(NSString*)productId
{
    self.categoryString = productId;
   // [SVProgressHUD showWithStatus:@"获取数据中"];
    [DejalBezelActivityView activityViewForView:self.view];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, ProductCategoryList_URL];
    RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:self.categoryString forKey:@"catalogId"];
	[req setParam:@"1" forKey:@"pageIndex"];
	[req setParam:@"12" forKey:@"pageSize"];
	[req setParam:self.orderString forKey:@"order"];
    [req setHTTPMethod:@"POST"];
    
    RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onCategoryGoods:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
}
- (void)onCategoryGoods:(NSNotification*)noti
{
    
    [self.allProductArray removeAllObjects];
    [self reload];
    RRLoader *loader = (RRLoader *)[noti object];
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
	// fail
	if (![[json objectForKey:@"success"] boolValue])
	{
       // [SVProgressHUD dismissWithError:@"获取数据失败!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"获取数据失败!" duration:2 position:@"center"];
        
		return;
	}
    
    NSArray *arr = [[data objectForKey:@"list"] objectForKey:@"records"];
    if ([arr count] == 0) {

        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"暂无数据!" duration:2 position:@"center"];
        return;
    }
    
    
    [DejalBezelActivityView removeViewAnimated:YES];
    self.pageSize = [[data objectForKey:@"pageCount"]integerValue];
    self.pageIndex = [[data objectForKey:@"pageIndex"] integerValue]+1;
    
    for (int i=0; i<arr.count; i++) {
        DetailProduct* product = [[DetailProduct alloc]init];
        NSDictionary* detailDic = arr[i];
        product.goodDescration = [detailDic objectForKey:@"FShortDes"];
        product.fCreateTime = [detailDic objectForKey:@"FCreateTime"];
        product.detailProductId = [detailDic objectForKey:@"FId"];
        product.detailProductTitle = [detailDic objectForKey:@"FName"];
        product.priceNumber = [detailDic objectForKey:@"FPrice"];
        product.fUnit = [detailDic objectForKey:@"FUnit"];
        product.FMasterCatalogId = [detailDic objectForKey:@"FMasterCatalogId"];
        product.FStoreAvatarImageId = [detailDic objectForKey:@"FStoreAvatarId"];
        [self.allProductArray addObject:product];
    }
    [self reload];
}
- (void)onCommendLoaded:(NSNotification*)noti
{
    RRLoader *loader = (RRLoader *)[noti object];
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
	// fail
	if (![[json objectForKey:@"success"] boolValue])
	{
      //  [SVProgressHUD dismissWithError:@"获取数据失败!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"获取数据失败!" duration:2 position:@"center"];
		return;
	}
    
    NSArray *arr = [[data objectForKey:@"list"] objectForKey:@"records"];
    if ([arr count] == 0) {
        
        [DejalBezelActivityView removeViewAnimated:YES];
   
        [self.view makeToast:@"暂无数据!" duration:1 position:@"center"];
        
        //[SVProgressHUD dismissWithError:@"暂无数据!"];

        return;
    }
   // [SVProgressHUD dismiss];
    
    [DejalBezelActivityView removeViewAnimated:YES];


    self.pageSize = [[data objectForKey:@"pageCount"]integerValue];
    self.pageIndex = [[data objectForKey:@"pageIndex"] integerValue]+1;

    [self.allProductArray removeAllObjects];
    for (int i=0; i<arr.count; i++) {
        DetailProduct* product = [[DetailProduct alloc]init];
        NSDictionary* detailDic = arr[i];
        product.goodDescration = [detailDic objectForKey:@"FShortDes"];
        product.fCreateTime = [detailDic objectForKey:@"FCreateTime"];
        product.detailProductId = [detailDic objectForKey:@"FId"];
        product.detailProductTitle = [detailDic objectForKey:@"FName"];
        product.priceNumber = [detailDic objectForKey:@"FPrice"];
        product.fUnit = [detailDic objectForKey:@"FUnit"];
        product.FMasterCatalogId = [detailDic objectForKey:@"FMasterCatalogId"];
        product.FStoreAvatarImageId = [detailDic objectForKey:@"FStoreAvatarId"];
        [self.allProductArray addObject:product];
    }
    [self reload];

}

//动态创建按钮。
- (void)createDynamicButton
{
    
    if (self.dynamicButtonArray.count > 0) {
        for (int i = 0; i<self.dynamicButtonArray.count; i++) {
            ProductButton* bt = self.dynamicButtonArray[i];
            
            [bt removeFromSuperview];
        }
    }
    Product* product = [self.productListArray lastObject];
    NSArray* array = product.childArray;
    NSMutableArray* titleArray = [NSMutableArray array];
    NSMutableArray* idArray = [NSMutableArray array];
    for (ChildProduct* childProduct in array) {
    [titleArray addObject:childProduct.secondProductTitle];
    [idArray addObject:childProduct.secondProductId];
        
    }
    CGFloat X =0.0;
    for (int i = 0; i <product.childArray.count+1; i++) {
     
        ProductButton* button = [ProductButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(210.0+X+94*i, 24, 94, 32);
        button.product = self.productListArray[0];
        if (i==0) {
            
            button.backgroundColor = [UIColor whiteColor];
            button.selected = YES;
            [button setTitle:@"推荐" forState:UIControlStateNormal];
            button.productButtonId = product.comendProductId;
            button.tag = KCommendButtonTag;
   
        }else {
            
            button.backgroundColor = UIColorFromRGB(219, 90, 15);
            button.selected = NO;
            [button setTitle:[titleArray objectAtIndex:i-1] forState:UIControlStateNormal];
            button.productButtonId = [idArray objectAtIndex:i-1];
        }
        [button setTitleColor:UIColorFromRGB(244, 111, 34) forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.layer.cornerRadius = 4.0;
        [button addTarget:self action:@selector(changeMenuButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.dynamicButtonArray addObject:button];
        [self.navigationBackView addSubview:button];
        X+=24.0;
    }
    

}
- (void)reload
{
    [_gridView reloadData];
    [self setupPageControl];
    [self showButtomView];
}
- (void)showButtomView
{
    if ([self.orderListArray count]) {
    
        self.tableFootView.hidden = NO;
      
        float sum = 0.0;
        for (DetailProduct* product in self.orderListArray) {
            
         sum+=product.clickCount*[product.priceNumber integerValue];
        
        }
     self.PriceLabel.textColor =[UIColor colorWithRed:244.0/255 green:111.0/255 blue:34.0/255 alpha:1.0];
     self.PriceLabel.text =[NSString stringWithFormat:@"￥%.0f",sum];
        
    }else {
    
        self.tableFootView.hidden = YES;
        
    }
}
- (void)cancelPopView
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    self.confirmOrderVC= nil;
    
    if (is_detail) {
        
        [self dismissDetailView];
        
    }
    self.clickDetailArray = [NSMutableArray array];
    self.clickDetailed = NO;
    

}
#pragma mark - MMGridViewDataSource
- (NSInteger)numberOfCellsInGridView:(MMGridView *)gridView
{
    if ([self.allProductArray count]) {
        
        return self.allProductArray.count;
    }
  return 0;
}

- (MMGridViewCell *)gridView:(MMGridView *)gridView cellAtIndex:(NSUInteger)index
{

    DetailProduct* product = [self.allProductArray objectAtIndex:index];
    MMGridViewDefaultCell *cell = [[MMGridViewDefaultCell alloc] initWithFrame:CGRectNull];
    for (DetailProduct *d in self.allProductArray) {
        if ([d.detailProductId isEqualToString:product.detailProductId]) {
            
            cell.sum = d.clickCount;
            
            break;
        }
    }
    [cell setUpCellData:product];
    cell.delegate = self;
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", index];
    cell.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"img9"]];
    return cell;
}
-(void)loadMoreForGrid
{
    if ([catalogName isEqualToString:@"0"]) {
      //  [self loadMoreRecommendData];
    }
    
    else if ([catalogName isEqualToString:@"4"]) {
      //  [self loadMoreRecommendData];
    }
    
    else {
    //    [self loadMoreYearData];
    }
}
-(void)LoadDataFinished
{
    
    [_gridView reloadData];
    [_gridView loadMoreFinished];
}
#pragma mark - MMGridViewDelegate
- (void)gridView:(MMGridView *)gridView didSelectCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
    DetailProduct *detailProduct = [self.allProductArray objectAtIndex:index];
    self.currentClickProduct =detailProduct;
    [self loadDetail:detailProduct];
    
    //当点击了详情页面的时候，就将数据源加入到clickDetailArray中
    self.clickDetailed = YES;
    self.clickDetailArray = [NSMutableArray arrayWithObject:detailProduct];//始终只有一个
}
- (void)loadDetail:(DetailProduct*)product
{
    //[SVProgressHUD showWithStatus:@"获取数据中"];
    [DejalBezelActivityView activityViewForView:self.view];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, ProductCategoryDetail_URL];
    
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
	[req setParam:product.detailProductId forKey:@"productId"];
   [req setHTTPMethod:@"POST"];
	
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoadDetail:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];

}
- (void) onLoadDetail: (NSNotification *)notify
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
       // [SVProgressHUD dismissWithError:@"获取数据失败!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"获取数据失败!" duration:2 position:@"center"];
        //test data
        [self showDetailView];
        return;
	}
    if ([[[json objectForKey:@"data"] objectForKey:@"msg"] length]) {
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:[[json objectForKey:@"data"] objectForKey:@"msg"] duration:2 position:@"center"];
      //  [SVProgressHUD dismissWithSuccess:[[json objectForKey:@"data"] objectForKey:@"msg"]];
        //test data
        return;
    }
    
    //[SVProgressHUD dismiss];
    [DejalBezelActivityView removeViewAnimated:YES];
    self.detailProductDic = [[json objectForKey:@"data"] objectForKey:@"product"];
    [self showDetailView];
}
- (void)showDetailView
{
    
    self.defaultpaixunButton.hidden = YES;
    self.renqiButton.hidden = YES;
    self.sellButton.hidden = YES;
    self.priceButton.hidden = YES;
    self.timeButton.hidden = YES;
    self.timeLabelButton.hidden= YES;
    self.priceLabelButton.hidden = YES;
    self.sellLabelButton.hidden = YES;
    self.renqiLabelButton.hidden = YES;
    
    is_detail = YES;
    sumPrice = 0;
    [self setUpDetailView];
    self.pageControl.hidden = YES;
    self.goodDetailView.frame = CGRectMake(1050, 125, 808, 559);
    [self.view addSubview:self.goodDetailView];
    
    [UIView beginAnimations:@"split" context:nil];
    [UIView setAnimationDuration:0.5];
    self.goodDetailView.frame = CGRectMake(196, 125, 808, 559);
    [UIView commitAnimations];
}
- (void)dismissDetailView
{
    
    self.defaultpaixunButton.hidden = NO;
    self.renqiButton.hidden = NO;
    self.sellButton.hidden = NO;
    self.priceButton.hidden = NO;
    self.timeButton.hidden = NO;
    self.timeLabelButton.hidden= NO;
    self.priceLabelButton.hidden = NO;
    self.sellLabelButton.hidden = NO;
    self.renqiLabelButton.hidden = NO;
    is_detail = NO;
    sumPrice = 0;
    self.pageControl.hidden = NO;
    [UIView beginAnimations:@"split" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeDetailView)];
    self.goodDetailView.frame = CGRectMake(1050, 125, 808, 559);
    [UIView commitAnimations];
}
- (void)removeDetailView
{
    [self.goodDetailView removeFromSuperview];
    [self.imageArrayView removeFromSuperview];
    self.imageArrayView = nil;
}
- (NSString*)paserHtml
{
    NSString* str =[self.detailProductDic objectForKey:@"FDescription"];
    NSData* htmlData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSString* nodeString = @"//span";
    TFHpple* xpathParser=[[TFHpple alloc]initWithHTMLData:htmlData];
    NSArray* elementArray = [xpathParser searchWithXPathQuery:nodeString];
    for (TFHppleElement *element in elementArray) {
        
        if ([element content]!=nil) {
            
          return  [element content];
            
        }
        
    }
    return nil;
}
- (void)setUpDetailView
{
    
    
    //  [self paserHtml];
    self.detailNameLable.text = [self.detailProductDic objectForKey:@"FName"];
    NSString* price = [self.detailProductDic objectForKey:@"FUnitPrice"];
    self.detailPriceLable.text = [NSString stringWithFormat:@"￥%@/%@",price,[self.detailProductDic objectForKey:@"FUnit"]];
    self.detailPriceLable.textColor = [UIColor colorWithRed:244.0/255 green:111.0/255 blue:34.0/255 alpha:1.0];
       // self.detailForePriceLable.text = @"22";
            UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(5, 11, 62, 1)];
            im.image = [UIImage imageNamed:@"img31"];
           // [self.detailForePriceLable addSubview:im];
   
    self.unitNameLable.text = [NSString stringWithFormat:@"%@",[self.detailProductDic objectForKey:@"FUnit"]];
    self.shengshuLable.text = [self.detailProductDic objectForKey:@"FName"];
    self.baozhuangLable.text =[NSString stringWithFormat:@"%@元",[self.detailProductDic objectForKey:@"FUnitPrice"]];
    self.xingtaiLable.text = [self.detailProductDic objectForKey:@"FUnit"];
    self.guigeLable.text =[self.detailProductDic objectForKey:@"FCreateTime"];
    
    NSString *html_str = [NSString stringWithFormat:@"%@",[self.detailProductDic objectForKey:@"FDescription"]];
    [self.webView loadHTMLString:html_str baseURL:nil];
    self.shengshuLable.textColor = UIColorFromRGB(27.0, 27.0, 27.0);
    self.shengshuLable.font = [UIFont systemFontOfSize:14];
    self.baozhuangLable.textColor = UIColorFromRGB(27.0, 27.0, 27.0);
    self.baozhuangLable.font = [UIFont systemFontOfSize:14];
    self.xingtaiLable.textColor = UIColorFromRGB(27.0, 27.0, 27.0);
    self.xingtaiLable.font = [UIFont systemFontOfSize:14];
    self.guigeLable.textColor = UIColorFromRGB(27.0, 27.0, 27.0);
    self.guigeLable.font = [UIFont systemFontOfSize:14];
    self.pinzhiText.textColor = UIColorFromRGB(27.0, 27.0, 27.0);
    self.pinzhiText.font = [UIFont systemFontOfSize:14];
    self.pinzhiText.font = [UIFont systemFontOfSize:14.0f];
    self.noShenshuLabel.textColor = UIColorFromRGB(153.0, 153.0, 153.0);
    self.noBaozhuanLabel.textColor = UIColorFromRGB(153.0, 153.0, 153.0);
    self.noChangpinLabel.textColor = UIColorFromRGB(153.0, 153.0, 153.0);
    self.noGuigeLabel.textColor = UIColorFromRGB(153.0, 153.0, 153.0);
    self.noPiciLabel.textColor = UIColorFromRGB(153.0, 153.0, 153.0);
   

    NSArray *array = [self.detailProductDic objectForKey:@"list"];
    if (array.count > 0) {
        NSMutableArray *a = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            NSString *str = [dic objectForKey:@"url"];
            [a addObject:[BASE_URL stringByAppendingString:str]];
        }
        self.imageArrayView = [[EScrollerView alloc] initWithFrameRect:CGRectMake(10, 74, 490, 385)
                                                            ImageArray:a
                                                            TitleArray:nil];
        [self.goodDetailView addSubview:self.imageArrayView];
    
        
    } else{
        
        [self.imageArrayView removeFromSuperview];
        self.imageArrayView = nil;
        
    }

    for (DetailProduct *product in self.orderListArray) {
     
        product.detailProductId = [product.detailProductId uppercaseString];
    if ([product.detailProductId isEqualToString:[self.detailProductDic objectForKey:@"FId"]]) {
            
            sumPrice = product.clickCount;
        
        [self.detailProductDic setValue:[NSNumber numberWithInteger:product.clickCount] forKey:@"countNumber"];
        
         self.detailSumLable.text = [NSString stringWithFormat:@"%lu",(unsigned long)sumPrice];
            break;
        }
    }
}
- (void)gridView:(MMGridView *)gridView didDoubleTapCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
     
}
- (void)gridView:(MMGridView *)theGridView changedPageToIndex:(NSUInteger)index
{
    NSInteger  currentIndex = index;
    [self setupPageControl];
}

-(BOOL)canLoadMoreForGrid
{
//    if (roomViewDidShow) {
//        return NO;
//    }
//    if (pageCount > pageIndex-1) {
//        return YES;
//    }
    return YES;
}


#pragma TableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (!tableView_head) {
        
        tableView_head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 176, 50)];
        self.segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"已点选",@"已下单"]];
        _segmentControl.tintColor = [UIColor colorWithRed:244.0/255 green:111.0/255 blue:34.0/255 alpha:1.0];
        _segmentControl.frame = CGRectMake(10, 10, 176-20, 29);
        _segmentControl.selectedSegmentIndex = 0;
        [_segmentControl addTarget:self action:@selector(segmentedControlDidChange:) forControlEvents:UIControlEventValueChanged];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 176, 50)];
        lb.textColor = dayiColor;
        lb.text = @"购物车";
        lb.textAlignment = NSTextAlignmentCenter;
        
        UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 176, 1)];
        im.image = [UIImage imageNamed:@"img32"];
      //   [tableView_head addSubview:lb];
        [tableView_head addSubview:_segmentControl];
        [tableView_head addSubview:im];
        
        tableView_head.backgroundColor = [UIColor whiteColor];
    
        
    }
       return tableView_head;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.orderListArray count] == 0) {
        return 0;
    }
    return [self.orderListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.orderListArray count] == 0) {
        static NSString *cell_id = @"empty_cell";
        
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell_id];
        if (nil == cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        }
        
        UIFont *font = [UIFont systemFontOfSize:15.0f];
        //        cell.textLabel.text = @"无数据";
        cell.textLabel.font = font;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    NSString *CellIdentifier = @"CheckListCell";
    DetailProduct *detailProduct = [self.orderListArray objectAtIndex:indexPath.row];
    
    CheckListCell*cell = (CheckListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell)
    {
        UIViewController *uc = [[UIViewController alloc] initWithNibName:CellIdentifier bundle:nil];
        
        cell = (CheckListCell *)uc.view;
        [cell setContent:detailProduct];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.orderListArray.count ==0) {
        return;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailProduct *detailProduct = [self.orderListArray objectAtIndex:indexPath.row];
    [self loadDetail:detailProduct];
}
- (void)loadProdect
{
    NSArray* list = [[MySQLite shareSQLiteInstance] getDetailProduct:@"ProductTable"];
     [self.orderListArray addObjectsFromArray:list];
    [self.orderTableView reloadData];
    
}
- (void)segmentedControlDidChange:(UISegmentedControl*)control
{
    //@"已点选",@"已下单"
    if (control.selectedSegmentIndex ==0) {
        self.segmentControlType = @"hasClicked";
        [self.orderListArray removeAllObjects];
        [self loadProdect];
        [self showButtomView];
     }else if (control.selectedSegmentIndex ==1){
        self.segmentControlType = @"hasdownList";
         [self.orderListArray removeAllObjects];
         [self getMyOrderList];
     }


}
- (void)getMyOrderList
{
    if ([self.orderListArray count] == 0){
    
        [DejalBezelActivityView activityViewForView:self.view];
        [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    }
      //  [SVProgressHUD showWithStatus:@"获取数据中"];
   
    
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, ProductOrderList_URL];
    
    RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:@"UnPay" forKey:@"status"];
    [req setHTTPMethod:@"POST"];
    
    RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
    [loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onMyOrderListLoaded:)];
    [loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
    [loader loadwithTimer];
    
}
- (void)onMyOrderListLoaded:(NSNotification *)notify
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
    
    
    
    NSArray* array = [[json objectForKey:@"data"] objectForKey:@"orderList"];
    if ([array count] == 0) {
       // [SVProgressHUD dismissWithSuccess:@"无数据!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"无数据!" duration:2 position:@"center"];
        [self.orderTableView reloadData];
        [self showButtomView];

         return;
    }
   // [SVProgressHUD dismiss];
    [DejalBezelActivityView removeViewAnimated:YES];
    
  for (NSDictionary* dic in array) {
     
        NSString* createTime = [dic objectForKey:@"FCreateTime"];
        NSArray* productsArr = [dic objectForKey:@"details"];
        for (NSDictionary* samllDic in productsArr) {
            
            DetailProduct* product = [[DetailProduct alloc]init];
            product.clickCount = [[samllDic objectForKey:@"FQuantity"] intValue];
            product.fCreateTime = createTime;
            product.detailProductId = [samllDic objectForKey:@"FId"];
            product.detailProductTitle = [samllDic objectForKey:@"FProductId$"];
            product.priceNumber = [samllDic objectForKey:@"FUnitPrice"];
            product.fUnit = [samllDic objectForKey:@"FUnit"];
            product.FStoreAvatarImageId = [samllDic objectForKey:@"FStoreAvatarId"];
            [self.orderListArray addObject:product];
        }
    }
    
    
    [self filtBuffer];
    [self.orderTableView reloadData];
    [self showButtomView];
}

- (void)filtBuffer
{
    NSSortDescriptor  *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"fCreateTime" ascending:NO];
    NSArray *tempArray = [self.orderListArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [self.orderListArray removeAllObjects];
    [self.orderListArray addObjectsFromArray:tempArray];
    
}
- (void)changeProdectNumber:(DetailProduct *)detailproduct
{
    if ([self.segmentControlType isEqualToString:@"hasdownList"]) {
        self.segmentControlType = @"hasClicked";
        self.segmentControl.selectedSegmentIndex =0;
        [self.orderListArray removeAllObjects];
        [self loadProdect];
        [self showButtomView];
        
    }
    for (DetailProduct* product in self.orderListArray) {
        
        if (![product.FMasterCatalogId isEqualToString:detailproduct.FMasterCatalogId]) {
            [self.view makeToast:@"您已经点选一类商品，不能在下单另一类商品!" duration:1 position:@"center"];
            return;
        }
    }
    BOOL is_contain = false;
    for (int i =0; i<self.orderListArray.count; i++) {
        DetailProduct* product = self.orderListArray[i];
        
        if ([product.detailProductId isEqualToString:detailproduct.detailProductId]) {
            
            is_contain = YES;
            [self.orderListArray removeObjectAtIndex:i];
            
            if (detailproduct.clickCount > 0) {
                
                
                [self.orderListArray addObject:detailproduct];
                
                [[MySQLite shareSQLiteInstance]changeDataBaseColoumn:detailproduct tablename:@"ProductTable"];
                
            }
        }
    }
    
    if (!is_contain) {
        
        [self.orderListArray addObject:detailproduct];
        [[MySQLite shareSQLiteInstance]insertDataToSqlite:@"ProductTable" message:detailproduct];
    }
    
    [self.orderTableView reloadData];
    [self showButtomView];
}
- (IBAction)changeMenuButtonMethod:(UIButton *)sender {
   
    [self.searchBar resignFirstResponder];

    ProductButton* button = (ProductButton*)sender;
    for (ProductButton* bt in self.dynamicButtonArray) {
        
        if ([bt isEqual:button]) {
        
            button.backgroundColor = [UIColor whiteColor];
            button.selected = YES;
        }else {
            bt.backgroundColor = UIColorFromRGB(219, 90, 15);
            bt.selected = NO;
        }
    }
    
  
    if (button.tag ==KCommendButtonTag) //点击推荐
    {
     //显示全部商品
        if (self.filterVC) {
            [self.filterVC.view removeFromSuperview];
            self.filterVC = nil;
        }
        self.categoryString = button.productButtonId;
        [self loadComendData];
        
    }else //点击其他按钮 //刷选商品
    {
        
         NSArray* array = button.product.childArray;
         for (ChildProduct* product in array) {
         if ([product.secondProductTitle isEqualToString:[button currentTitle]]) {
           
            if ([product.secondChildArray count])
            {
            [self loadCategoryGoods:product.secondChildArray childProduct:product];
            }else {
                if (self.filterVC) {
                    [self.filterVC.view removeFromSuperview];
                    self.filterVC = nil;
                }
                [self getCategoryGoods:button.productButtonId];
            }
        }
            
            
      }
    }
}
//加载二级菜单下的商品
- (void)loadCategoryGoods:(NSArray*)array childProduct:(ChildProduct*)childProduct
{
    //去创建选择菜单
    
    self.filterVC = nil;
    for (UIView* view in self.view.subviews) {
        if (view.tag ==200) {
            
            [view removeFromSuperview];
        }
    }
    
    self.filterVC = [[GoodsFilterViewController alloc]init];
    self.filterVC.goodsArray = array;
    self.filterVC.childProduct = childProduct;
    self.filterVC.view.frame = CGRectMake(0.0, CGRectGetHeight(self.navigationBackView.frame), self.view.frame.size.width, self.view.frame.size.height -CGRectGetHeight(self.navigationBackView.frame));
    self.filterVC.delegate = self;
    self.filterVC.view.userInteractionEnabled = YES;
    self.filterVC.view.backgroundColor = [UIColor clearColor];
    [self addChildViewController:self.filterVC];
    self.filterVC.view.tag =200;
   [self.view addSubview:self.filterVC.view];
  
}
- (void)didSelectProduct:(ProductButton*)bt categoryString:(NSString*)categoryString
{
    self.categoryString = categoryString;
  //  c8d3dfed-467d-421d-9ec9-7fe4b099a8fd
    //加载产品分类列表，如点击实体产品，将实体产品全部显示出来，如点击茶，将茶下面的分类全部显示出来。
    self.productsButton = bt;
    [self loadCategoryGoodList:self.productsButton];
    
}
- (void)loadCategoryGoodList:(ProductButton*)bt
{
   // [SVProgressHUD showWithStatus:@"获取数据中"];
    [DejalBezelActivityView activityViewForView:self.view];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, ProductCategoryList_URL];
    
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
	[req setParam:@"1" forKey:@"pageIndex"];
	[req setParam:@"12" forKey:@"pageSize"];
    [req setParam:bt.productButtonId forKey:@"catalogId"];
    [req setHTTPMethod:@"POST"];
	
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onProductLoaded:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
}
- (void)onProductLoaded:(NSNotification*)noti
{
    
	RRLoader *loader = (RRLoader *)[noti object];
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
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"获取数据失败!" duration:2 position:@"center"];
        [self reload];
		return;
	}
    
    NSDictionary *dic = [data objectForKey:@"list"];
    if ([dic count] == 0 ||[[dic objectForKey:@"records"] count]==0) {
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"暂无数据!" duration:2 position:@"center"];
        [self.productListArray removeAllObjects];
        [self.allProductArray removeAllObjects];
        [self reload];
        return;
    }
    //[SVProgressHUD dismiss];
    [DejalBezelActivityView removeViewAnimated:YES];
    self.pageSize = [[data objectForKey:@"pageCount"]integerValue];
    self.pageIndex = [[data objectForKey:@"pageIndex"] integerValue]+1;
    
    [self.allProductArray removeAllObjects];
    NSArray* listArray = [dic objectForKey:@"records"];
    for (int i=0; i<listArray.count; i++) {
        DetailProduct* product = [[DetailProduct alloc]init];
        NSDictionary* detailDic = listArray[i];
        product.goodDescration = [detailDic objectForKey:@"FShortDes"];
        product.fCreateTime = [detailDic objectForKey:@"FCreateTime"];
        product.detailProductId = [detailDic objectForKey:@"FId"];
        product.detailProductTitle = [detailDic objectForKey:@"FName"];
        product.priceNumber = [detailDic objectForKey:@"FPrice"];
        product.fUnit = [detailDic objectForKey:@"FUnit"];
        product.FMasterCatalogId = [detailDic objectForKey:@"FMasterCatalogId"];
        product.FStoreAvatarImageId = [detailDic objectForKey:@"FStoreAvatarId"];
        [self.allProductArray addObject:product];
    }
    [self reload];
}
- (void)hideFilterSubmenu
{
    if (self.filterVC) {
        
        [self.filterVC.view removeFromSuperview];
        self.filterVC=nil;
    }
}
- (IBAction)homeSortMethod:(id)sender {
    
    switch ([sender tag]) {
        case KDefaultButtonTag:
        {
            self.defaultpaixunButton.selected = YES;
            self.renqiLabelButton.selected = NO;
            self.sellLabelButton.selected = NO;
            self.priceLabelButton.selected = NO;
            self.timeLabelButton.selected = NO;
            self.renqiButton.selected = NO;
            self.sellButton.selected = NO;
            self.priceButton.selected = NO;
            self.timeButton.selected = NO;
            self.orderString = @"FCreateTime desc";
            break;
        }
        case KRenQiButtonTag:
        {
            self.defaultpaixunButton.selected = NO;
            self.renqiLabelButton.selected = YES;
            self.sellLabelButton.selected = NO;
            self.priceLabelButton.selected = NO;
            self.timeLabelButton.selected = NO;
            
            self.renqiButton.selected = YES;
            self.sellButton.selected = NO;
            self.priceButton.selected = NO;
            self.timeButton.selected = NO;
      //人气--开始默认向下的剪头，点击按生序排列，传FHotDegree，在点击向下，按降排列，传FHotDegree desc。
            if (self.renqiRuation ==NO) {
                
                self.renqiRuation = YES;
                self.orderString = @"FHotDegree";

                
            }else {
            
                self.renqiRuation = NO;
                self.orderString = @"FHotDegree desc";

            }
      self.renqiButton.transform = CGAffineTransformRotate(self.renqiButton.transform, DEGREES_TO_RADIANS(180));
            break;
        }
        case KSellButtonTag:
        {
            self.defaultpaixunButton.selected = NO;
            self.renqiLabelButton.selected = NO;
            self.sellLabelButton.selected = YES;
            self.priceLabelButton.selected = NO;
            self.timeLabelButton.selected = NO;
            self.renqiButton.selected = NO;
            self.sellButton.selected = YES;
            self.priceButton.selected = NO;
            self.timeButton.selected = NO;
            if (self.sellRuation ==NO) {
                
                self.sellRuation = YES;
                self.orderString = @"FSalesVolume";
                
                
            }else {
                
                self.sellRuation = NO;
                self.orderString = @"FSalesVolume desc";
                
            }
             self.sellButton.transform = CGAffineTransformRotate(self.sellButton.transform, DEGREES_TO_RADIANS(180));
            break;
        }
        case KPriceButtonTag:
        {
            self.defaultpaixunButton.selected = NO;
            self.renqiLabelButton.selected = NO;
            self.sellLabelButton.selected = NO;
            self.priceLabelButton.selected = YES;
            self.timeLabelButton.selected = NO;
            self.renqiButton.selected = NO;
            self.sellButton.selected = NO;
            self.priceButton.selected = YES;
            self.timeButton.selected = NO;
            if (self.priceRuation ==NO) {
                
                self.priceRuation = YES;
                self.orderString = @"FUnitPrice desc";
                
                
            }else {
                
                self.priceRuation = NO;
                self.orderString = @"FUnitPrice";
            }
            
            
           self.priceButton.transform = CGAffineTransformRotate(self.priceButton.transform, DEGREES_TO_RADIANS(180));
            break;
        }
        case KTimeButtonTag:
        {
            self.defaultpaixunButton.selected = NO;
            self.renqiLabelButton.selected = NO;
            self.sellLabelButton.selected = NO;
            self.priceLabelButton.selected = NO;
            self.timeLabelButton.selected = YES;
            self.renqiButton.selected = NO;
            self.sellButton.selected = NO;
            self.priceButton.selected = NO;
            self.timeButton.selected = YES;
            if (self.timeRuation ==NO) {
                
                self.timeRuation = YES;
                self.orderString = @"FCreateTime";
                
                
            }else {
                
                self.timeRuation = NO;
                self.orderString = @"FCreateTime desc";
                
            }
              self.timeButton.transform = CGAffineTransformRotate(self.timeButton.transform, DEGREES_TO_RADIANS(180));
            break;
        }
        default:
            break;
    }
    
    //获取推荐列表
    [self getBaseProducts];
}

- (IBAction)OrderButtonMethod:(UIButton *)sender {
    
    //我的订单
    if (sender.tag ==120) {
    
        GoodsListViewController *ctrl = [[GoodsListViewController alloc] initWithStyle:UITableViewStyleGrouped];
        UINavigationController *nav = [[UINavigationController alloc]
                                       initWithRootViewController:ctrl];
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"]forBarMetrics:UIBarMetricsDefault];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
     }else if (sender.tag ==121)//退出
    {
    
        _logoutViewController = [[LogoutViewController alloc] initWithNibName:@"LogoutViewController" bundle:nil];
        _logoutViewController.delegate = self;
        [self presentPopupViewController:_logoutViewController animationType:MJPopupViewAnimationFade];
    
    }
}

- (IBAction)detailViewBackMethod:(UIButton *)sender {
    [self dismissDetailView];
}

- (IBAction)refreshingButtonMethod:(UIButton *)sender {
    
    [self.orderListArray removeAllObjects];
    [self.orderTableView reloadData];
    self.currentClickProduct =nil;
    self.PriceLabel.text =[NSString stringWithFormat:@"￥%.0f",0.0];
    [self showButtomView];
    //删除数据库中的数据
    [[MySQLite shareSQLiteInstance]clearDataByTableName:@"ProductTable"];
    
    
}
- (void)cancelButtonClicked
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    _logoutViewController = nil;
}
- (void)cancelSuccess
{
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    self.confirmOrderVC= nil;
    
    if (is_detail) {
        
        [self dismissDetailView];
        
    }
    
    self.maskView = [[UIView alloc]init];
    self.maskView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.5;
    self.maskView.hidden = NO;
    self.maskView.userInteractionEnabled = YES;
    [self.view addSubview:self.maskView];
    
    self.successView.center = self.view.center;
    [self.view addSubview:self.successView];
    
    [self performSelector:@selector(dismissSuccessView) withObject:nil afterDelay:2];
 
}
- (void)dismissSuccessView
{
    if (self.maskView) {
        
        [self.maskView removeFromSuperview];
        self.maskView = nil;
    }
    [self.successView removeFromSuperview];
    
    self.clickDetailed = NO;
    self.clickDetailArray = [NSMutableArray array];
    
    
}


#pragma mark UISearchDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{

    [self search];
    [self.searchBar resignFirstResponder];
}
- (void)search
{
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"搜索数据中"];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, ProductCategoryList_URL];
    
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:self.categoryString forKey:@"catalogId"];
	[req setParam:@"1" forKey:@"pageIndex"];
	[req setParam:@"50" forKey:@"pageSize"];
    [req setParam:self.searchBar.text forKey:@"keyword"];
	[req setHTTPMethod:@"POST"];
	
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onCommendLoaded:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
}
- (void)onSearchLoaded:(NSNotification*)noti
{
    RRLoader *loader = (RRLoader *)[noti object];
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
	// fail
	if (![[json objectForKey:@"success"] boolValue])
	{
       // [SVProgressHUD dismissWithError:@"获取数据失败!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"获取数据失败!" duration:2 position:@"center"];
		return;
	}
    
    NSArray *arr = [[data objectForKey:@"list"] objectForKey:@"records"];
    if ([arr count] == 0) {
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"暂无数据!" duration:2 position:@"center"];
      //  [SVProgressHUD dismissWithError:@"暂无数据!"];
        return;
    }
    [SVProgressHUD dismiss];
    self.pageSize = [[data objectForKey:@"pageCount"]integerValue];
    self.pageIndex = [[data objectForKey:@"pageIndex"] integerValue]+1;
    
    [self.allProductArray removeAllObjects];
 

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)soonOrderMethod:(UIButton *)sender {
  
    
    
    if ([self.segmentControlType isEqualToString:@"hasdownList"]) {
        [self.view makeToast:@"该商品已经下单!" duration:1 position:@"center"];
        return;
    }
    if ([self.orderListArray count]==0) {
        [self.view makeToast:@"还没有选择数量!"];
        return;
    }
    
    
    self.confirmOrderVC = [[ConfirmOrderViewController alloc] initWithNibName:@"ConfirmOrderViewController" bundle:nil];
    self.confirmOrderVC.detailProduct = self.currentClickProduct;
    self.confirmOrderVC.delegate = self;
    self.confirmOrderVC.mySuperView = self.view;
    if (self.clickDetailed==YES) {
        [self.confirmOrderVC setUpBuffer:self.clickDetailArray];
      }else {
        [self.confirmOrderVC setUpBuffer:self.orderListArray];
      }
    [self presentPopupViewController:self.confirmOrderVC animationType:MJPopupViewAnimationFade];
}
- (IBAction)orderingButtonMethod:(UIButton *)sender {
    
    if ([self.segmentControlType isEqualToString:@"hasdownList"]) {
        [self.view makeToast:@"该商品已经下单!" duration:1 position:@"center"];
        return;
    }
    
    DetailProduct* product= [self.orderListArray objectAtIndex:0];
    self.confirmOrderVC = [[ConfirmOrderViewController alloc] initWithNibName:@"ConfirmOrderViewController" bundle:nil];
    if (self.currentClickProduct) {
        self.confirmOrderVC.detailProduct = self.currentClickProduct;
    
    }else {
        self.confirmOrderVC.detailProduct = product;

    }
    self.confirmOrderVC.delegate = self;
    self.confirmOrderVC.mySuperView = self.view;
    [self.confirmOrderVC setUpBuffer:self.orderListArray];
    [self presentPopupViewController:self.confirmOrderVC animationType:MJPopupViewAnimationFade];
    
}
//详情页面增加和减少按钮
- (IBAction)detailReduceMethod:(UIButton *)sender {
    
    if (sumPrice != 0) {
        sumPrice--;
        self.detailSumLable.text = [NSString stringWithFormat:@"%d",sumPrice];
    }else {
        return;
        
    }
    DetailProduct* detailProduct =[[DetailProduct alloc]init];
    NSString* detailId = [[self.detailProductDic objectForKey:@"FId"] lowercaseString];
    detailProduct.detailProductId = detailId;
    detailProduct.detailProductTitle= [self.detailProductDic objectForKey:@"FName"];
    detailProduct.priceNumber = [self.detailProductDic objectForKey:@"FUnitPrice"];
    detailProduct.fUnit = [self.detailProductDic objectForKey:@"FUnit"];
    detailProduct.clickCount= sumPrice;
    [self detailChangeProductNumber:detailProduct];
    
}
- (IBAction)detailAddMethod:(UIButton *)sender {
    
    sumPrice++;
    self.detailSumLable.text = [NSString stringWithFormat:@"%d",sumPrice];
    
    DetailProduct* detailProduct =[[DetailProduct alloc]init];
    NSString* detailId = [[self.detailProductDic objectForKey:@"FId"] lowercaseString];
    detailProduct.detailProductId = detailId;
    detailProduct.detailProductTitle= [self.detailProductDic objectForKey:@"FName"];
    detailProduct.priceNumber = [self.detailProductDic objectForKey:@"FUnitPrice"];
    detailProduct.fUnit = [self.detailProductDic objectForKey:@"FUnit"];
    detailProduct.clickCount= sumPrice;
    [self detailChangeProductNumber:detailProduct];
    
}
- (void)detailChangeProductNumber:(DetailProduct*)detailProduct
{
   

    BOOL is_contain = false;
    for (int i =0; i<self.orderListArray.count; i++) {
        
        DetailProduct* product = self.orderListArray[i];
        NSString* productID = [product.detailProductId lowercaseString];
       if ([productID isEqualToString:detailProduct.detailProductId]) {
            is_contain = YES;
            [self.orderListArray removeObjectAtIndex:i];
            
            if (detailProduct.clickCount > 0) {
                
                [self.orderListArray addObject:detailProduct];
                
                [[MySQLite shareSQLiteInstance]changeDataBaseColoumn:detailProduct tablename:@"ProductTable"];
            }
            
        }
    }
    if (!is_contain) {
        
        [self.orderListArray addObject:detailProduct];
         [[MySQLite shareSQLiteInstance]insertDataToSqlite:@"ProductTable" message:detailProduct];
        
    }
    
    [self.orderTableView reloadData];
    [self showButtomView];
 }

- (IBAction)closeButtonMethod:(UIButton *)sender {
    
    [self dismissSuccessView];
    
}
#pragma uitableview -edit
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self updateItemAtIndexPath:indexPath withString:nil];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
    
}
- (void) updateItemAtIndexPath:(NSIndexPath *)indexPath withString: (NSString *)string
{
     
    NSLog(@"%@",self.orderListArray);
    if ([self.segmentControlType isEqualToString:@"hasClicked"]) {
        if (self.orderListArray.count>0) {
            //删除从数据库中
            [[MySQLite shareSQLiteInstance]deleteProductFromDBase:self.orderListArray[indexPath.row]];
        }
    }

    [self.orderListArray removeObjectAtIndex:indexPath.row];
    [self.orderTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    float sum = 0.0;
    for (DetailProduct* product in self.orderListArray) {
        
        sum+=product.clickCount*[product.priceNumber integerValue];
        
    }
    self.PriceLabel.textColor =[UIColor colorWithRed:244.0/255 green:111.0/255 blue:34.0/255 alpha:1.0];
    self.PriceLabel.text =[NSString stringWithFormat:@"￥%.0f",sum];
    [self reload];
    
}
@end
