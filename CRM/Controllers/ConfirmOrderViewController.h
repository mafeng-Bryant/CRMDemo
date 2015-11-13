//
//  ConfirmOrderViewController.h
//  CRM
//
//  Created by 马峰 on 14-12-4.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownChooseProtocol.h"
@class DetailProduct;

typedef enum {
 
 KCompanychangeType = 0,
 KBusinesschangeType =1,

}KType;


@protocol OrderViewControllerDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(NSMutableArray *)arrary;

- (void)cancelSuccess;

- (void)cancelPopView;

@end

@interface ConfirmOrderViewController : UIViewController<DropDownChooseDelegate,DropDownChooseDataSource,UITableViewDataSource,UITableViewDelegate>
{

    NSMutableArray *buffer;

}
/*
 1.代表实际商品
 2.代表服务商品
 */
@property(nonatomic,strong) DetailProduct* detailProduct;
@property(nonatomic,strong) UIView* mySuperView;
@property (strong, nonatomic) IBOutlet UIView *orderNameView;
@property (strong, nonatomic) IBOutlet UIView *headView;

@property (strong, nonatomic) IBOutlet UITableView *orderNameTableView;
@property (strong, nonatomic) IBOutlet UIButton *sureButton;

- (IBAction)sureButtonMethod:(UIButton *)sender;

@property(nonatomic,assign) KType DDtype;
@property(nonatomic,retain)id<OrderViewControllerDelegate>delegate;

//选择客户名字

@property (strong, nonatomic) IBOutlet UISearchBar *coustomNameSearchBar;

- (IBAction)backMethod:(UIButton *)sender;


@property (strong, nonatomic) IBOutlet UITableView *confirmTableView;
@property (strong, nonatomic) IBOutlet UIView *factTableHeadView;
@property (strong, nonatomic) IBOutlet UIView *serviceTableHeadView;
@property (strong, nonatomic) IBOutlet UITextField *zhekuTextField;

@property (strong, nonatomic) IBOutlet UITextField *membernumberTextfiled;
@property (strong, nonatomic) IBOutlet UITextField *factMembertextfield;

@property (strong, nonatomic) IBOutlet UILabel *serviceNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *factNumberLabel;


//为实际商品内容
@property (strong, nonatomic) IBOutlet UIButton *openTicketButton;
@property (strong, nonatomic) IBOutlet UIButton *orderResourceButton;
@property (strong, nonatomic) IBOutlet UIButton *CoustomNameButton;
@property (strong, nonatomic) IBOutlet UIImageView *rouateImageView;
@property (strong, nonatomic) IBOutlet UIImageView *orderresourceImageView;
//是否开票
- (IBAction)openTicketMethod:(UIButton *)sender;
//订单来源
- (IBAction)orderResourceMethod:(UIButton *)sender;
//客户名称
- (IBAction)coustomNameMethod:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIImageView *factcoustomImageview;


//为服务商品内容
@property (strong, nonatomic) IBOutlet UITextField *serviceZhekoTextField;
@property (strong, nonatomic) IBOutlet UIButton *serviceOpenticketButton;
@property (strong, nonatomic) IBOutlet UIButton *serviceOrderResourceButton;
@property (strong, nonatomic) IBOutlet UIButton *serviceCoustomNameButton;
@property (strong, nonatomic) IBOutlet UIImageView *serviceOpenImageView;
@property (strong, nonatomic) IBOutlet UIImageView *serviceOrderImageView;
@property (strong, nonatomic) IBOutlet UIImageView *serviceCoustomnameImageView;
@property (strong, nonatomic) IBOutlet UIButton *serviceTypeButton;
@property (strong, nonatomic) IBOutlet UIImageView *serviceTypeImageView;
@property (strong, nonatomic) IBOutlet UITextField *hangbanTextfield;
@property (strong, nonatomic) IBOutlet UITextField *jiejiTextField;
@property (strong, nonatomic) IBOutlet UITextField *songjiTextField;

@property (strong, nonatomic) IBOutlet UITextField *renshuTextFiled;
@property (strong, nonatomic) IBOutlet UIButton *serviceNeirongButton;
@property (strong, nonatomic) IBOutlet UIImageView *serviceNeirongImageView;


- (IBAction)serviceOpenTicketMethod:(UIButton *)sender;
- (IBAction)serviceResourceMethod:(UIButton *)sender;
- (IBAction)serviceCoustomNameMethod:(id)sender;
- (IBAction)serviceTypeMethod:(id)sender;
- (IBAction)serviceNeirongMethod:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *starAirportButton;

@property (strong, nonatomic) IBOutlet UIButton *arrviveAirportButton;

@property (strong, nonatomic) IBOutlet UIImageView *starAirportImageView;
@property (strong, nonatomic) IBOutlet UIImageView *arriveAirportImageView;

//出发机场
- (IBAction)StarAirportMethod:(id)sender;
- (IBAction)ArrviveAirport:(id)sender;

//行李
- (IBAction)packButtonMethod:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *packButton;
@property (strong, nonatomic) IBOutlet UIImageView *packImageView;

@property (strong, nonatomic) IBOutlet UIImageView *jiejiImageView;
@property (strong, nonatomic) IBOutlet UIImageView *songjiImageView;
@property (strong, nonatomic) IBOutlet UIButton *jiejiButton;
@property (strong, nonatomic) IBOutlet UIButton *songjiButton;

- (IBAction)jiejiButtonMethod:(id)sender;
- (IBAction)songjiButtonMethod:(id)sender;

//实体商品的
//门店号

@property (strong, nonatomic) IBOutlet UIButton *choseStoreButton;

@property (strong, nonatomic) IBOutlet UIImageView *chosestoreImageView;

@property (strong, nonatomic) IBOutlet UILabel *resultlabel;
@property (strong, nonatomic) IBOutlet UIButton *resultButton;
@property (strong, nonatomic) IBOutlet UIImageView *resultImageView;

//选择门店
- (IBAction)choseFactStoreMethod:(UIButton *)sender;
- (IBAction)postFactMethod:(UIButton *)sender;

//实体商品
@property (strong, nonatomic) IBOutlet UIButton *factSureButton;
- (IBAction)factSureMethod:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UISearchBar *StoreSearchBar;
@property (strong, nonatomic) IBOutlet UITableView *StoreTableView;
@property (strong, nonatomic) IBOutlet UIView *storeView;

//服务商品的
@property (strong, nonatomic) IBOutlet UIButton *serviceStoreButton;

@property (strong, nonatomic) IBOutlet UIImageView *serviceStoreImageView;
@property (strong, nonatomic) IBOutlet UIButton *servicePostButton;

@property (strong, nonatomic) IBOutlet UIImageView *serviceImageView;

- (IBAction)serviceStoreButtonMethod:(id)sender;
- (IBAction)servicePostButton:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UISearchBar *airportSearchBar;

@property (strong, nonatomic) IBOutlet UITableView *airportTableView;

@property (strong, nonatomic) IBOutlet UIView *airportView;

- (IBAction)airportSureButtonMethod:(id)sender;


- (void)setUpBuffer:(NSMutableArray *)arrary;

@end
