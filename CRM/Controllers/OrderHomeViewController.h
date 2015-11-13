//
//  OrderHomeViewController.h
//  CRM
//
//  Created by 马峰 on 14-11-27.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMGridView.h"
#import "GoodsFilterViewController.h"

@interface OrderHomeViewController : UIViewController<FilterViewControllerDelegate>
//导航栏视图
@property (strong, nonatomic) IBOutlet UIView *navigationBackView;
@property (strong, nonatomic) IBOutlet UIImageView *navigationImageView;
@property (strong, nonatomic) IBOutlet UIImageView *homeLogoImageview;
//实体产品，推荐，套餐按钮。tag 100-103
@property (strong, nonatomic) IBOutlet UIButton *commendButton;
@property (strong, nonatomic) IBOutlet UIButton *SolidProductButton;
@property (strong, nonatomic) IBOutlet UIButton *ServiceProductButton;
@property (strong, nonatomic) IBOutlet UIButton *TaoChanButton;

//底部视图
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIButton *myOrderButton;
@property (strong, nonatomic) IBOutlet UIButton *loginOut;

@property (strong, nonatomic) IBOutlet UITableView *orderTableView;

//tableView的底部视图
@property (strong, nonatomic) IBOutlet UIView *bottonSuperView;
@property (strong, nonatomic) IBOutlet UIView *tableFootView;

@property (strong, nonatomic) IBOutlet UILabel *PriceLabel;
@property (strong, nonatomic) IBOutlet UIButton *orderingButton;
@property (strong, nonatomic) IBOutlet UIButton *refrehButton;

@property (strong, nonatomic) IBOutlet UIButton *defaultpaixunButton;
@property (strong, nonatomic) IBOutlet UIButton *renqiButton;
@property (strong, nonatomic) IBOutlet UIButton *sellButton;
@property (strong, nonatomic) IBOutlet UIButton *priceButton;
@property (strong, nonatomic) IBOutlet UIButton *timeButton;
@property (strong, nonatomic) IBOutlet UIButton *renqiLabelButton;
@property (strong, nonatomic) IBOutlet UIButton *sellLabelButton;
@property (strong, nonatomic) IBOutlet UIButton *priceLabelButton;
@property (strong, nonatomic) IBOutlet UIButton *timeLabelButton;
@property (strong, nonatomic) IBOutlet UILabel *pictureLabel;


@property (strong, nonatomic) IBOutlet MMGridView *gridView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

//商品详情信息
@property (strong, nonatomic) IBOutlet UIView *goodDetailView;
@property (strong, nonatomic) IBOutlet UILabel *detailNameLable;
@property (strong, nonatomic) IBOutlet UILabel *detailPriceLable;
@property (strong, nonatomic) IBOutlet UILabel *detailForePriceLable;
@property (strong, nonatomic) IBOutlet UILabel *shengshuLable;
@property (strong, nonatomic) IBOutlet UILabel *baozhuangLable;

@property (strong, nonatomic) IBOutlet UILabel *xingtaiLable;
@property (strong, nonatomic) IBOutlet UILabel *guigeLable;
@property (strong, nonatomic) IBOutlet UITextView *pinzhiText;
@property (strong, nonatomic) IBOutlet UILabel *unitNameLable;
@property (strong, nonatomic) IBOutlet UILabel *detailSumLable;


@property (strong, nonatomic) IBOutlet UILabel *noShenshuLabel;
@property (strong, nonatomic) IBOutlet UILabel *noBaozhuanLabel;
@property (strong, nonatomic) IBOutlet UILabel *noChangpinLabel;
@property (strong, nonatomic) IBOutlet UILabel *noGuigeLabel;
@property (strong, nonatomic) IBOutlet UILabel *noPiciLabel;

@property (strong, nonatomic) IBOutlet UIWebView *webView;




@property (strong, nonatomic) IBOutlet UIView *successView;
@property (strong, nonatomic) IBOutlet UIView *successHeadView;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;
- (IBAction)closeButtonMethod:(UIButton *)sender;

//立即下单
- (IBAction)soonOrderMethod:(UIButton *)sender;

- (IBAction)detailReduceMethod:(UIButton *)sender;
- (IBAction)detailAddMethod:(UIButton *)sender;


//菜单按钮切换
- (IBAction)changeMenuButtonMethod:(UIButton *)sender;

//tag 112-116
- (IBAction)homeSortMethod:(id)sender;

- (IBAction)OrderButtonMethod:(UIButton *)sender;

- (IBAction)detailViewBackMethod:(UIButton *)sender;

//下单
- (IBAction)orderingButtonMethod:(UIButton *)sender;
//涮新
- (IBAction)refreshingButtonMethod:(UIButton *)sender;

@end
