//
//  ConfirmOrderViewController.m
//  CRM
//
//  Created by 马峰 on 14-12-4.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "DropDownListView.h"
#import "CoustomNameCell.h"
#import "Toast+UIView.h"
#import "DetailProduct.h"
#import "OpenTableViewController.h"
#import "OrderSourceTableViewController.h"
#import "ServiceTypeTableViewController.h"
#import "ServiceContentTableViewController.h"
#import "iToast.h"
#import "JSONKit.h"
#import "SVProgressHUD.h"
#import "RRLoader.h"
#import "RRToken.h"
#import "RRURLRequest.h"
#import "NSObject+SBJson.h"
#import "ChoseAirportTableViewController.h"
#import "PackTableViewController.h"
#import "CoustomModel.h"
#import "UIScrollView+MJRefresh.h"
#import "MapPopupView.h"
#import "MySQLite.h"
#import "AppDelegate.h"
#import "DejalActivityView.h"
#import "PostTableViewController.h"
#import "StoreModel.h"
#import "StoreCell.h"
#import "ServicePostTableViewController.h"

#import "AirportModel.h"
#import "AirportCell.h"




@interface ConfirmOrderViewController ()<changeDataSourceDelegate,UISearchBarDelegate,UITextFieldDelegate,clickIndexPathRowDelegate,OrderResourceclickIndexPathRowDelegate,serviceTypeDelegate,UIPopoverControllerDelegate,serviceContentDelegate,ChoseAirportclickIndexPathRowDelegate,pageClickIndexPathRowDelegate,chosePostDelegate,choseServicePostDelegate>

@property(nonatomic,strong)MapPopupView *JiejipopupView;
@property(nonatomic,strong)MapPopupView *SongjipopupView;


@property(nonatomic,strong) NSMutableArray* companyArray;
@property(nonatomic,strong) NSMutableArray* bussinesArray;
@property(nonatomic,strong) NSMutableArray* coustomArray;
@property(nonatomic,assign) BOOL companyShow;
@property(nonatomic,assign) BOOL bussinessShow;
@property(nonatomic,strong)   DropDownListView * companydropDownView;
@property(nonatomic,strong)   DropDownListView * bussinessdropDownView;
@property(nonatomic,strong) UIPopoverController* popViewController;

@property(nonatomic,strong) NSString* companyId;
@property(nonatomic,strong) NSString* bussinessId;
@property(nonatomic,assign) BOOL showCoustomView;
@property(nonatomic,assign) BOOL hasFind;
@property(nonatomic,assign) BOOL hasScrolled;

@property(nonatomic,strong) NSMutableArray* coustomNameArray;
@property(nonatomic,strong) NSMutableArray* chectArray;
@property(nonatomic,strong) UILabel* priceLabel;
@property(nonatomic,assign) BOOL hasShowCoustomName;
@property(nonatomic,strong)    UILabel* countLabel;
@property(nonatomic,strong) NSMutableArray* nameArray;
@property(nonatomic,strong) NSMutableArray* containnameArray;



//服务商品
@property(nonatomic,assign) BOOL hasShowAirportName;
@property(nonatomic,strong) NSMutableArray* airportArray;
@property(nonatomic,strong) NSMutableArray* airportnameArray;
@property(nonatomic,strong) NSMutableArray* airportchectArray;
@property(nonatomic,assign) BOOL airportHasFind;
@property(nonatomic,strong) NSMutableArray* containAirportnameArray;





//门店
@property(nonatomic,assign) BOOL hasShowStore;
@property(nonatomic,strong) NSMutableArray* chectStoreArray;

@property(nonatomic,strong) NSMutableArray* storeArray;
@property(nonatomic,strong) NSMutableArray* storeNameArray;
@property(nonatomic,assign) NSInteger storePageIndex;
@property(nonatomic,assign) NSInteger storeTotalIndex;
@property(nonatomic,strong) NSMutableArray* containStorenameArray;

@property(nonatomic,assign) BOOL storeHasFind;
@property(nonatomic,assign) BOOL hasShowStoreView;
@property(nonatomic,strong) NSString* storeNameId;


@property(nonatomic,assign) BOOL openTicketRoulation;
@property(nonatomic,assign) BOOL orderResourceRoulation;
@property(nonatomic,assign) BOOL serviceTypeRoulation;
@property(nonatomic,assign) BOOL serviceNeirongRoulation;
@property(nonatomic,assign) BOOL starAirportRoulation;
@property(nonatomic,assign) BOOL arriveAirportRoulation;
@property(nonatomic,assign) BOOL packRoulation;

@property(nonatomic,assign) BOOL factPostRoulation;
@property(nonatomic,assign) BOOL servicePostRoulation;




@property(nonatomic,strong) UIPopoverController* orderResourcePopVC;
@property(nonatomic,strong) UIPopoverController* serviceTypePopVC;
@property(nonatomic,strong) UIPopoverController* serviceContentPopVC;
@property(nonatomic,strong) UIPopoverController* serviceOpenTicketPopVC;
@property(nonatomic,strong) UIPopoverController* choseStarAirportPopVC;
@property(nonatomic,strong) UIPopoverController* choseArriveAirportPopVC;
@property(nonatomic,strong) UIPopoverController* packPopVC;
@property(nonatomic,strong) UIPopoverController* timePopVC;



//实际商品
@property(nonatomic,strong) UIPopoverController* factPostPopVC;
@property(nonatomic,strong) NSString* factPostString;


@property(nonatomic,strong) UIPopoverController* servicePostPopVC;
@property(nonatomic,strong) NSString* servicePostString;


@property(nonatomic,strong) UITextField* saveTextFiled;
@property(nonatomic,strong) UIButton* orderButton;
@property(nonatomic,strong)  UIButton* cancelButton;

//实际商品
//订单来源选择的值
@property(nonatomic,strong) NSString* orderResourceString;
//是否开票
@property(nonatomic,strong) NSString* isOpenTicketstring;
//客户名称的id
@property(nonatomic,strong) NSString* coustomNameId;

//服务商品
//服务类型
@property(nonatomic,strong) NSString* serviceTypeString;
//服务内容
@property(nonatomic,strong) NSString* serviceContentString;

//机场选择
@property(nonatomic,strong) NSString* choseStarAirportString;
@property(nonatomic,strong) NSString* choseArriveAirportString;
@property(nonatomic,strong) NSString* packString;

@property(nonatomic,strong) NSString* choseAirportString;

@property(nonatomic,strong)  UIView* footView;

@property(nonatomic,assign) NSInteger pageIndex;
@property(nonatomic,assign) NSInteger totalIndex;
@property(nonatomic,assign) BOOL hasShowCoustomView;

//会员卡号
@property(nonatomic,strong) NSString* memberNumber;
@property(nonatomic,strong) NSString* type;
@property(nonatomic,strong) NSString* changType;
@property(nonatomic,strong) NSString* jiejiString;
@property(nonatomic,strong) NSString* songjiString;
@property(nonatomic,strong) NSString* jiOrSongType;


//
@property(nonatomic,assign) NSInteger airportPageIndex;
@property(nonatomic,assign) NSInteger airportTotalIndex;
@property(nonatomic,assign) BOOL hasShowAirportView;
@property(nonatomic,strong) NSString* airportNameId;


@property(nonatomic,strong) NSString* searchTypeString;




@end

@implementation ConfirmOrderViewController

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

    self.pageIndex = 1;
    self.storePageIndex =1;
    self.airportPageIndex =1;
    self.storeHasFind = NO;
    self.servicePostRoulation = NO;
    self.hasShowStoreView = NO;
    self.hasShowCoustomView = NO;
    self.hasShowAirportView = NO;
    self.openTicketRoulation = NO;
    self.orderResourceRoulation = NO;
    self.serviceTypeRoulation = NO;
    self.serviceNeirongRoulation = NO;
    self.starAirportRoulation = NO;
    self.arriveAirportRoulation = NO;
    self.factPostRoulation = NO;
    self.packRoulation =NO;
    self.airportHasFind=NO;
    self.sureButton.userInteractionEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUIKeyboardWillChangeFrameNotification:) name:UIKeyboardWillHideNotification object:nil];
    
    self.isOpenTicketstring = @"false";
    self.hasScrolled = NO;
    UIColor* color = UIColorFromRGB(106, 106, 106);
    self.zhekuTextField.placeholder = @"请输入";
    [self.zhekuTextField setValue:color forKeyPath:@"_placeholderLabel.textColor"];

    self.serviceZhekoTextField.placeholder = @"请输入";
    self.serviceZhekoTextField.text= @"1.0";
    self.zhekuTextField.text = @"1.0";
    [self.serviceZhekoTextField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
//    self.hangbanTextfield.placeholder = @"请输入";
//    [self.hangbanTextfield setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    self.jiejiTextField.placeholder = @"请输入";
    [self.jiejiTextField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    self.renshuTextFiled.placeholder = @"请输入";
    [self.renshuTextFiled setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    _songjiTextField.placeholder = @"请输入";
   [self.songjiTextField setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    
    
    self.confirmTableView.frame = CGRectMake(0.0, 64.0, self.view.frame.size.width, self.view.frame.size.height - 64.0-10);
    self.confirmTableView.separatorColor = [UIColor clearColor];
    self.confirmTableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    self.view.layer.cornerRadius = 8.0;
    self.containnameArray = [NSMutableArray array];
    self.nameArray = [NSMutableArray array];
    self.hasShowCoustomName = NO;
    self.hasShowStore = NO;
    self.hasShowAirportName = NO;
    self.headView.backgroundColor = UIColorFromRGB(249, 249, 249);
    self.coustomNameArray = [NSMutableArray array];
    self.chectArray = [NSMutableArray array];
    self.airportArray = [NSMutableArray array];
    self.airportnameArray = [NSMutableArray array];
    self.airportchectArray=[NSMutableArray array];
    self.containAirportnameArray=[NSMutableArray array];
    UIImage* backImage = [UIImage imageNamed:@"back.png"];
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(25.0, 25.0, 12, 20.0);

    [backButton setImage:backImage forState:UIControlStateNormal];
     backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backOrderMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.orderNameView addSubview:backButton];
    
    UIButton* backButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton1.frame = CGRectMake(25.0, 25.0, 12, 20.0);
    
    [backButton1 setImage:backImage forState:UIControlStateNormal];
    backButton1.backgroundColor = [UIColor clearColor];
    [backButton1 addTarget:self action:@selector(backOrderMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.storeView addSubview:backButton1];

    UIButton* backButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton2.frame = CGRectMake(25.0, 25.0, 12, 20.0);
    
    [backButton2 setImage:backImage forState:UIControlStateNormal];
    backButton2.backgroundColor = [UIColor clearColor];
    [backButton2 addTarget:self action:@selector(backOrderMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.airportView addSubview:backButton2];
    
    
    
    UIButton* backButtonOne = [UIButton buttonWithType:UIButtonTypeCustom];
    backButtonOne.frame = CGRectMake(CGRectGetMaxX(backButton.frame), 25.0, 40, 20.0);
    [backButtonOne setTitle:@"返回" forState:UIControlStateNormal];
    [backButtonOne setTitleColor:UIColorFromRGB(244.0, 111.0, 34.0) forState:UIControlStateNormal];
    backButtonOne.backgroundColor = [UIColor clearColor];
    [backButtonOne addTarget:self action:@selector(backOrderMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.orderNameView addSubview:backButtonOne];
    
    UIButton* backButtonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    backButtonTwo.frame = CGRectMake(CGRectGetMaxX(backButton.frame), 25.0, 40, 20.0);
    [backButtonTwo setTitle:@"返回" forState:UIControlStateNormal];
    [backButtonTwo setTitleColor:UIColorFromRGB(244.0, 111.0, 34.0) forState:UIControlStateNormal];
    backButtonTwo.backgroundColor = [UIColor clearColor];
    [backButtonTwo addTarget:self action:@selector(backOrderMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.storeView addSubview:backButtonTwo];

    UIButton* backButtonThree = [UIButton buttonWithType:UIButtonTypeCustom];
    backButtonThree.frame = CGRectMake(CGRectGetMaxX(backButton.frame), 25.0, 40, 20.0);
    [backButtonThree setTitle:@"返回" forState:UIControlStateNormal];
    [backButtonThree setTitleColor:UIColorFromRGB(244.0, 111.0, 34.0) forState:UIControlStateNormal];
    backButtonThree.backgroundColor = [UIColor clearColor];
    [backButtonThree addTarget:self action:@selector(backOrderMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.airportView addSubview:backButtonThree];
    
    
    
    [self.sureButton setTitleColor:UIColorFromRGB(244.0, 111.0, 34.0) forState:UIControlStateNormal];
    self.showCoustomView = NO;
    self.orderNameView.layer.cornerRadius = 8.0;
    self.companyShow = NO;
    self.bussinessShow = NO;
    self.headView.layer.cornerRadius = 8.0;
    
    self.containStorenameArray = [NSMutableArray array];
    self.coustomArray = [NSMutableArray array];
    self.companyArray = [NSMutableArray array];
    self.bussinesArray = [NSMutableArray array];
    self.storeNameArray = [NSMutableArray array];
    self.storeArray = [NSMutableArray array];
    self.chectStoreArray = [NSMutableArray array];
    


     self.footView = [[UIView alloc]init];
    self.footView.userInteractionEnabled = YES;
    _footView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 120);
    _footView.backgroundColor = [UIColor clearColor];

    
    UILabel* hejiLabel = [[UILabel alloc]init];
    hejiLabel.frame = CGRectMake(630.0, 10.0, 50.0, 30.0);
    hejiLabel.font = [UIFont systemFontOfSize:18.0];
    hejiLabel.textColor = [UIColor blackColor];
    hejiLabel.text = @"合计:";
    [_footView addSubview:hejiLabel];
    
    self.priceLabel = [[UILabel alloc]init];
    _priceLabel.frame = CGRectMake(CGRectGetMaxX(hejiLabel.frame), 10.0, 100.0, 30.0);
    _priceLabel.font = [UIFont systemFontOfSize:18.0];
    _priceLabel.textColor = [UIColor colorWithRed:244.0/255 green:111.0/255 blue:34.0/255 alpha:1.0];
    [_footView addSubview:_priceLabel];
    
    
    
    UIImage* orderImage = [UIImage imageNamed:@"ordering.png"];
    self.orderButton = [[UIButton alloc]init];
    self.orderButton.frame =CGRectMake((self.view.frame.size.width - orderImage.size.width/2.0*2)/3.0, 75.0, orderImage.size.width/2.0, orderImage.size.height/2.0);
   [self.orderButton setBackgroundImage:orderImage forState:UIControlStateNormal];
    [self.orderButton addTarget:self action:@selector(orderingMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.orderButton.userInteractionEnabled = YES;
    [_footView addSubview:self.orderButton];
    
    UIImage* cancelImage = [UIImage imageNamed:@"cancelorder.png"];
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame =CGRectMake(CGRectGetMaxX(self.orderButton.frame)+(self.view.frame.size.width - orderImage.size.width/2.0*2)/3.0, 75.0, orderImage.size.width/2.0, orderImage.size.height/2.0);
    [self.cancelButton setBackgroundImage:cancelImage forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelMethod:) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:self.cancelButton];
    
    self.confirmTableView.tableFooterView = _footView;
   
    if ([self.detailProduct.FMasterCatalogId  isEqual:ServiceGoodsID]) {
        
        self.confirmTableView.tableHeaderView = self.serviceTableHeadView;
        self.type = @"ServiceGoodsID";
        
        }else if ([self.detailProduct.FMasterCatalogId isEqualToString:EntityGoodsID] ||[self.detailProduct.FMasterCatalogId isEqual:SetmealGoodsID] ||[self.detailProduct.FMasterCatalogId isEqual:AllianceGoodsID]){
    
        self.confirmTableView.tableHeaderView = self.factTableHeadView;
        self.type = @"EntityGoodsID";

    }
    self.factTableHeadView.backgroundColor = UIColorFromRGB(241, 241, 241);
    self.serviceTableHeadView.backgroundColor = UIColorFromRGB(241, 241, 241);
    
    //设置footview-price
    [self refreshTableviewFootViewPrice];
    
    
    [self.openTicketButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
    [self.orderResourceButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
    [self.CoustomNameButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
    
    [self.serviceOpenticketButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
    [self.serviceOrderResourceButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
    [self.serviceCoustomNameButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
    [self.serviceTypeButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
    [self.serviceNeirongButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
    
     [self.starAirportButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
     [self.arrviveAirportButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
     [self.packButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
    [self.jiejiButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
    [self.songjiButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
    
    [self.resultButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
    [self.choseStoreButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
    [self.servicePostButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
    [self.serviceStoreButton setTitleColor:UIColorFromRGB(106, 106, 106) forState:UIControlStateNormal];
    
//    [self setCompanyDropListView];
//    [self setBussinesDropListView];
   
    WEAKSELF
    [self.orderNameTableView addFooterWithCallback:^{
        
        if (weakSelf.pageIndex <=weakSelf.totalIndex) {
            [weakSelf loadCoustomName];
            
        }else {
            
            [weakSelf.view makeToast:@"数据已经加载完" duration:1 position:@"center"];
            [weakSelf.orderNameTableView footerEndRefreshing];
        }
    }];
    
     [self.StoreTableView addFooterWithCallback:^{
        if (weakSelf.storePageIndex <=weakSelf.storeTotalIndex) {
            [weakSelf loadStoreName];
            
        }else {
            
            [weakSelf.view makeToast:@"数据已经加载完" duration:1 position:@"center"];
            [weakSelf.StoreTableView footerEndRefreshing];
        }
    }];
    
    
    [self.airportTableView addFooterWithCallback:^{
        if (weakSelf.airportPageIndex <=weakSelf.airportTotalIndex) {
            [weakSelf loadAirportName];
            
        }else {
            
            [weakSelf.view makeToast:@"数据已经加载完" duration:1 position:@"center"];
            [weakSelf.airportTableView footerEndRefreshing];
        }
    }];
    
    
    
    /*
    self.serviceTypeButton.userInteractionEnabled = YES;
    if ([self.detailProduct.FMasterCatalogId  isEqual:ServiceGoodsID]) {
        
    //对于服务商品，如果是接机或者送机商品，这需要自动适应按钮选择。
        NSRange range1= [self.detailProduct.detailProductTitle rangeOfString:@"接机"];
        NSRange range2= [self.detailProduct.detailProductTitle rangeOfString:@"送机"];
        NSRange range3= [self.detailProduct.detailProductTitle rangeOfString:@"接送机"];

        if (range1.length >0) {
            
            self.songjiButton.userInteractionEnabled = NO;
            [self.songjiButton setTitle:@"无" forState:UIControlStateNormal];
            self.starAirportImageView.hidden = YES;
            [self.starAirportButton setTitle:@"无" forState:UIControlStateNormal];
            self.starAirportButton.userInteractionEnabled = NO;
            
            
            self.jiejiButton.userInteractionEnabled = YES;
            [self.jiejiButton setTitle:@"请选择" forState:UIControlStateNormal];
            self.arriveAirportImageView.hidden = NO;
            [self.arrviveAirportButton setTitle:@"请选择" forState:UIControlStateNormal];
            self.arrviveAirportButton.userInteractionEnabled = YES;
            
            [self.serviceTypeButton setTitle:@"接机" forState:UIControlStateNormal];
            self.serviceTypeButton.userInteractionEnabled = NO;
            self.jiOrSongType = @"jieji";
            self.serviceTypeString = @"1";


        }
        if (range2.length>0) {
            
            self.jiejiButton.userInteractionEnabled = NO;
            [self.jiejiButton setTitle:@"无" forState:UIControlStateNormal];
            self.arriveAirportImageView.hidden = YES;
            [self.arrviveAirportButton setTitle:@"无" forState:UIControlStateNormal];
            self.arrviveAirportButton.userInteractionEnabled = NO;
            
            self.songjiButton.userInteractionEnabled = YES;
            [self.songjiButton setTitle:@"请选择" forState:UIControlStateNormal];
            self.starAirportImageView.hidden = NO;
            [self.starAirportButton setTitle:@"请选择" forState:UIControlStateNormal];
            self.starAirportButton.userInteractionEnabled = YES;
            
            
            [self.serviceTypeButton setTitle:@"送机" forState:UIControlStateNormal];
            self.serviceTypeButton.userInteractionEnabled = NO;
            self.jiOrSongType = @"songji";
            self.serviceTypeString = @"2";


            
        }
        if (range3.length>0) {
            
            self.jiejiButton.userInteractionEnabled = YES;
            [self.jiejiButton setTitle:@"请选择" forState:UIControlStateNormal];
            self.arriveAirportImageView.hidden = NO;
            [self.arrviveAirportButton setTitle:@"请选择" forState:UIControlStateNormal];
            self.arrviveAirportButton.userInteractionEnabled = YES;
            self.songjiButton.userInteractionEnabled = YES;
            [self.songjiButton setTitle:@"请选择" forState:UIControlStateNormal];
            self.starAirportImageView.hidden = NO;
            [self.starAirportButton setTitle:@"请选择" forState:UIControlStateNormal];
            self.starAirportButton.userInteractionEnabled = YES;
            
            [self.serviceTypeButton setTitle:@"接送机" forState:UIControlStateNormal];
            self.serviceTypeButton.userInteractionEnabled = NO;
            self.jiOrSongType = @"jiesongji";
            self.serviceTypeString = @"3";


        }
        
    }
     */
    
}
//下单和取消方法
- (void)orderingMethod:(UIButton*)bt
{

    if ([self.detailProduct.FMasterCatalogId isEqualToString:EntityGoodsID] ||[self.detailProduct.FMasterCatalogId isEqual:SetmealGoodsID] ||[self.detailProduct.FMasterCatalogId isEqual:AllianceGoodsID]) {
        
      NSMutableArray* listArray = [NSMutableArray array];
     for (DetailProduct* product in buffer) {
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];

        [dic setValue:product.detailProductId forKey:@"productId"];
        [dic setValue:[[NSNumber numberWithDouble:product.clickCount] stringValue] forKey:@"counts"];
        [listArray addObject:dic];
    }
    NSString* jsonString = [listArray JSONRepresentation];
    NSString* zhekoText = self.zhekuTextField.text;
    float percent = [zhekoText floatValue];

    if (!self.orderResourceString) {
        
        [self.view makeToast:@"请选择订单来源"];

        return;
    }
      
    if (!self.coustomNameId) {
        [self.view makeToast:@"请选择客户"];
       return;
    }
        if (!self.storeNameId) {
            [self.view makeToast:@"请选择门店"];
            return;
        }
        if (!self.factPostString) {
            [self.view makeToast:@"请选择结算方式"];
            return;
        }
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"订单提交中!"];
        [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
        RRToken *token = [RRToken getInstance];
        NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, SubmitProductOrderList_URL];
        RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
        [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
        [req setParam:@"GoodsOrder" forKey:@"type"];
        [req setParam:[[NSNumber numberWithFloat:percent] stringValue] forKey:@"discount"];
        [req setParam:self.isOpenTicketstring forKey:@"isInvoice"];
        [req setParam:self.orderResourceString forKey:@"source"];
        [req setParam:self.coustomNameId forKey:@"cusId"];
        [req setParam:@"" forKey:@"memberId"];
        [req setParam:jsonString forKey:@"datas"];
        [req setParam:self.factPostString forKey:@"post"];
        [req setParam:self.storeNameId forKey:@"store"];
         [req setHTTPMethod:@"POST"];
        
        RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
        [loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onSendOrder:)];
        [loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
        [loader loadwithTimer];
        
     }
  
    //提交服务商品订单
    if ([self.detailProduct.FMasterCatalogId  isEqual:ServiceGoodsID]) {
   
        NSMutableArray* listArray = [NSMutableArray array];
        for (DetailProduct* product in buffer) {
            NSMutableDictionary* dic = [NSMutableDictionary dictionary];
            
            [dic setValue:product.detailProductId forKey:@"productId"];
            [dic setValue:[[NSNumber numberWithDouble:product.clickCount] stringValue] forKey:@"counts"];
            [listArray addObject:dic];
        }
        NSString* jsonString = [listArray JSONRepresentation];
        NSString* zhekoText = self.serviceZhekoTextField.text;
        float percent = [zhekoText floatValue];

        if (!self.orderResourceString) {
            
            [self.view makeToast:@"请选择订单来源"];
            return;
        }
        if (!self.coustomNameId) {
            [self.view makeToast:@"请选择客户"];
            return;
        }
        if (!self.serviceTypeString) {
            
            [self.view makeToast:@"请选择服务类型"];
            return;
        }
        if ([self.hangbanTextfield.text length]==0 )
        {
            
            [self.view makeToast:@"请完善航班信息"];
               return;
        }
        
        if ([self.renshuTextFiled.text length]==0)
        {
            [self.view makeToast:@"请填写人数"];
            return;
        }

        if (!self.packString) {
            
            [self.view makeToast:@"请确定是否有行李"];
            return;
        }
        if ([self.jiOrSongType isEqualToString:@"jieji"]) {
            if (!self.choseAirportString) {
                [self.view makeToast:@"请选择机场"];
                return;
            }
            
        }else if ([self.jiOrSongType isEqualToString:@"songji"]){
            if (!self.choseAirportString) {
                [self.view makeToast:@"请选择机场"];
  
                return;
            }
        
        }else {
            if (!self.choseAirportString ||!self.choseAirportString) {
                [self.view makeToast:@"请选择机场"];
                  return;
            }
        
        }
        
        if ([self.jiOrSongType isEqualToString:@"jieji"]) {
             if (!self.choseAirportString ||!self.choseAirportString) {
                [self.view makeToast:@"请选择时间或机场!"];
 
                return;
            }
            
        }else if ([self.jiOrSongType isEqualToString:@"songji"]){
            
            if (!self.choseAirportString ||!self.choseAirportString) {
                [self.view makeToast:@"请选择时间或机场!"];

                return;
            }
        }else {
            
            if (!self.songjiString ||!self.choseAirportString ||!self.jiejiString ||!self.choseAirportString) {
                
                [self.view makeToast:@"请选择时间或机场!"];

                return;
            }
        }

        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"订单提交中!"];
        [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
        
        RRToken *token = [RRToken getInstance];
        NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, SubmitProductOrderList_URL];
        RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];

        if ([self.jiOrSongType isEqualToString:@"jieji"]) {
            
            [req setParam:self.jiejiString forKey:@"pickUpDate"];
            [req setParam:self.choseAirportString forKey:@"startAirport"];
            
        }else if ([self.jiOrSongType isEqualToString:@"songji"]){
            
            [req setParam:self.songjiString forKey:@"dropOffDate"];
            [req setParam:self.choseAirportString forKey:@"arriveAirport"];
            
        }
    
        
    
        [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
        [req setParam:@"ServerOrder" forKey:@"type"];
        [req setParam:[[NSNumber numberWithFloat:percent] stringValue] forKey:@"discount"];
        [req setParam:self.isOpenTicketstring forKey:@"isInvoice"];
        [req setParam:self.orderResourceString forKey:@"source"];
        [req setParam:self.coustomNameId forKey:@"cusId"];
        [req setParam:@"" forKey:@"memberId"];
        [req setParam:jsonString forKey:@"datas"];
        [req setParam:self.serviceTypeString forKey:@"serviceType"];
        [req setParam:self.hangbanTextfield.text forKey:@"flight"];
        [req setParam:self.packString forKey:@"hasPack"];
        [req setParam:self.renshuTextFiled.text forKey:@"amount"];
        [req setHTTPMethod:@"POST"];
        
        RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
        [loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onSendOrder:)];
        [loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
        [loader loadwithTimer];
    }
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
- (void) onSendOrder: (NSNotification *)notify
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
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:[[json objectForKey:@"data"] objectForKey:@"msg"] duration:2 position:@"center"];
       // [SVProgressHUD dismissWithError:[[json objectForKey:@"data"] objectForKey:@"msg"]];
		return;
	}
    
   // [SVProgressHUD dismiss];
    [DejalBezelActivityView removeViewAnimated:YES];
    [buffer removeAllObjects];
    //订单成功回调方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelSuccess)]) {
        
        [self.delegate cancelSuccess];
        //删除数据库中的数据
        [[MySQLite shareSQLiteInstance]clearDataByTableName:@"ProductTable"];
     }
}

- (void)cancelMethod:(UIButton*)bt
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelPopView)]) {
        
        [self.delegate cancelPopView];
        
    }
}
- (void)backOrderMethod:(UIButton*)bt
{
    if (self.hasShowAirportView) {
        [self hiddenAirportView];
        self.hasShowAirportName = NO;
        self.hasShowAirportView = NO;
        self.airportPageIndex =1;
    }
    if (self.hasShowCoustomView) {
        [self hiddenCoustomNameView];
        self.hasShowCoustomName = NO;
        self.hasShowCoustomView = NO;
        self.pageIndex =1;
        
    }
    if (self.hasShowStoreView) {
        [self hiddenStoreNameView];
        self.hasShowStore = NO;
        self.hasShowStoreView = NO;
        self.storePageIndex =1;
    }
    
  
}
- (void)setBussinesDropListView
{
    
    self.bussinessdropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(515,53,140, 40) dataSource:self delegate:self];
    self.bussinessdropDownView.dataSourceDelegate = self;
    self.bussinessdropDownView.mSuperView = self.view;
    self.bussinessdropDownView.type = KBusinessType;
    self.bussinessdropDownView.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:0.4f];
   // [self.orderHeadView addSubview:self.bussinessdropDownView];
}
- (void)setCompanyDropListView
{
  
     self.companydropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(63,174,140, 40) dataSource:self delegate:self];
      self.companydropDownView .dataSourceDelegate = self;
      self.companydropDownView .type = KCompanyType;
      self.companydropDownView .mSuperView = self.view;
      self.companydropDownView .backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:0.4f];
  //  [self.orderHeadView addSubview:self.companydropDownView ];
}
#pragma mark --dropdownList Delegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{

   if (self.DDtype ==KCompanychangeType) {
   
        self.companyId = [[self.companyArray objectAtIndex:index] objectForKey:@"companyId"];
       
    }else if (self.DDtype ==KBusinesschangeType){
    
        self.bussinessId = [[self.bussinesArray objectAtIndex:index] objectForKey:@"bussinesId"];
    }
 }
#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return 1;
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    if (self.companyShow) {
        
        return self.companyArray.count;
    } else if (self.bussinessShow){
    
        return self.bussinesArray.count;
        
    }
    return 1;
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    
    if (self.companyShow) {
        
        NSString *name = [[self.companyArray objectAtIndex:index] objectForKey:@"companyName"];
        return name;
        
    }else if (self.bussinessShow){
    
        
        NSString *name = [[self.bussinesArray objectAtIndex:index] objectForKey:@"bussinesName"];
        return name;
    
    }
    
    return nil;
   
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}
- (void)setDataSourceNotificationType:(KChangeType)type
{
    if (type ==KCompanyType) {
   
        self.companyShow = YES;
        self.bussinessShow = NO;
        self.DDtype = KCompanychangeType;
    }else if(type ==KBusinessType){
        self.companyShow = NO;
        self.bussinessShow = YES;
        self.DDtype = KBusinesschangeType;
        }

}
- (IBAction)jiejiButtonMethod:(id)sender {
    
    self.jiejiImageView.transform = CGAffineTransformRotate(self.jiejiImageView.transform, DEGREES_TO_RADIANS(180));
    [self.JiejipopupView removeFromSuperview];
    self.JiejipopupView = nil;
    [self showPopupView:2];
    
}

- (IBAction)songjiButtonMethod:(id)sender {
    
    self.songjiImageView.transform = CGAffineTransformRotate(self.songjiImageView.transform, DEGREES_TO_RADIANS(180));
    [self.SongjipopupView removeFromSuperview];
    self.SongjipopupView = nil;
    [self showSongjiPopupView:2];

}
- (IBAction)airportSureButtonMethod:(id)sender {
    
    if (self.airportchectArray.count <=0) {
        
        [self.view makeToast:@"您还没有选择机场?"];
        return;
    }
    NSIndexPath* indexPath = [self.airportchectArray lastObject];
    AirportModel* model = [self.airportArray objectAtIndex:indexPath.row];
    self.hangbanTextfield.text = model.fSerialNumber;
    NSString* name;
    NSDictionary* dic;
    
    if (self.airportHasFind ==YES) {
        dic = self.containAirportnameArray[indexPath.row];
        name = [dic objectForKey:@"FName"];
    }else {
        name = self.airportnameArray[indexPath.row];
    }
    if ([self.jiOrSongType isEqualToString:@"jieji"]) {
        
        [self.arrviveAirportButton setTitle:name forState:UIControlStateNormal];
        
      //  [self.starAirportButton setTitle:@"请输入" forState:UIControlStateNormal];

        
    }else if ([self.jiOrSongType isEqualToString:@"songji"]){
    
        [self.starAirportButton setTitle:name forState:UIControlStateNormal];

        
    }
    self.hasShowAirportName = NO;
    self.hasShowAirportView = NO;
    
    CGSize size = [name sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
    if ([self.jiOrSongType isEqualToString:@"jieji"]) {
        
        self.choseAirportString = name;
       [self.arrviveAirportButton setTitle:name forState:UIControlStateNormal];

        self.arrviveAirportButton.frame = CGRectMake(564, 212, size.width, 30);
        self.arriveAirportImageView.frame = CGRectMake(CGRectGetMaxX(self.arrviveAirportButton.frame)+4,  223, 14, 9);
        [UIView animateWithDuration:0.3 animations:^{
            
            self.arriveAirportImageView.transform = CGAffineTransformRotate(self.arriveAirportImageView.transform, DEGREES_TO_RADIANS(180));
            
            
        }];
        
    }else if([self.jiOrSongType isEqualToString:@"songji"]){
    
        self.choseAirportString = name;
        [self.starAirportButton setTitle:name forState:UIControlStateNormal];
      
        self.starAirportButton.frame = CGRectMake(140, 214, size.width, 30);
        self.starAirportImageView.frame = CGRectMake(CGRectGetMaxX(self.starAirportButton.frame)+4,  225, 14, 9);
        [UIView animateWithDuration:0.3 animations:^{
            
            self.starAirportImageView.transform = CGAffineTransformRotate(self.starAirportImageView.transform, DEGREES_TO_RADIANS(180));
            
            
        }];
 }
    if (self.airportHasFind) {
      
        self.airportNameId =[dic objectForKey:@"FId"];
        [self hiddenAirportView];
        
    }else {
        
        for (AirportModel* model in self.airportArray) {
            if ([model.fName isEqualToString:name]) {
                self.airportNameId =model.fId;
                [self hiddenAirportView];
                break;
            }
        }
    
    }
    
 
}

- (void)setUpBuffer:(NSMutableArray *)arrary
{
    
    buffer = [NSMutableArray arrayWithArray:arrary];
    [self refreshTableviewFootViewPrice];
}
- (void)refreshTableviewFootViewPrice
{
    if ([buffer count]) {
     self.confirmTableView.tableFooterView.hidden = NO;

        int sum = 0.0;
        for (DetailProduct* product in buffer) {
       
            id m = product.priceNumber;
            if (![m isKindOfClass:[NSNumber class]]) {
                
                float n = [m floatValue];
              m = [NSNumber numberWithFloat:n];

           }
            sum+=product.clickCount*[m integerValue];

       }
        _priceLabel.text = [NSString stringWithFormat:@"%d元",sum];
    } else {
    
       self.confirmTableView.tableFooterView.hidden = YES;
        _priceLabel.text = nil;
        
    }
}
//选择客户名称方法
- (IBAction)choseCoustomName:(UIButton *)sender {
    

    [self.zhekuTextField resignFirstResponder];
    [self.serviceZhekoTextField resignFirstResponder];
    [self.jiejiTextField resignFirstResponder];
    [self.songjiTextField resignFirstResponder];
    [self.renshuTextFiled resignFirstResponder];
    self.hasShowCoustomName = YES;
    
}
- (void)loadCoustomName
{
    
    NSLog(@"%d",self.pageIndex);
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"获取数据中"];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, CoustomName_URL];
    RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[[NSNumber numberWithInt:self.pageIndex] stringValue] forKey:@"pageIndex"];
    [req setParam:@"20" forKey:@"pageSize"];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setHTTPMethod:@"POST"];
    RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoadedCoustomName:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
}
- (void)onLoadedCoustomName:(NSNotification*)noti
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
     //   [SVProgressHUD dismissWithError:@"获取数据失败!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"获取数据失败!" duration:2 position:@"center"];
		return;
	}
    
    NSDictionary *Dic = [data objectForKey:@"list"];
    if ([Dic count] == 0) {
       // [SVProgressHUD dismissWithError:@"暂无数据!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"暂无数据!" duration:2 position:@"center"];
        return;
    }

   // [SVProgressHUD dismiss];
    [DejalBezelActivityView removeViewAnimated:YES];
    NSArray* listArr = [Dic objectForKey:@"records"];
    for (NSDictionary* smallDic in listArr) {
        CoustomModel* nameModel = [[CoustomModel alloc]init];
        nameModel.name = [smallDic objectForKey:@"FName"];
        nameModel.nameId = [smallDic objectForKey:@"FId"];
        nameModel.responsibleName = [smallDic objectForKey:@"FUser"];
        [self.coustomNameArray addObject:nameModel];
        [self.nameArray addObject: [smallDic objectForKey:@"FName"]];
        
    }
    self.pageIndex = [[Dic objectForKey:@"pageIndex"] integerValue]+1;
    self.totalIndex = [[Dic objectForKey:@"pageCount"] integerValue];
    [self showCoustomNameView];
    [self.orderNameTableView reloadData];
   [self.orderNameTableView footerEndRefreshing];
    
}
- (void)showCoustomNameView
{
    if (self.hasShowCoustomView ==NO) {
        self.hasShowCoustomView = YES;
        self.orderNameView.frame = CGRectMake(1030, 0, 770, 624);
        [self.view addSubview:self.orderNameView];
        [UIView beginAnimations:@"split" context:nil];
        [UIView setAnimationDuration:0.5];
        self.orderNameView.frame = CGRectMake(0, 0, 770, 624);
        [UIView commitAnimations];
    }
}
- (void)hiddenCoustomNameView
{
        [UIView beginAnimations:@"split" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(removeorderNameView)];
        self.orderNameView.frame = CGRectMake(1030, 0, 770, 624);
        [UIView commitAnimations];
    
    [self.nameArray removeAllObjects];
    [self.coustomArray removeAllObjects];
    [self.chectArray removeAllObjects];
    self.hasShowCoustomName = NO;
    self.hasFind = NO;
    self.pageIndex =1;
    
}
- (void)removeorderNameView
{
    [self.orderNameView removeFromSuperview];

}
- (IBAction)sureButtonMethod:(UIButton *)sender {
    
   if ([self.type isEqualToString:@"ServiceGoodsID"]) {
    
        self.membernumberTextfiled.text = self.memberNumber;
        
    }else if ([self.type isEqualToString:@"EntityGoodsID"]){
        self.factMembertextfield.text = self.memberNumber;

    }
    if (self.chectArray.count <=0) {
        
        [self.view makeToast:@"您还没有选择客户?"];
        return;
    }
    NSIndexPath* indexPath = self.chectArray[0];
    NSDictionary* dic;
    
    NSString* name;

    if (self.hasFind ==YES) {
        dic = self.containnameArray[indexPath.row];
        name = [dic objectForKey:@"FName"];

    }else {
        name = self.nameArray[indexPath.row];
    }
    
    CGSize size = [name sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
    CGRect rectone = self.CoustomNameButton.frame;
    rectone.size.width = size.width;
    self.CoustomNameButton.frame = rectone;
    
    CGRect recttwo = self.serviceCoustomNameButton.frame;
    recttwo.size.width = size.width;
    self.serviceCoustomNameButton.frame = recttwo;
    
    CGRect rectthree =self.serviceCoustomnameImageView.frame;
    rectthree.origin.x = CGRectGetMaxX(self.serviceCoustomNameButton.frame);
    self.serviceCoustomnameImageView.frame = rectthree;
    
    CGRect rectfour=self.factcoustomImageview.frame;
    rectfour.origin.x = CGRectGetMaxX(self.CoustomNameButton.frame);
    rectfour.origin.y+=1;
    self.factcoustomImageview.frame = rectfour;
    [self.CoustomNameButton setTitle:name forState:UIControlStateNormal];
    [self.serviceCoustomNameButton setTitle:name forState:UIControlStateNormal];
    self.hasShowCoustomName = NO;
    self.hasShowCoustomView = NO;
    self.hasShowAirportName=NO;
    self.hasShowAirportView = NO;
    self.hasShowStore = NO;
    self.hasShowStoreView = NO;
    
    if (self.hasFind) {
        self.coustomNameId =[dic objectForKey:@"FId"];
        [self hiddenCoustomNameView];
    }else {
        
        for (CoustomModel* model in self.coustomNameArray) {
            if ([model.name isEqualToString:name]) {
                self.coustomNameId =model.nameId;
                [self hiddenCoustomNameView];
                break;
            }
            
        }
    }
 
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.hasShowAirportName) {
        static  NSString  *CellIdentiferId = @"AirportCell";
        AirportCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
        if (cell == nil) {
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"AirportCell" owner:nil options:nil];
            cell = [nibs lastObject];
            cell.backgroundColor = [UIColor clearColor];
        };
        if ([self.airportchectArray containsObject:indexPath]) {
            
            UIImage* image = [UIImage imageNamed:@"mark.png"];
            cell.chectImageView.image= image;
            
        }else {
            cell.chectImageView.image = nil;
        }
        
        [cell setInfomationArray:self.airportArray indexPath:indexPath sting:@"allload"];
        
        if (self.airportHasFind) {
            
            [cell setInfomationArray:self.containAirportnameArray indexPath:indexPath sting:@"findString"];
            
        }
        return cell;
        
        
    }
    if (self.hasShowStore) {
        
        static  NSString  *CellIdentiferId = @"StoreCell";
        StoreCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
        if (cell == nil) {
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"StoreCell" owner:nil options:nil];
            cell = [nibs lastObject];
            cell.backgroundColor = [UIColor clearColor];
        };
        if ([self.chectStoreArray containsObject:indexPath]) {
            
            UIImage* image = [UIImage imageNamed:@"mark.png"];
            cell.checkImageView.image= image;
            
        }else {
            cell.checkImageView.image = nil;
        }
        
    [cell setInfomationArray:self.storeArray indexPath:indexPath sting:@"allload"];
        
        if (self.storeHasFind) {
            
            [cell setInfomationArray:self.containStorenameArray indexPath:indexPath sting:@"findString"];
            
        }
        return cell;
        
    }
    if (self.hasShowCoustomName) {
        static  NSString  *CellIdentiferId = @"CoustomNameCell";
        CoustomNameCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
        if (cell == nil) {
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"CoustomNameCell" owner:nil options:nil];
            cell = [nibs lastObject];
            cell.backgroundColor = [UIColor clearColor];
        };
        if ([self.chectArray containsObject:indexPath]) {
            
            UIImage* image = [UIImage imageNamed:@"mark.png"];
            cell.checkImageView.image= image;
            
        }else {
            cell.checkImageView.image = nil;
        }
        [cell setInfomationArray:self.coustomNameArray  indexPath:indexPath sting:@"allload"];

        if (self.hasFind) {
           
            [cell setInfomationArray:self.containnameArray  indexPath:indexPath sting:@"findString"];

        }
     return cell;
        
    }
   // static NSString *cell_id = @"empty_cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    DetailProduct* product = [buffer objectAtIndex:indexPath.row];
    self.countLabel = [[UILabel alloc]init];
    _countLabel.frame = CGRectMake(30.0, 10.0, 50.0, 30.0);
    _countLabel.font = [UIFont systemFontOfSize:18.0];
    _countLabel.textColor = [UIColor blackColor];
    if (indexPath.row<=8) {
        _countLabel.text = [NSString stringWithFormat:@"0%d.",indexPath.row+1];
   
    }else{
        _countLabel.text = [NSString stringWithFormat:@"%d.",indexPath.row+1];
     }
   
    [cell.contentView addSubview:_countLabel];
    

    UILabel* nameLabel = [[UILabel alloc]init];
    nameLabel.frame = CGRectMake(80.0, 10.0, 200.0, 30.0);
    nameLabel.font = [UIFont systemFontOfSize:18.0];
    nameLabel.textColor = [UIColor blackColor];
   
    nameLabel.text = product.detailProductTitle;
    [cell.contentView addSubview:nameLabel];

    UIFont *font = [UIFont systemFontOfSize:15.0f];
    cell.textLabel.font = font;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([cell.contentView viewWithTag:100+indexPath.row]) {
        [[cell.contentView viewWithTag:100+indexPath.row] removeFromSuperview];
    }
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(btn_add_click:) forControlEvents:UIControlEventTouchUpInside];
    [addButton setFrame:CGRectMake(415, 10, 33, 33)];
    addButton.tag =  100 + indexPath.row;
    [cell.contentView addSubview:addButton];
    
    if ([cell.contentView viewWithTag:200+indexPath.row]) {
        [[cell.contentView viewWithTag:200+indexPath.row] removeFromSuperview];
    }
    UIButton *reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [reduceButton setImage:[UIImage imageNamed:@"img11"] forState:UIControlStateNormal];
    [reduceButton addTarget:self action:@selector(btn_reduce_click:) forControlEvents:UIControlEventTouchUpInside];
    [reduceButton setFrame:CGRectMake(315,10, 33, 33)];
    reduceButton.tag =  200 + indexPath.row;
    [cell.contentView addSubview:reduceButton];
    
    if ([cell.contentView viewWithTag:300+indexPath.row]) {
        [[cell.contentView viewWithTag:300+indexPath.row] removeFromSuperview];
    }
    UIImageView *im_blank = [[UIImageView alloc]initWithFrame:CGRectMake(358, 13, 50, 28)];
    im_blank.image = [UIImage imageNamed:@"img13"];
    im_blank.tag = 300 + indexPath.row;
    [cell.contentView addSubview:im_blank];
    
    if ([cell.contentView viewWithTag:700+indexPath.row]) {
        [[cell.contentView viewWithTag:700+indexPath.row] removeFromSuperview];
    }
    UIImageView *im_line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 54,750,1)];
    im_line.image = [UIImage imageNamed:@"img32"];
    im_line.tag = 700 + indexPath.row;
    [cell.contentView addSubview:im_line];
    
    if ([cell.contentView viewWithTag:400+indexPath.row]) {
        [[cell.contentView viewWithTag:400+indexPath.row] removeFromSuperview];
    }
    UILabel *sumLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 28)];
    sumLable.textAlignment = NSTextAlignmentCenter;
    sumLable.backgroundColor = [UIColor clearColor];
    sumLable.textColor = [UIColor darkGrayColor];
    sumLable.font = [UIFont systemFontOfSize:12];
    sumLable.text = [NSString stringWithFormat:@"%d",product.clickCount];
    sumLable.tag = 400 + indexPath.row;
    [im_blank addSubview:sumLable];
    
    if ([cell.contentView viewWithTag:500+indexPath.row]) {
        [[cell.contentView viewWithTag:500+indexPath.row] removeFromSuperview];
    }
    UILabel *priceLable = [[UILabel alloc] initWithFrame:CGRectMake(548, 13, 80, 28)];
    priceLable.textAlignment = NSTextAlignmentCenter;
    priceLable.backgroundColor = [UIColor clearColor];
    priceLable.textColor = [UIColor blackColor];
    priceLable.tag = 500 + indexPath.row;
    priceLable.font = [UIFont systemFontOfSize:17];
    if ([product.priceNumber isKindOfClass:[NSString class]]) {
        priceLable.text = [@"￥"stringByAppendingString:product.priceNumber];
 
    }else {
     priceLable.text = [@"￥"stringByAppendingString:[product.priceNumber stringValue]];
    }
   
    [cell.contentView addSubview:priceLable];
    
    if ([cell.contentView viewWithTag:600+indexPath.row]) {
        [[cell.contentView viewWithTag:600+indexPath.row] removeFromSuperview];
    }
    UIButton *delButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [delButton setImage:[UIImage imageNamed:@"img22"] forState:UIControlStateNormal];
    [delButton addTarget:self action:@selector(btn_del_click:) forControlEvents:UIControlEventTouchUpInside];
    [delButton setFrame:CGRectMake(700, 12, 30, 30)];
    delButton.tag = 600 + indexPath.row;
    [cell.contentView addSubview:delButton];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.hasShowAirportName) {
        
        if (![self.airportchectArray containsObject:indexPath]) {
            
            if (self.airportchectArray.count> 0) {
                [self.airportchectArray removeAllObjects];
                [self.airportchectArray addObject:indexPath];
            }else {
                
                [self.airportchectArray addObject:indexPath];
            }
        }else {
            
            [self.airportchectArray removeObject:indexPath];
        }
        [self.airportTableView reloadData];
        
        return;
        
    }
    
    
    if (self.hasShowStore) {
     
        if (![self.chectStoreArray containsObject:indexPath]) {
            
            if (self.chectStoreArray.count> 0) {
                [self.chectStoreArray removeAllObjects];
                [self.chectStoreArray addObject:indexPath];
            }else {
                
                [self.chectStoreArray addObject:indexPath];
            }
        }else {
            
            [self.chectStoreArray removeObject:indexPath];
        }
        [self.StoreTableView reloadData];
        
        return;
        
    }

      if (self.hasShowCoustomName) {
        if (![self.chectArray containsObject:indexPath]) {
            
            if (self.chectArray.count> 0) {
                [self.chectArray removeAllObjects];
                [self.chectArray addObject:indexPath];
            }else {
                
                [self.chectArray addObject:indexPath];
            }
        }else {
            
            [self.chectArray removeObject:indexPath];
        }
        [self.orderNameTableView reloadData];
    }
    if ([buffer count] == 0) {
        return;
    }
    
    CoustomModel* model = self.coustomNameArray[indexPath.row];
    [self loadMemberNumber:model];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)loadMemberNumber:(CoustomModel*)model
{
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, CoustomMember_URL];
    RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[[NSNumber numberWithInt:self.pageIndex] stringValue] forKey:@"pageIndex"];
    [req setParam:@"20" forKey:@"pageSize"];
    [req setParam:model.nameId forKey:@"cusId"];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setHTTPMethod:@"POST"];
    RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
    [loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoadedCoustomMember:)];
    [loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
    [loader loadwithTimer];
}
- (void)onLoadedCoustomMember:(NSNotification*)noti
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
       // [SVProgressHUD dismissWithError:@"获取数据失败!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"获取数据失败!" duration:2 position:@"center"];
        return;
    }
    
    NSDictionary *Dic = [data objectForKey:@"list"];
    if ([Dic count] == 0) {
       // [SVProgressHUD dismissWithError:@"暂无数据!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"暂无数据!" duration:2 position:@"center"];
        return;
    }
    [SVProgressHUD dismiss];
    NSArray* recordsArray = [Dic objectForKey:@"records"];
    if (recordsArray.count==0) {
        
        self.memberNumber = nil;
      //  [self.view makeToast:@"暂无会员卡号!" duration:1 position:@"center"];
        return;
    }
    NSDictionary* smalldic = [recordsArray objectAtIndex:0];
    self.memberNumber = [smalldic objectForKey:@"FName"];
    if ([self.memberNumber length]>0) {
        
        self.sureButton.userInteractionEnabled = YES;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.hasShowAirportName) {
        
        if (self.airportHasFind) {
            
            return self.containAirportnameArray.count;
            
        }
        
        return self.airportArray.count;
        
    }
    if (self.hasShowCoustomName) {
        
        if (self.hasFind) {
            
            return self.containnameArray.count;
        }
        
        return self.coustomNameArray.count;
    }
    
    if (self.hasShowStore) {
        
        if (self.storeHasFind) {
            
            return self.containStorenameArray.count;
        }
        
        return self.storeArray.count;
        
        
    }
    
    
    return buffer.count;

}
- (void)btn_del_click:(UIButton*)bt
{
    NSUInteger index = [bt tag]%600;
     [buffer removeObjectAtIndex:index];
    [self.confirmTableView reloadData];
    [self refreshTableviewFootViewPrice];
}
- (void)btn_add_click:(UIButton*)bt
{
    NSUInteger index = [bt tag]%100;
    DetailProduct* product = [buffer objectAtIndex:index];
    NSInteger count = product.clickCount;
    count++;
    product.clickCount = count;
    [buffer removeObjectAtIndex:index];
    [buffer insertObject:product atIndex:index];
    [self.confirmTableView reloadData];
    [self refreshTableviewFootViewPrice];
    
}
- (void)btn_reduce_click:(UIButton*)bt
{
 
    NSUInteger index = [bt tag]%100;
    DetailProduct* product = [buffer objectAtIndex:index];
    NSInteger count = product.clickCount;
    count--;
    if (count ==0) {
      
        [buffer removeObjectAtIndex:index];

    }else {
    
        product.clickCount = count;
        [buffer removeObjectAtIndex:index];
        [buffer insertObject:product atIndex:index];
    }
 
    [self.confirmTableView reloadData];
    [self refreshTableviewFootViewPrice];
}
#pragma mark UISearchDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//是否开票
- (IBAction)openTicketMethod:(UIButton *)sender {
   
    [self.zhekuTextField resignFirstResponder];
    OpenTableViewController* openTableViewvc = [[OpenTableViewController alloc]init];
    openTableViewvc.contentSizeForViewInPopover = CGSizeMake(150, 80);
    openTableViewvc.clickDelegate = self;
   self.popViewController = [[UIPopoverController alloc]initWithContentViewController:openTableViewvc];
    self.popViewController.delegate =self;
    CGRect rect = self.openTicketButton.frame;
    rect.origin.y+=60.0;
    self.openTicketButton.frame = rect;
    [self.popViewController presentPopoverFromRect:self.openTicketButton.frame
                                            inView:self.view
                          permittedArrowDirections:UIPopoverArrowDirectionUp
                                          animated:YES];

    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (self.openTicketRoulation ==NO) {
            
            self.openTicketRoulation = YES;
            
            self.rouateImageView.transform = CGAffineTransformRotate(self.rouateImageView.transform, DEGREES_TO_RADIANS(180));
            
        }else {
            self.openTicketRoulation = YES;
            
            self.rouateImageView.transform = CGAffineTransformRotate(self.rouateImageView.transform, DEGREES_TO_RADIANS(180));
            
        }
        CGRect rect = self.openTicketButton.frame;
        rect.origin.y-=60.0;
        self.openTicketButton.frame = rect;
        
    }];
}
- (void)clickIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row ==0) {
        [self.openTicketButton setTitle:@"是" forState:UIControlStateNormal];
        [self.serviceOpenticketButton setTitle:@"是" forState:UIControlStateNormal];
        self.isOpenTicketstring = @"true";

    }else if (indexPath.row ==1){
        [self.openTicketButton setTitle:@"否" forState:UIControlStateNormal];
        [self.serviceOpenticketButton setTitle:@"否" forState:UIControlStateNormal];
        self.isOpenTicketstring = @"false";
    }
    
    if (self.serviceOpenTicketPopVC) {
        
        [self.serviceOpenTicketPopVC dismissPopoverAnimated:NO];
        
          self.serviceOpenTicketPopVC = nil;

    }
    if (self.popViewController) {
        
        [self.popViewController dismissPopoverAnimated:NO];
        
        self.popViewController = nil;
        
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{

      self.rouateImageView.transform = CGAffineTransformRotate(self.rouateImageView.transform, DEGREES_TO_RADIANS(180));
      self.serviceOpenImageView.transform = CGAffineTransformRotate(self.serviceOpenImageView.transform, DEGREES_TO_RADIANS(180));
        
    }];
    
    
}
//订单来源
- (IBAction)orderResourceMethod:(UIButton *)sender {
    
    [self.zhekuTextField resignFirstResponder];
    OrderSourceTableViewController* OrderTableViewvc = [[OrderSourceTableViewController alloc]init];
    OrderTableViewvc.contentSizeForViewInPopover = CGSizeMake(150, 240);
    OrderTableViewvc.orderDelegate = self;
    self.orderResourcePopVC = [[UIPopoverController alloc]initWithContentViewController:OrderTableViewvc];
    self.orderResourcePopVC.delegate = self;
    CGRect rect = self.orderResourceButton.frame;
    rect.origin.y+=60.0;
   self.orderResourceButton.frame = rect;
    [self.orderResourcePopVC presentPopoverFromRect:self.orderResourceButton.frame
                                            inView:self.view
                          permittedArrowDirections:UIPopoverArrowDirectionUp
                                          animated:YES];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (self.orderResourceRoulation ==NO) {
            
            self.orderResourceRoulation = YES;
            
            self.orderresourceImageView.transform = CGAffineTransformRotate(self.orderresourceImageView.transform, DEGREES_TO_RADIANS(180));
            
        }else {
            self.orderResourceRoulation = YES;
            
            self.orderresourceImageView.transform = CGAffineTransformRotate(self.orderresourceImageView.transform, DEGREES_TO_RADIANS(180));
            
        }
        CGRect rect = self.orderResourceButton.frame;
        rect.origin.y-=60.0;
        self.orderResourceButton.frame = rect;
        
    }];
    
}
- (void)OrderResourceclickIndexPath:(NSString*)string titleString:(NSString*)title
{
    
    self.orderResourceString = string;
    [self.orderResourceButton setTitle:title forState:UIControlStateNormal];
    [_serviceOrderResourceButton setTitle:title forState:UIControlStateNormal];
    
    
    if (self.orderResourcePopVC) {
        
        [self.orderResourcePopVC dismissPopoverAnimated:NO];
        self.orderResourcePopVC = nil;
        
    }
    [UIView animateWithDuration:0.3 animations:^{
        
        self.orderresourceImageView.transform = CGAffineTransformRotate(self.orderresourceImageView.transform, DEGREES_TO_RADIANS(180));
        self.serviceOrderImageView.transform = CGAffineTransformRotate(self.serviceOrderImageView.transform, DEGREES_TO_RADIANS(180));

    }];

}
//客户名称
- (IBAction)coustomNameMethod:(UIButton *)sender {
    
    [self.zhekuTextField resignFirstResponder];
     self.hasShowCoustomName = YES;
    [self loadCoustomName];
}

- (IBAction)serviceCoustomNameMethod:(id)sender {
    
    self.hasShowAirportName = NO;
    self.hasShowAirportView = NO;
    
    [self.serviceZhekoTextField resignFirstResponder];
     self.hasShowCoustomName = YES;
    [self loadCoustomName];
    
}
- (IBAction)backMethod:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelPopView)]) {
        
        [self.delegate cancelPopView];
    }
}
- (IBAction)serviceOpenTicketMethod:(UIButton *)sender {
    
    
    [self.serviceZhekoTextField resignFirstResponder];
    [self.jiejiTextField resignFirstResponder];
    [self.songjiTextField resignFirstResponder];
    [self.renshuTextFiled resignFirstResponder];
    
    OpenTableViewController* openTableViewvc = [[OpenTableViewController alloc]init];
    openTableViewvc.contentSizeForViewInPopover = CGSizeMake(150, 80);
    openTableViewvc.clickDelegate = self;
    self.serviceOpenTicketPopVC = [[UIPopoverController alloc]initWithContentViewController:openTableViewvc];
      self.serviceOpenTicketPopVC.delegate = self;
    CGRect rect = self.serviceOpenticketButton.frame;
    rect.origin.y+=60.0;
    self.serviceOpenticketButton.frame = rect;
    [self.serviceOpenTicketPopVC presentPopoverFromRect:self.serviceOpenticketButton.frame
                                            inView:self.view
                          permittedArrowDirections:UIPopoverArrowDirectionUp
                                          animated:YES];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (self.openTicketRoulation ==NO) {
            
            self.openTicketRoulation = YES;
            
            self.serviceOpenImageView.transform = CGAffineTransformRotate(self.serviceOpenImageView.transform, DEGREES_TO_RADIANS(180));
            
        }else {
            self.openTicketRoulation = YES;
            
            self.serviceOpenImageView.transform = CGAffineTransformRotate(self.serviceOpenImageView.transform, DEGREES_TO_RADIANS(180));
            
        }
        CGRect rect = self.serviceOpenticketButton.frame;
        rect.origin.y-=60.0;
        self.serviceOpenticketButton.frame = rect;
        
    }];

}
- (IBAction)serviceResourceMethod:(UIButton *)sender {
    
    
    [self.serviceZhekoTextField resignFirstResponder];
    [self.jiejiTextField resignFirstResponder];
    [self.songjiTextField resignFirstResponder];
    [self.renshuTextFiled resignFirstResponder];
    OrderSourceTableViewController* OrderTableViewvc = [[OrderSourceTableViewController alloc]init];
    OrderTableViewvc.contentSizeForViewInPopover = CGSizeMake(150, 240);
    OrderTableViewvc.orderDelegate = self;
    self.orderResourcePopVC = [[UIPopoverController alloc]initWithContentViewController:OrderTableViewvc];
    self.orderResourcePopVC.delegate = self;
    CGRect rect = self.serviceOrderResourceButton.frame;
    rect.origin.y+=60.0;
    self.serviceOrderResourceButton.frame = rect;
    [self.orderResourcePopVC presentPopoverFromRect:self.serviceOrderResourceButton.frame
                                             inView:self.view
                           permittedArrowDirections:UIPopoverArrowDirectionUp
                                           animated:YES];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (self.orderResourceRoulation ==NO) {
            
            self.orderResourceRoulation = YES;
            
            self.serviceOrderImageView.transform = CGAffineTransformRotate(self.serviceOrderImageView.transform, DEGREES_TO_RADIANS(180));
            
        }else {
            self.orderResourceRoulation = YES;
            
            self.serviceOrderImageView.transform = CGAffineTransformRotate(self.serviceOrderImageView.transform, DEGREES_TO_RADIANS(180));
            
        }
        CGRect rect = self.serviceOrderResourceButton.frame;
        rect.origin.y-=60.0;
        self.serviceOrderResourceButton.frame = rect;
        
    }];
}



- (IBAction)serviceTypeMethod:(id)sender {

    [self.serviceZhekoTextField resignFirstResponder];
    [self.jiejiTextField resignFirstResponder];
    [self.songjiTextField resignFirstResponder];
    [self.renshuTextFiled resignFirstResponder];
    
    ServiceTypeTableViewController* OrderTableViewvc = [[ServiceTypeTableViewController alloc]init];
    OrderTableViewvc.contentSizeForViewInPopover = CGSizeMake(150, 120);
    OrderTableViewvc.servicetypeDelegate = self;
    self.serviceTypePopVC = [[UIPopoverController alloc]initWithContentViewController:OrderTableViewvc];
    self.serviceTypePopVC.delegate = self;
    CGRect rect = self.serviceTypeButton.frame;
    rect.origin.y+=60.0;
    self.serviceTypeButton.frame = rect;
    [self.serviceTypePopVC presentPopoverFromRect:self.serviceTypeButton.frame
                                             inView:self.view
                           permittedArrowDirections:UIPopoverArrowDirectionUp
                                           animated:YES];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (self.serviceTypeRoulation ==NO) {
            
            self.serviceTypeRoulation = YES;
            
            self.serviceTypeImageView.transform = CGAffineTransformRotate(self.serviceTypeImageView.transform, DEGREES_TO_RADIANS(180));
            
        }else {
            self.serviceTypeRoulation = YES;
            
            self.serviceTypeImageView.transform = CGAffineTransformRotate(self.serviceTypeImageView.transform, DEGREES_TO_RADIANS(180));
            
        }
        CGRect rect = self.serviceTypeButton.frame;
        rect.origin.y-=60.0;
        self.serviceTypeButton.frame = rect;
        
    }];
}
- (void)choseTypeDelegate:(NSIndexPath*)indexPath
{
    NSString* selectRow = [NSString stringWithFormat:@"%d",indexPath.row+1];
    self.serviceTypeString = selectRow;
  
    NSString* title =nil;
    if (indexPath.row==0) {
      title = @"接机";
        
      self.jiOrSongType = @"jieji";
        
    }else if (indexPath.row ==1){
        title = @"送机";
        self.jiOrSongType = @"songji";

    }else if(indexPath.row ==2){
        title = @"订餐预约";
        self.jiOrSongType = @"dingcan";
      
   }else if(indexPath.row ==3)
   {
       self.jiOrSongType = @"huiyi";

       title = @"会议预约";

   }
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
    CGRect rect = self.serviceTypeButton.frame;
    //rect.origin.x+=4;
    rect.size.width = size.width;
    self.serviceTypeButton.frame = rect;
    
    CGRect rectOne = self.serviceTypeImageView.frame;
    rectOne.origin.x= CGRectGetMaxX(self.serviceTypeButton.frame)+2;
    self.serviceTypeImageView.frame = rectOne;
    
    
   [self.serviceTypeButton setTitle:title forState:UIControlStateNormal];
    
    if (self.serviceTypePopVC) {
        [self.serviceTypePopVC dismissPopoverAnimated:NO];
        self.serviceTypePopVC = nil;
    }
    [UIView animateWithDuration:0.3 animations:^{
        
        self.serviceTypeImageView.transform = CGAffineTransformRotate(self.serviceTypeImageView.transform, DEGREES_TO_RADIANS(180));
    }];
    if ([title isEqualToString:@"接机"]) {
    
    
        self.songjiButton.userInteractionEnabled = NO;
        [self.songjiButton setTitle:@"无" forState:UIControlStateNormal];
        self.starAirportImageView.hidden = YES;
        [self.starAirportButton setTitle:@"无" forState:UIControlStateNormal];
        self.starAirportButton.userInteractionEnabled = NO;
        
        
        self.jiejiButton.userInteractionEnabled = YES;
        [self.jiejiButton setTitle:@"请选择" forState:UIControlStateNormal];
        self.arriveAirportImageView.hidden = NO;
        [self.arrviveAirportButton setTitle:@"请选择" forState:UIControlStateNormal];
        self.arrviveAirportButton.userInteractionEnabled = YES;
        
        self.songjiImageView.hidden = YES;
        self.jiejiImageView.hidden = NO;
        
        
        
    }else if ([title isEqualToString:@"送机"]){
    
        self.jiejiButton.userInteractionEnabled = NO;
        [self.jiejiButton setTitle:@"无" forState:UIControlStateNormal];
        self.arriveAirportImageView.hidden = YES;
        [self.arrviveAirportButton setTitle:@"无" forState:UIControlStateNormal];
        self.arrviveAirportButton.userInteractionEnabled = NO;
        
        
        
        self.songjiButton.userInteractionEnabled = YES;
        [self.songjiButton setTitle:@"请选择" forState:UIControlStateNormal];
        self.starAirportImageView.hidden = NO;
        [self.starAirportButton setTitle:@"请选择" forState:UIControlStateNormal];
        self.starAirportButton.userInteractionEnabled = YES;
        
        self.songjiImageView.hidden = NO;
        self.jiejiImageView.hidden = YES;
        
    }else {
    
        
        self.jiejiButton.userInteractionEnabled = NO;
        [self.jiejiButton setTitle:@"无" forState:UIControlStateNormal];
        self.arriveAirportImageView.hidden = YES;
        [self.arrviveAirportButton setTitle:@"无" forState:UIControlStateNormal];
        self.arrviveAirportButton.userInteractionEnabled = NO;
        
        self.songjiButton.userInteractionEnabled = NO;
        [self.songjiButton setTitle:@"无" forState:UIControlStateNormal];
        self.starAirportImageView.hidden = YES;
        [self.starAirportButton setTitle:@"无" forState:UIControlStateNormal];
        self.starAirportButton.userInteractionEnabled = NO;
        
        self.jiejiImageView.hidden = YES;
        self.songjiImageView.hidden = YES;
    }
}
- (IBAction)serviceNeirongMethod:(id)sender {
    
    [self.serviceZhekoTextField resignFirstResponder];
    [self.jiejiTextField resignFirstResponder];
    [self.songjiTextField resignFirstResponder];
    [self.renshuTextFiled resignFirstResponder];
    ServiceContentTableViewController* OrderTableViewvc = [[ServiceContentTableViewController alloc]init];
    OrderTableViewvc.contentSizeForViewInPopover = CGSizeMake(200, 200);
    OrderTableViewvc.choseContentsDelegate = self;
    self.serviceContentPopVC = [[UIPopoverController alloc]initWithContentViewController:OrderTableViewvc];
    self.serviceContentPopVC.delegate = self;
    CGRect rect = self.serviceNeirongButton.frame;
    rect.origin.y+=60.0;
    self.serviceNeirongButton.frame = rect;
    [self.serviceContentPopVC presentPopoverFromRect:self.serviceNeirongButton.frame
                                           inView:self.view
                         permittedArrowDirections:UIPopoverArrowDirectionUp
                                         animated:YES];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (self.serviceNeirongRoulation ==NO) {
            
            self.serviceNeirongRoulation = YES;
            
            self.serviceNeirongImageView.transform = CGAffineTransformRotate(self.serviceNeirongImageView.transform, DEGREES_TO_RADIANS(180));
            
        }else {
            self.serviceNeirongRoulation = YES;
            
            self.serviceNeirongImageView.transform = CGAffineTransformRotate(self.serviceNeirongImageView.transform, DEGREES_TO_RADIANS(180));
            
        }
        CGRect rect = self.serviceNeirongButton.frame;
        rect.origin.y-=60.0;
        self.serviceNeirongButton.frame = rect;
        
    }];
 }
- (void)loadAirportName
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"获取数据中"];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, AirportName_URL];
    RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[[NSNumber numberWithInt:self.airportPageIndex] stringValue] forKey:@"pageIndex"];
    [req setParam:@"20" forKey:@"pageSize"];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setHTTPMethod:@"POST"];
    RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
    [loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoadedAirportName:)];
    [loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
    [loader loadwithTimer];
    
}
- (void)onLoadedAirportName:(NSNotification*)noti
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
        //   [SVProgressHUD dismissWithError:@"获取数据失败!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"获取数据失败!" duration:2 position:@"center"];
        return;
    }
    [DejalBezelActivityView removeViewAnimated:YES];
     NSArray* listArr = [[data objectForKey:@"list"] objectForKey:@"records"];
    for (NSDictionary* smallDic in listArr) {
        
        AirportModel* nameModel = [[AirportModel alloc]init];
        nameModel.fId = [smallDic objectForKey:@"FId"];
        nameModel.fName = [smallDic objectForKey:@"FName"];
        nameModel.fSerialNumber = [smallDic objectForKey:@"FSerialNumber"];
        [self.airportArray addObject:nameModel];
        [self.airportnameArray addObject: [smallDic objectForKey:@"FName"]];
    }
    self.airportPageIndex = [[[data objectForKey:@"list"] objectForKey:@"pageIndex"] integerValue]+1;
    self.airportTotalIndex = [[[data objectForKey:@"list"] objectForKey:@"pageCount"] integerValue];
    [self.airportTableView reloadData];
    [self showAirportView];
    [self.airportTableView footerEndRefreshing];
    NSLog(@"%@",self.airportArray);
    
}
- (void)showAirportView
{
    if (self.hasShowAirportView ==NO) {
        self.hasShowAirportView = YES;
        self.airportView.frame = CGRectMake(1030, 0, 770, 624);
        [self.view addSubview:self.airportView];
        [UIView beginAnimations:@"split" context:nil];
        [UIView setAnimationDuration:0.5];
        self.airportView.frame = CGRectMake(0, 0, 770, 624);
        [UIView commitAnimations];
    }

}

- (void)hiddenAirportView
{
    [UIView beginAnimations:@"split" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeorderNameView)];
    self.airportView.frame = CGRectMake(1030, 0, 770, 624);
    [UIView commitAnimations];
    [self.airportArray removeAllObjects];
    [self.airportnameArray removeAllObjects];
    [self.airportchectArray removeAllObjects];
    self.hasShowAirportView = NO;
    self.airportHasFind = NO;
    self.airportPageIndex =1;
    
}
- (void)removeAirportView
{
    [self.airportView removeFromSuperview];
    
}
- (IBAction)StarAirportMethod:(id)sender {
    
    [self.serviceZhekoTextField resignFirstResponder];
     self.hasShowAirportName = YES;
    [self loadAirportName];
    self.starAirportImageView.transform = CGAffineTransformRotate(self.starAirportImageView.transform, DEGREES_TO_RADIANS(180));
    
    
    return;
    [UIView animateWithDuration:0.3 animations:^{
        
        if (self.starAirportRoulation ==NO) {
            
            self.starAirportRoulation = YES;
            
            self.starAirportImageView.transform = CGAffineTransformRotate(self.starAirportImageView.transform, DEGREES_TO_RADIANS(180));
            
        }else {
            self.starAirportRoulation = YES;
            
            self.starAirportImageView.transform = CGAffineTransformRotate(self.starAirportImageView.transform, DEGREES_TO_RADIANS(180));
            
        }
        CGRect rect = self.starAirportButton.frame;
        rect.origin.y-=60.0;
        self.starAirportButton.frame = rect;
        
    }];
}
- (void)ChoseAirportclickIndexPath:(NSString*)string titleString:(NSString*)title type:(NSString*)airportType
{
   //frame
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
    if ([airportType isEqualToString:@"starAirport"]) {
        self.choseStarAirportString = string;
        self.starAirportButton.frame = CGRectMake(140, 214, size.width, 30);
        self.starAirportImageView.frame = CGRectMake(CGRectGetMaxX(self.starAirportButton.frame)+4,  225, 14, 9);
        [self.starAirportButton setTitle:title forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            
            self.starAirportImageView.transform = CGAffineTransformRotate(self.starAirportImageView.transform, DEGREES_TO_RADIANS(180));
            
            
        }];


    }else if ([airportType isEqualToString:@"arriveAirport"]){
        self.choseArriveAirportString = string;
        self.arrviveAirportButton.frame = CGRectMake(564, 212, size.width, 30);
        self.arriveAirportImageView.frame = CGRectMake(CGRectGetMaxX(self.arrviveAirportButton.frame)+4,  223, 14, 9);
        [self.arrviveAirportButton setTitle:title forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            
            self.arriveAirportImageView.transform = CGAffineTransformRotate(self.arriveAirportImageView.transform, DEGREES_TO_RADIANS(180));
            
            
        }];

    }
    if (self.choseStarAirportPopVC) {
        
        [self.choseStarAirportPopVC dismissPopoverAnimated:NO];
        self.choseStarAirportPopVC = nil;
    }
    if (self.choseArriveAirportPopVC) {
        
        [self.choseArriveAirportPopVC dismissPopoverAnimated:NO];
        self.choseArriveAirportPopVC = nil;
    }
   
}
- (IBAction)ArrviveAirport:(id)sender {
    
    [self.serviceZhekoTextField resignFirstResponder];
    self.hasShowAirportName = YES;
    [self loadAirportName];
    self.arriveAirportImageView.transform = CGAffineTransformRotate(self.arriveAirportImageView.transform, DEGREES_TO_RADIANS(180));
    return;
    [UIView animateWithDuration:0.3 animations:^{
        
        if (self.arriveAirportRoulation ==NO) {
            
            self.arriveAirportRoulation = YES;
            
            self.arriveAirportImageView.transform = CGAffineTransformRotate(self.arriveAirportImageView.transform, DEGREES_TO_RADIANS(180));
            
        }else {
            self.arriveAirportRoulation = YES;
            
            self.arriveAirportImageView.transform = CGAffineTransformRotate(self.arriveAirportImageView.transform, DEGREES_TO_RADIANS(180));
            
        }
        CGRect rect = self.arrviveAirportButton.frame;
        rect.origin.y-=60.0;
        self.arrviveAirportButton.frame = rect;
        
    }];

    
}

- (IBAction)packButtonMethod:(id)sender {
    
    [self.zhekuTextField resignFirstResponder];
    PackTableViewController* openTableViewvc = [[PackTableViewController alloc]init];
    openTableViewvc.contentSizeForViewInPopover = CGSizeMake(150, 80);
    openTableViewvc.pageClickDelegate = self;
    self.packPopVC = [[UIPopoverController alloc]initWithContentViewController:openTableViewvc];
    self.packPopVC.delegate =self;
    CGRect rect = self.packButton.frame;
    rect.origin.y+=60.0;
    self.packButton.frame = rect;
    [self.packPopVC presentPopoverFromRect:self.packButton.frame
                                            inView:self.view
                          permittedArrowDirections:UIPopoverArrowDirectionUp
                                          animated:YES];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (self.packRoulation ==NO) {
            
            self.packRoulation = YES;
            
            self.packImageView.transform = CGAffineTransformRotate(self.packImageView.transform, DEGREES_TO_RADIANS(180));
            
        }else {
            self.packRoulation = YES;
            
            self.packImageView.transform = CGAffineTransformRotate(self.packImageView.transform, DEGREES_TO_RADIANS(180));
            
        }
        CGRect rect = self.packButton.frame;
        rect.origin.y-=60.0;
        self.packButton.frame = rect;
        
    }];
}
- (void)pageclickIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row ==0) {
        [self.packButton setTitle:@"有" forState:UIControlStateNormal];
        self.packString = @"true";
        
    }else if (indexPath.row ==1){
        [self.packButton setTitle:@"无" forState:UIControlStateNormal];
        self.packString = @"false";
    }
    
    if (self.packPopVC) {
        
        [self.packPopVC dismissPopoverAnimated:NO];
        
        self.packPopVC = nil;
        
    }
   
    [UIView animateWithDuration:0.3 animations:^{
        
        self.packImageView.transform = CGAffineTransformRotate(self.packImageView.transform, DEGREES_TO_RADIANS(180));
   
        
    }];
}
- (void)choseContentDelegate:(NSIndexPath*)indexPath title:(NSString*)title
{
     return;
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
    self.serviceNeirongButton.frame = CGRectMake(145, 286, size.width, 30);
        self.serviceNeirongImageView.frame = CGRectMake(CGRectGetMaxX(self.serviceNeirongButton.frame)+4,  297, 14, 9);
    NSString* selectRow = [NSString stringWithFormat:@"%d",indexPath.row+1];
    self.serviceContentString = selectRow;
    [self.serviceNeirongButton setTitle:title forState:UIControlStateNormal];
    
    if (self.serviceContentPopVC) {
        
        [self.serviceContentPopVC dismissPopoverAnimated:NO];
        self.serviceContentPopVC = nil;
    }
    [UIView animateWithDuration:0.3 animations:^{
        
        self.serviceNeirongImageView.transform = CGAffineTransformRotate(self.serviceNeirongImageView.transform, DEGREES_TO_RADIANS(180));
     
        
    }];
}
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    
    if (self.serviceContentPopVC) {
        
        [self.serviceContentPopVC dismissPopoverAnimated:NO];
        self.serviceContentPopVC = nil;
        self.serviceNeirongImageView.transform = CGAffineTransformRotate(self.serviceNeirongImageView.transform, DEGREES_TO_RADIANS(180));
        
    }
    if (self.serviceTypePopVC) {
        
        [self.serviceTypePopVC dismissPopoverAnimated:NO];
        self.serviceTypePopVC = nil;
      self.serviceTypeImageView.transform = CGAffineTransformRotate(self.serviceTypeImageView.transform, DEGREES_TO_RADIANS(180));
    }
    if (self.orderResourcePopVC) {
        
        [self.orderResourcePopVC dismissPopoverAnimated:NO];
        self.orderResourcePopVC = nil;
      self.orderresourceImageView.transform = CGAffineTransformRotate(self.orderresourceImageView.transform, DEGREES_TO_RADIANS(180));
        self.serviceOrderImageView.transform = CGAffineTransformRotate(self.serviceOrderImageView.transform, DEGREES_TO_RADIANS(180));
        
    }
    if (self.popViewController) {
        
        [self.popViewController dismissPopoverAnimated:NO];
        self.popViewController = nil;
    self.rouateImageView.transform = CGAffineTransformRotate(self.rouateImageView.transform, DEGREES_TO_RADIANS(180));
        
    }
    if (self.serviceOpenTicketPopVC) {
        
        [self.serviceOpenTicketPopVC dismissPopoverAnimated:NO];
        self.serviceOpenTicketPopVC = nil;
          self.serviceOpenImageView.transform = CGAffineTransformRotate(self.serviceOpenImageView.transform, DEGREES_TO_RADIANS(180));
        
    }
    if (self.choseArriveAirportPopVC) {
        
        [self.choseArriveAirportPopVC dismissPopoverAnimated:NO];
        self.choseArriveAirportPopVC = nil;
        self.arriveAirportImageView.transform = CGAffineTransformRotate(self.arriveAirportImageView.transform, DEGREES_TO_RADIANS(180));
    }
    if (self.choseStarAirportPopVC) {
        [self.choseStarAirportPopVC dismissPopoverAnimated:NO];
        self.choseStarAirportPopVC = nil;
        self.starAirportImageView.transform = CGAffineTransformRotate(self.starAirportImageView.transform, DEGREES_TO_RADIANS(180));
    }
    if (self.packPopVC) {
        [self.packPopVC dismissPopoverAnimated:NO];
        self.packPopVC = nil;
        self.packImageView.transform = CGAffineTransformRotate(self.packImageView.transform, DEGREES_TO_RADIANS(180));
    }
    
    if (self.factPostPopVC) {
        
        [self.factPostPopVC dismissPopoverAnimated:NO];
        self.factPostPopVC = nil;
        self.resultImageView.transform = CGAffineTransformRotate(self.resultImageView.transform, DEGREES_TO_RADIANS(180));
    }
    if (self.servicePostPopVC) {
        
        [self.servicePostPopVC dismissPopoverAnimated:NO];
        self.servicePostPopVC = nil;
        self.serviceImageView.transform = CGAffineTransformRotate(self.serviceImageView.transform, DEGREES_TO_RADIANS(180));
    }
    
    
}
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    if (textField !=self.zhekuTextField && textField!=self.serviceZhekoTextField && textField !=self.hangbanTextfield) {
        
        self.saveTextFiled = textField;

      [UIView animateWithDuration:0.25 animations:^{
      
          if (self.hasScrolled==NO) {
              
              CGRect rectone =self.view.frame;
              rectone.origin.y -=100;
              self.view.frame = rectone;
              
          }
          self.hasScrolled = YES;
       }];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;

}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.saveTextFiled) {
        
        return;
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
   
    [self.zhekuTextField resignFirstResponder];
    [self.serviceZhekoTextField resignFirstResponder];
    [self.hangbanTextfield resignFirstResponder];
    [self.jiejiTextField resignFirstResponder];
    [self.songjiTextField resignFirstResponder];
    [self.renshuTextFiled resignFirstResponder];

    if (textField !=self.zhekuTextField  && textField !=self.serviceZhekoTextField && textField !=self.hangbanTextfield) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            if (self.hasScrolled==YES) {
                
                CGRect rectone =self.view.frame;
                rectone.origin.y +=100;
                self.view.frame = rectone;
            }
            self.hasScrolled = NO;
            
        }];
        
    }
    return YES;
    
}
- (void)handleUIKeyboardWillChangeFrameNotification:(NSNotification*)noti
{
    
    if (self.saveTextFiled) {
        
    [UIView animateWithDuration:0.25 animations:^{
                
                if (self.hasScrolled==YES) {
                    
                    CGRect rectone =self.view.frame;
                    rectone.origin.y +=100;
                    self.view.frame = rectone;
                }
                self.hasScrolled = NO;
                
            }];
        self.saveTextFiled = nil;
      }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[self.orderNameTableView class]]) {
        
        [self.coustomNameSearchBar resignFirstResponder];
        
    }

}
/**
 *  显示弹出试图
 */
- (void)showSongjiPopupView:(int)type
{
    self.SongjipopupView = [[MapPopupView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    self.SongjipopupView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:self.SongjipopupView];
    __block ConfirmOrderViewController *blockSelf = self;
    [self.SongjipopupView setCallBack:^(int type, int status,NSString *value) {
        if (status ==2) {
            [blockSelf hideSongjiPopupView];
        }else{
            if (type==2) {//时间
         
                blockSelf.songjiString = value;
                CGSize size = [value sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
                blockSelf.songjiButton.frame = CGRectMake(568, 177, size.width, 30);
                blockSelf.songjiImageView.frame = CGRectMake(CGRectGetMaxX(blockSelf.songjiButton.frame)+4,  188, 14, 9);
                [blockSelf.songjiButton setTitle:value forState:UIControlStateNormal];
          
            }
            [blockSelf hideSongjiPopupView];
        }
    }];
    
    self.SongjipopupView.type = type;
    self.SongjipopupView.hidden = NO;
    //    CGRect frame = self.popupView.showView.frame;
    //    frame.origin.y +=self.popupView.showView.frame.size.height;
    //    self.popupView.showView.frame = frame;
    [UIView animateWithDuration:0.25 animations:^{
        self.SongjipopupView.showView.backgroundColor = [UIColor whiteColor];
            self.SongjipopupView.showView.frame = CGRectMake(450, 340-64-70,320, 250);
    }];


}

-(void)showPopupView:(int)type
{
   
      self.JiejipopupView = [[MapPopupView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
        self.JiejipopupView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self.view addSubview:self.JiejipopupView];
        __block ConfirmOrderViewController *blockSelf = self;
        [self.JiejipopupView setCallBack:^(int type, int status,NSString *value) {
            if (status ==2) {
                [blockSelf hidePopupView];
            }else{
                if (type==2) {//时间
                    
        
                    blockSelf.jiejiString= value;
                    CGSize size = [value sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
                    blockSelf.jiejiButton.frame = CGRectMake(145, 177, size.width, 30);
                    blockSelf.jiejiImageView.frame = CGRectMake(CGRectGetMaxX(blockSelf.jiejiButton.frame)+4,  188, 14, 9);
                    [blockSelf.jiejiButton setTitle:value forState:UIControlStateNormal];
                    
                }
          
                [blockSelf hidePopupView];
            }
        }];
   
    self.JiejipopupView.type = type;
    self.JiejipopupView.hidden = NO;

    [UIView animateWithDuration:0.25 animations:^{
        
    self.JiejipopupView.showView.frame = CGRectMake(0, 340-64-70,320, 250);

       
    }];
    
    
}
-(void)hideSongjiPopupView
{
    [UIView animateWithDuration:0.25 animations:^{
        int height = [UIScreen mainScreen].bounds.size.height;
        self.SongjipopupView.showView.frame = CGRectMake(0, height, 320, 250);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            self.SongjipopupView.hidden = YES;
            self.songjiImageView.transform = CGAffineTransformRotate(self.songjiImageView.transform, DEGREES_TO_RADIANS(180));
        }];
    }];
}
-(void)hidePopupView
{
    [UIView animateWithDuration:0.25 animations:^{
        int height = [UIScreen mainScreen].bounds.size.height;
        self.JiejipopupView.showView.frame = CGRectMake(0, height, 320, 250);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            self.JiejipopupView.hidden = YES;
           self.jiejiImageView.transform = CGAffineTransformRotate(self.jiejiImageView.transform, DEGREES_TO_RADIANS(180));
        }];
    }];
}

- (IBAction)postFactMethod:(UIButton *)sender {
    
    [self.zhekuTextField resignFirstResponder];
    PostTableViewController* starVC = [[PostTableViewController alloc]init];
    starVC.contentSizeForViewInPopover = CGSizeMake(150, 120);
    starVC.postDelegate = self;
    self.factPostPopVC = [[UIPopoverController alloc]initWithContentViewController:starVC];
    self.factPostPopVC.delegate = self;
    CGRect rect = self.resultButton.frame;
    rect.origin.y+=60.0;
    self.resultButton.frame = rect;
    [self.factPostPopVC presentPopoverFromRect:self.resultButton.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionUp
                                              animated:YES];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (self.factPostRoulation ==NO) {
            
            self.factPostRoulation = YES;
            
            self.resultImageView.transform = CGAffineTransformRotate(self.resultImageView.transform, DEGREES_TO_RADIANS(180));
            
        }else {
            self.factPostRoulation = YES;
            
            self.resultImageView.transform = CGAffineTransformRotate(self.resultImageView.transform, DEGREES_TO_RADIANS(180));
            
        }
        CGRect rect = self.resultButton.frame;
        rect.origin.y-=60.0;
        self.resultButton.frame = rect;
        
    }];
}
- (void)chosePostString:(NSString*)string title:(NSString*)title
{
     self.factPostString =string;
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
        self.resultButton.frame = CGRectMake(570, 136, size.width, 30);
        self.resultImageView.frame = CGRectMake(CGRectGetMaxX(self.resultButton.frame)+4,  147, 14, 9);
        [self.resultButton setTitle:title forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            
         self.resultImageView.transform = CGAffineTransformRotate(self.resultImageView.transform, DEGREES_TO_RADIANS(180));
            
        }];
        
  if (self.factPostPopVC) {
        
        [self.factPostPopVC dismissPopoverAnimated:NO];
        self.factPostPopVC = nil;
    }
  
}
- (IBAction)factSureMethod:(UIButton *)sender {
    
   if (self.chectStoreArray.count <=0) {
        
        [self.view makeToast:@"您还没有选择客户?"];
        return;
    }
    NSIndexPath* indexPath = self.chectStoreArray[0];
    NSString* name;
    NSDictionary* dic;
    
    if (self.storeHasFind ==YES) {
        dic = self.containStorenameArray[indexPath.row];
        name = [dic objectForKey:@"FName"];
        
    }else {
        name = self.storeNameArray[indexPath.row];
    }
    CGSize size = [name sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
    CGRect rect;
    
    rect  = self.choseStoreButton.frame;
    rect.origin.x-=3;
    rect.size.width = size.width;
    self.choseStoreButton.frame = rect;
    CGRect rect2;
    rect2 =self.chosestoreImageView.frame;
    rect2.origin.x =CGRectGetMaxX(self.choseStoreButton.frame)+4;
    self.chosestoreImageView.frame = rect2;
   [self.choseStoreButton setTitle:name forState:UIControlStateNormal];
    
    CGRect rect3;
    
    rect3  = self.serviceStoreButton.frame;
    rect3.size.width = size.width;
    self.serviceStoreButton.frame = rect3;
    CGRect rect4;
    rect4=self.serviceStoreImageView.frame;
    rect4.origin.x =CGRectGetMaxX(self.serviceStoreButton.frame)+4;
    self.serviceStoreImageView.frame = rect4;
    [self.serviceStoreButton setTitle:name forState:UIControlStateNormal];
    self.hasShowStore = NO;
    
    if (self.storeHasFind) {
        
        self.storeNameId =[dic objectForKey:@"FId"];
        [self hiddenStoreNameView];
        
    }else {
        for (StoreModel* model in self.storeArray) {
            if ([model.storeName isEqualToString:name]) {
                self.storeNameId =model.storeNameId;
                [self hiddenStoreNameView];
                break;
            }
            
        }
    }
}
- (IBAction)choseFactStoreMethod:(UIButton *)sender {
    
    [self.zhekuTextField resignFirstResponder];
    self.hasShowStore = YES;
    [self loadStoreName];
}

- (void)loadStoreName
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"获取数据中"];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, StoreName_URL];
    RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[[NSNumber numberWithInt:self.storePageIndex] stringValue] forKey:@"pageIndex"];
    [req setParam:@"20" forKey:@"pageSize"];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setHTTPMethod:@"POST"];
    RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
    [loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoadedStoreName:)];
    [loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
    [loader loadwithTimer];
}
- (void)onLoadedStoreName:(NSNotification*)noti
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
        //   [SVProgressHUD dismissWithError:@"获取数据失败!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"获取数据失败!" duration:2 position:@"center"];
        return;
    }
    
    NSDictionary *Dic = [data objectForKey:@"list"];
    if ([Dic count] == 0) {
        // [SVProgressHUD dismissWithError:@"暂无数据!"];
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"暂无数据!" duration:2 position:@"center"];
        return;
    }
    // [SVProgressHUD dismiss];
    [DejalBezelActivityView removeViewAnimated:YES];
    NSArray* listArr = [Dic objectForKey:@"records"];
    for (NSDictionary* smallDic in listArr) {
        StoreModel* nameModel = [[StoreModel alloc]init];
        nameModel.storeName = [smallDic objectForKey:@"FName"];
        nameModel.storeNameId = [smallDic objectForKey:@"FId"];
        [self.storeArray addObject:nameModel];
        [self.storeNameArray addObject: [smallDic objectForKey:@"FName"]];
        
    }
    self.storePageIndex = [[Dic objectForKey:@"pageIndex"] integerValue]+1;
    self.storeTotalIndex = [[Dic objectForKey:@"pageCount"] integerValue];
    [self.StoreTableView reloadData];
    [self showStoreNameView];
    [self.StoreTableView footerEndRefreshing];

}
- (void)showStoreNameView
{
    if (self.hasShowStoreView ==NO) {
        
        self.hasShowStoreView = YES;
        self.storeView.frame = CGRectMake(1030, 0, 770, 624);
        [self.view addSubview:self.storeView];
        [UIView beginAnimations:@"split" context:nil];
        [UIView setAnimationDuration:0.5];
        self.storeView.frame = CGRectMake(0, 0, 770, 624);
        [UIView commitAnimations];
    }
}
- (void)hiddenStoreNameView
{
    [UIView beginAnimations:@"split" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeStoreView)];
    self.storeView.frame = CGRectMake(1030, 0, 770, 624);
    [UIView commitAnimations];
    [self.storeNameArray removeAllObjects];
    [self.storeArray removeAllObjects];
    [self.chectStoreArray removeAllObjects];
    self.hasShowStoreView = NO;
    self.storeHasFind = NO;
}
- (void)removeStoreView
{
    [self.storeView removeFromSuperview];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.hasShowAirportView) {
        if ([searchText isEqualToString:@""]) {
            self.airportPageIndex =1;
            [self loadAirportName];
            [self.airportArray removeAllObjects];
            [self.airportnameArray removeAllObjects];
            self.airportHasFind=NO;
        }
    }
    if (self.hasShowCoustomView) {
        if ([searchText isEqualToString:@""]) {
            self.pageIndex =1;
            [self loadCoustomName];
            [self.coustomNameArray removeAllObjects];
            [self.nameArray removeAllObjects];
            self.hasFind=NO;
        }
    }
    if (self.hasShowStoreView) {
        
        if ([searchText isEqualToString:@""]) {
            self.storePageIndex =1;
            [self loadStoreName];
            [self.storeArray removeAllObjects];
            [self.storeNameArray removeAllObjects];
            self.storeHasFind=NO;
        }
        
    }
}
- (void)searchNameOrStoreOrAirport:(NSString*)typestring
{
    
    self.searchTypeString = typestring;
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"搜索数据中"];
    [DejalActivityView currentActivityView].showNetworkActivityIndicator = YES;
    RRToken *token = [RRToken getInstance];
    NSString *full_url;
    RRURLRequest *req;

    if ([typestring isEqualToString:@"CoustomName"]) {
        
     full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, @"api/Crm.Order.getCustomerSelectList"];
     req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:self.coustomNameSearchBar.text forKey:@"keyword"];
 
    }else if ([typestring isEqualToString:@"StoreName"]){
        
        full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, @"api/Crm.Order.getStoreSelectList"];
        req = [[RRURLRequest alloc] initWithURLString:full_url];
        [req setParam:self.StoreSearchBar.text forKey:@"keyword"];
        
     }else if ([typestring isEqualToString:@"AirportName"]){
    
        full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, @"api/Crm.Order.getAirportSelectList"];
        req = [[RRURLRequest alloc] initWithURLString:full_url];
        [req setParam:self.airportSearchBar.text forKey:@"keyword"];

    }
    
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setHTTPMethod:@"POST"];
    
    RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
    [loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onNameLoaded:)];
    [loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
    [loader loadwithTimer];
}
- (void)onNameLoaded:(NSNotification*)noti
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
    if (![[json objectForKey:@"success"] boolValue])
    {
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"获取数据失败!" duration:2 position:@"center"];
        return;
    }
    
    NSArray *arr = [[data objectForKey:@"list"] objectForKey:@"records"];
    if ([arr count] == 0) {
        self.hasFind = NO;
        self.storeHasFind = NO;
        _airportHasFind = YES;
        [self.airportArray removeAllObjects];
        [self.airportnameArray removeAllObjects];
        [self.containAirportnameArray removeAllObjects];
        
        [self.storeArray removeAllObjects];
        [self.storeNameArray removeAllObjects];
        [self.containStorenameArray removeAllObjects];
        
        [self.nameArray removeAllObjects];
        [self.coustomNameArray removeAllObjects];
        [self.containnameArray removeAllObjects];
        [self.airportTableView reloadData];
        [self.StoreTableView reloadData];
        [self.orderNameTableView reloadData];

        
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"暂无数据!" duration:1 position:@"center"];
        return;
    }
    
    [DejalBezelActivityView removeViewAnimated:YES];
    if ([self.searchTypeString isEqualToString:@"CoustomName"]) {
         _hasFind = YES;
        for (NSDictionary* dic in arr) {
            [self.containnameArray addObject:dic];
       }
        [self.orderNameTableView reloadData];

     }else if ([self.searchTypeString isEqualToString:@"StoreName"]){
    
        _storeHasFind = YES;
        for (NSDictionary* dic in arr) {
             
             [self.containStorenameArray addObject:dic];
         }
          [self.StoreTableView reloadData];
        
    }else if ([self.searchTypeString isEqualToString:@"AirportName"]){
    
        _airportHasFind = YES;
        for (NSDictionary* dic in arr) {

            [self.containAirportnameArray addObject:dic];
     
        }
        [self.airportTableView reloadData];
  
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (self.hasShowAirportView) {
        [self.containAirportnameArray removeAllObjects];
        [self searchNameOrStoreOrAirport:@"AirportName"];
        [self.airportSearchBar resignFirstResponder];
    }
    
    
    if (self.hasShowStoreView) {
        [self.containStorenameArray removeAllObjects];
        [self searchNameOrStoreOrAirport:@"StoreName"];
        [self.StoreSearchBar resignFirstResponder];
    }
    
    if (self.hasShowCoustomView) {
        
        [self.containnameArray removeAllObjects];
        [self searchNameOrStoreOrAirport:@"CoustomName"];
        [self.coustomNameSearchBar resignFirstResponder];
        
    }
}
- (void)serachStore
{
    self.storeHasFind = NO;
    for (NSString* name in self.storeNameArray) {
        NSRange range = [name rangeOfString:self.StoreSearchBar.text];
        if (range.length > 0) {
            
            _storeHasFind = YES;
            [self.containStorenameArray addObject:name];
        }
    }
    
    [self.StoreTableView reloadData];

}
- (void)searchAirport
{
    self.airportHasFind = NO;
    for (NSString* name in self.airportnameArray) {
        NSRange range = [name rangeOfString:self.airportSearchBar.text];
        if (range.length > 0) {
            
            _airportHasFind = YES;
            [self.containAirportnameArray addObject:name];
        }
    }

    
    [self.airportTableView reloadData];
  
}
- (void)search
{
    self.hasFind = NO;
    for (NSString* name in self.nameArray) {
        NSRange range = [name rangeOfString:self.coustomNameSearchBar.text];
        if (range.length > 0) {
            
            _hasFind = YES;
            [self.containnameArray addObject:name];
        }
    }
    [self.orderNameTableView reloadData];
    
}
- (IBAction)serviceStoreButtonMethod:(id)sender {
    
    self.hasShowStore = YES;
    [self loadStoreName];
}

- (IBAction)servicePostButton:(UIButton *)sender {
   
    [self.serviceZhekoTextField resignFirstResponder];
    ServicePostTableViewController* starVC = [[ServicePostTableViewController alloc]init];
    starVC.contentSizeForViewInPopover = CGSizeMake(150, 120);
    starVC.servicePostDelegate = self;
    self.servicePostPopVC = [[UIPopoverController alloc]initWithContentViewController:starVC];
    self.servicePostPopVC.delegate = self;
    CGRect rect = self.servicePostButton.frame;
    rect.origin.y+=60.0;
    self.servicePostButton.frame = rect;
    [self.servicePostPopVC presentPopoverFromRect:self.servicePostButton.frame
                                        inView:self.view
                      permittedArrowDirections:UIPopoverArrowDirectionUp
                                      animated:YES];
    [UIView animateWithDuration:0.3 animations:^{
        
        if (self.servicePostRoulation ==NO) {
            
            self.servicePostRoulation = YES;
            
            self.serviceImageView.transform = CGAffineTransformRotate(self.serviceImageView.transform, DEGREES_TO_RADIANS(180));
            
        }else {
            self.servicePostRoulation = YES;
            self.serviceImageView.transform = CGAffineTransformRotate(self.serviceImageView.transform, DEGREES_TO_RADIANS(180));
            
        }
        CGRect rect = self.servicePostButton.frame;
        rect.origin.y-=60.0;
        self.servicePostButton.frame = rect;
        
    }];
}


- (void)choseServicePostString:(NSString*)string title:(NSString*)title
{
    self.servicePostString = string;
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
    self.servicePostButton.frame = CGRectMake(566, 170, size.width, 30);
    self.serviceImageView.frame = CGRectMake(CGRectGetMaxX(self.servicePostButton.frame)+4,  182, 14, 9);
    [self.servicePostButton setTitle:title forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        
        self.serviceImageView.transform = CGAffineTransformRotate(self.serviceImageView.transform, DEGREES_TO_RADIANS(180));
        
    }];
    
    if (self.servicePostPopVC) {
        
        [self.servicePostPopVC dismissPopoverAnimated:NO];
        self.servicePostPopVC = nil;
    }
    
    
}


@end
