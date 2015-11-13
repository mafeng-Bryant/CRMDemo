//
//  NotificationCopyViewController.m
//  CRM
//
//  Created by 马峰 on 15-1-13.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import "NotificationCopyViewController.h"
#import "RRToken.h"
#import "RRLoader.h"
#import "SVProgressHUD.h"
#import "Toast+UIView.h"
#import "RRURLRequest.h"
#import "AppDelegate.h"
#import "DejalActivityView.h"


#import "WebToViewController.h"

@interface NotificationCopyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView* publicTableView;
@property(nonatomic,strong) UITableView* notificationTableView;

@property(nonatomic,strong) NSMutableArray* announcementArray;//公告
@property(nonatomic,strong) NSString* announceUrl;//公告Url
@property(nonatomic,strong) NSMutableArray* workitemArray;//工作流
@property(nonatomic,strong) NSString* workitemUrl;//工作流Url
@property(nonatomic,strong) NSMutableArray* unassignedOrderArray;//未分配订单
@property(nonatomic,strong) NSString* unassignedOrderUrl;//未分配订单Url
@property(nonatomic,strong) NSMutableArray* birthdayArray;//生日提醒
@property(nonatomic,strong) NSString* birthdayUrl;//生日提醒Url
@property(nonatomic,strong) NSMutableArray* followupArray;//跟进提醒
@property(nonatomic,strong) NSString* followupUrl;//跟进提醒Url

@end

@implementation NotificationCopyViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.announcementArray = [NSMutableArray array];
    self.workitemArray = [NSMutableArray array];
    self.unassignedOrderArray = [NSMutableArray array];
    self.birthdayArray = [NSMutableArray array];
    self.followupArray = [NSMutableArray array];
    self.publicTableView = [[UITableView alloc]initWithFrame:CGRectMake(10.0, 0.0, 567.0, 768-230) style:UITableViewStyleGrouped];
    self.publicTableView.backgroundColor = [UIColor clearColor];
    self.publicTableView.delegate = self;
    self.publicTableView.dataSource = self;
    self.publicTableView.scrollEnabled = NO;
    self.publicTableView.showsHorizontalScrollIndicator = NO;
    self.publicTableView.showsVerticalScrollIndicator = NO;
    self.publicTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.publicTableView];
    
    
    self.notificationTableView = [[UITableView alloc]initWithFrame:CGRectMake(567+30.0, 0.0, 576.0/2+10, 768-230) style:UITableViewStyleGrouped];
    self.notificationTableView.backgroundColor = [UIColor clearColor];
    self.notificationTableView.delegate = self;
    self.notificationTableView.dataSource = self;
    self.notificationTableView.scrollEnabled = NO;
    self.notificationTableView.showsHorizontalScrollIndicator = NO;
    self.notificationTableView.showsVerticalScrollIndicator = NO;
    self.notificationTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.notificationTableView];
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
    [req setParam:@"items" forKey:@"type"];
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
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"获取数据失败!" duration:2 position:@"center"];
       // [SVProgressHUD dismissWithError:@"获取数据失败!"];
        return;
    }
    
    NSDictionary *Dic = [data objectForKey:@"data"];
    if ([Dic count] == 0) {
        [DejalBezelActivityView removeViewAnimated:YES];
        [self.view makeToast:@"暂无数据!" duration:2 position:@"center"];
       // [SVProgressHUD dismissWithError:@"暂无数据!"];
        return;
    }
    [SVProgressHUD dismiss];
    
    
    NSDictionary* announcementArrDic = [Dic objectForKey:@"announcement"];
    NSArray* announcementArr = [announcementArrDic objectForKey:@"data"];
    if (announcementArr.count >0) {
        [self.announcementArray addObjectsFromArray:announcementArr];
    }
    self.announceUrl = [announcementArrDic objectForKey:@"url"];
    NSDictionary* followArrDic = [Dic objectForKey:@"followup"];
    NSArray* followArr = [followArrDic objectForKey:@"data"];
    if (followArr.count >0) {
        [self.followupArray addObjectsFromArray:followArr];
    }
    self.followupUrl = [followArrDic objectForKey:@"url"];
    
    NSDictionary* unassignedOrderArrDic =[Dic objectForKey:@"unassignedOrder"];
    NSArray* unassignedOrderArr = [unassignedOrderArrDic objectForKey:@"data"];
    if (unassignedOrderArr.count >0) {
        [self.unassignedOrderArray addObjectsFromArray:unassignedOrderArr];
    }
    self.unassignedOrderUrl = [unassignedOrderArrDic objectForKey:@"url"];
    
    NSDictionary* workItemArrDic = [Dic objectForKey:@"workitem"];
    NSArray* workItemArr = [workItemArrDic objectForKey:@"data"];
    if (workItemArr.count >0) {
        [self.workitemArray addObjectsFromArray:workItemArr];
    }
    self.workitemUrl = [workItemArrDic objectForKey:@"url"];
    
    NSDictionary* birthDic =[Dic objectForKey:@"birthday"];
    NSDictionary* smallDic = [birthDic objectForKey:@"data"];
    if (smallDic.count >0) {
        [self.birthdayArray addObject:smallDic];
    }
    self.birthdayUrl = [birthDic objectForKey:@"url"];
    [self.publicTableView reloadData];
    [self.notificationTableView reloadData];
    [DejalBezelActivityView removeViewAnimated:YES];

}
- (void) onLoadFail: (NSNotification *)notify
{
  //  [SVProgressHUD dismissWithError:@"网络错误!" afterDelay:1.5f];
    [DejalBezelActivityView removeViewAnimated:YES];
    [self.view makeToast:@"网络错误!" duration:2 position:@"center"];
    RRLoader *loader = (RRLoader *)[notify object];
    [loader removeNotificationListener:RRLOADER_COMPLETE target:self];
    [loader removeNotificationListener:RRLOADER_FAIL target:self];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView ==self.publicTableView) {
        
        if (section ==0) {
            
            return 5;
        }
        return 2;
    } else if (tableView ==self.notificationTableView){
        
        if (section ==0) {
            
            return 4;
        }
        return 3;
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"cellidenty";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SimpleTableIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView ==self.publicTableView) {
        
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        UILabel* labelOne = [[UILabel alloc]init];
        labelOne.frame = CGRectMake(18.0, 8.0, 300, 22);
        labelOne.textColor = [UIColor whiteColor];
        labelOne.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:labelOne];
        
        UILabel* labelTwo = [[UILabel alloc]init];
        labelTwo.frame = CGRectMake(490.0, 8.0, 200, 22);
        labelTwo.textColor = [UIColor whiteColor];
        labelTwo.font = [UIFont systemFontOfSize:13];
        
        [cell.contentView addSubview:labelTwo];
        
        if (indexPath.section ==0) {
            if (self.announcementArray.count > 0) {
                
                if (indexPath.row <=self.announcementArray.count-1) {
                    labelOne.text = [[self.announcementArray objectAtIndex:indexPath.row] objectForKey:@"FName"];
                    labelTwo.text = [[self.announcementArray objectAtIndex:indexPath.row] objectForKey:@"FReleaseTime"];
                    
                }
            }else if (indexPath.section ==1){
                if (self.workitemArray.count>0) {
                    if (indexPath.row<=self.workitemArray.count-1) {
                        
                        labelOne.text = [[self.workitemArray objectAtIndex:indexPath.row] objectForKey:@"FName"];
                        labelTwo.text = [[self.workitemArray objectAtIndex:indexPath.row] objectForKey:@"FCreateTime"];
                    }
                    
                }
                
            }
            
        }else if (indexPath.section ==2){
            if (self.unassignedOrderArray.count > 0) {
                
                if (indexPath.row<=self.unassignedOrderArray.count-1) {
                    
                    labelOne.text = [[self.unassignedOrderArray objectAtIndex:indexPath.row] objectForKey:@"FName"];
                    labelTwo.frame = CGRectMake(430.0, 8.0, 200, 22);
                    labelTwo.text = [[self.unassignedOrderArray objectAtIndex:indexPath.row] objectForKey:@"FCreateTime"];
                    
                }
            }
            
            
        }
        //线条
        UILabel* lineLabelOne = [[UILabel alloc]init];
        lineLabelOne.frame = CGRectMake(0.0,-2.0 ,1 ,46);
        lineLabelOne.backgroundColor = [UIColor whiteColor];
        lineLabelOne.alpha = 0.7;
        [cell.contentView addSubview:lineLabelOne];
        
        UILabel* lineLabelTwo = [[UILabel alloc]init];
        lineLabelTwo.frame = CGRectMake(565,-2.0 ,1 ,46);
        lineLabelTwo.backgroundColor = [UIColor whiteColor];
        lineLabelTwo.alpha = 0.9;
        [cell.contentView addSubview:lineLabelTwo];
        
        UILabel* lineLabelThere = [[UILabel alloc]init];
        lineLabelThere.frame = CGRectMake(0.0,44.0 ,567.0 ,1);
        lineLabelThere.backgroundColor = [UIColor whiteColor];
        lineLabelThere.alpha = 0.5;
        [cell.contentView addSubview:lineLabelThere];
        
        return cell;
        
    } else if (tableView ==self.notificationTableView){
        
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        UIImage* birthdayImage = [UIImage imageNamed:@"birthday.png"];
        UIImageView* birthdayImageView = [[UIImageView alloc]init];
        birthdayImageView.frame = CGRectMake(20.0, 20.0, birthdayImage.size.width/2.0, birthdayImage.size.height/2.0);
        birthdayImageView.image = birthdayImage;
        if (indexPath.section ==0 && indexPath.row ==0) {
            [cell.contentView addSubview:birthdayImageView];
            
        }
        
        //线条
        UILabel* lineLabelOne = [[UILabel alloc]init];
        if (indexPath.section ==0 && indexPath.row ==0) {
            lineLabelOne.frame = CGRectMake(0.0,-2.0 ,1 ,88);
            
        }else if(indexPath.section ==0 && indexPath.row > 0){
            lineLabelOne.frame = CGRectMake(0.0,-2.0 ,1 ,46);
            
        }else if (indexPath.section ==1){
            lineLabelOne.frame = CGRectMake(0.0,-2.0 ,1 ,228.0/3+4);
            
        }
        lineLabelOne.backgroundColor = [UIColor whiteColor];
        lineLabelOne.alpha = 0.7;
        [cell.contentView addSubview:lineLabelOne];
        
        UILabel* lineLabelTwo = [[UILabel alloc]init];
        if (indexPath.section ==0 && indexPath.row ==0) {
            lineLabelTwo.frame = CGRectMake(576.0/2+9,-2.0 ,1 ,88);
            
        }else if(indexPath.section ==0 && indexPath.row > 0){
            lineLabelTwo.frame = CGRectMake(576.0/2+9,-2.0 ,1 ,46);
            
        }else if (indexPath.section ==1){
            lineLabelTwo.frame = CGRectMake(576.0/2+9,-2.0 ,1 ,228.0/3+2);
            
        }
        lineLabelTwo.backgroundColor = [UIColor whiteColor];
        lineLabelTwo.alpha = 0.5;
        [cell.contentView addSubview:lineLabelTwo];
        
        UILabel* lineLabelThere = [[UILabel alloc]init];
        if (indexPath.section ==0 && indexPath.row ==0) {
            lineLabelThere.frame = CGRectMake(0.0,88.0 ,567.0 ,1);
            
            
        }else if (indexPath.section ==0 && indexPath.row > 0){
            
            lineLabelThere.frame = CGRectMake(0.0,44.0 ,567.0 ,1);
            
            
        }else if (indexPath.section ==1){
            lineLabelThere.frame = CGRectMake(0.0,228.0/3+2 ,567.0 ,1);
            
        }
        lineLabelThere.backgroundColor = [UIColor whiteColor];
        lineLabelThere.alpha = 0.5;
        [cell.contentView addSubview:lineLabelThere];
        
        UIImage* clockImage = [UIImage imageNamed:@"notification.png"];
        UIImageView* clockImageImageView = [[UIImageView alloc]init];
        clockImageImageView.frame = CGRectMake(20.0, 20.0, clockImage.size.width/2.0, clockImage.size.height/2.0);
        clockImageImageView.image = clockImage;
        if (indexPath.section ==1) {
            [cell.contentView addSubview:clockImageImageView];
            
        }
        
        //复制 576.0/2+10
        UITextView* textView = [[UITextView alloc]init];
        textView.backgroundColor = [UIColor clearColor];
        textView.font = [UIFont systemFontOfSize:14];
        textView.userInteractionEnabled = NO;
        textView.textColor = [UIColor whiteColor];
        [cell.contentView addSubview:textView];
        
        if (indexPath.section ==0) {
            
            if (self.birthdayArray.count >0) {
                
                NSLog(@"%@",self.birthdayArray);
                
                NSDictionary* dic = [self.birthdayArray objectAtIndex:0];
                NSArray* arr = [dic objectForKey:@"list"];
                
                
                if (indexPath.section ==0 && indexPath.row ==0) {
                    
                    textView.frame = CGRectMake(40.0, 10.0,576/2-20*2 , 88-20);
                    NSArray* str = [dic objectForKey:@"today"];
                    NSMutableString* s = [NSMutableString string];
                    
                    if (str.count==0) {
                        
                        [s appendString:@"暂无人员生日"];
                        
                    }else {
                        for (NSString* string in str) {
                            [s appendString:string];
                            
                        }
                    }
                    
                    textView.text =s;
                }else if (indexPath.section ==0 &&indexPath.row >0){
                    
                    
                    if (indexPath.row<=arr.count) {
                        NSDictionary* newDic = [arr objectAtIndex:indexPath.row-1];
                        textView.frame = CGRectMake(40.0, 5.0,576/2-20*2 ,24);
                        textView.text = [NSString stringWithFormat:@"距离%@生日还有%d天",[newDic objectForKey:@"FName"],[[newDic objectForKey:@"distance"] integerValue]];
                    }
                    
                }
                
            }
        }else if (indexPath.section ==1){
            if (self.followupArray.count > 0) {
                
                NSLog(@"%@",self.followupArray);
                
                textView.frame = CGRectMake(40.0, 8.0,576/2-20*2 , 88-20);
                if (indexPath.row <=self.followupArray.count-1) {
                    textView.text = [[self.followupArray objectAtIndex:indexPath.row] objectForKey:@"FName"];
                }
                
            }
            
        }
        
        return cell;
    }
    
    
    
    return nil;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* backgroundView = [[UIView alloc]init];
    backgroundView.frame = CGRectMake(0.0, 0.0, 567.0, 30.0);
    backgroundView.backgroundColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:backgroundView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = backgroundView.bounds;
    maskLayer.path = maskPath.CGPath;
    backgroundView.layer.mask = maskLayer;
    
    UILabel* label = [[UILabel alloc]init];
    label.frame = CGRectMake(20.0, 5.0, 200, 22);
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    if (tableView ==self.publicTableView) {
        
        if (section ==0) {
            
            label.text = @"公告";
        }else if (section ==1){
            label.text = @"工作流提醒";
            
        }else if (section ==2){
            label.text = @"未分配的销售订单";
        }
    } else if (tableView ==self.notificationTableView){
        
        if (section ==0) {
            
            label.text = @"生日提醒";
        }else if (section ==1){
            
            label.text = @"跟进提醒";
        }
        
    }
    
    [backgroundView addSubview:label];
    
    UIButton* moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (tableView ==self.publicTableView) {
        moreButton.frame = CGRectMake(500.0, 5.0, 30, 22);
        
    }else {
        moreButton.frame = CGRectMake( 576.0/2-40.0, 5.0, 30, 22);
    }
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    moreButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(clickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:moreButton];
    
    UIImage* moreImage = [UIImage imageNamed:@"more.png"];
    UIButton* moreImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (tableView ==self.publicTableView) {
        moreImageButton.frame = CGRectMake(CGRectGetMaxX(moreButton.frame), 12.0,moreImage.size.width/2.0, moreImage.size.height/2.0);
    }else {
        moreImageButton.frame = CGRectMake(CGRectGetMaxX(moreButton.frame), 12.0,moreImage.size.width/2.0, moreImage.size.height/2.0);    }
    [moreImageButton setImage:moreImage forState:UIControlStateNormal];
    [moreImageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [moreImageButton addTarget:self action:@selector(clickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:moreImageButton];
    
    if (tableView ==self.publicTableView) {
        if (section ==0) {
            moreButton.tag =KPublicButtonTag;
            moreImageButton.tag =KPublicButtonTag;
            
        }else if (section ==1){
            moreButton.tag =KWorkButtonTag;
            moreImageButton.tag =KWorkButtonTag;
        }else {
            
            moreButton.tag =KOrderButtonTag;
            moreImageButton.tag =KOrderButtonTag;
        }
        
        
    }else if (tableView ==self.notificationTableView ) {
        if (section ==0) {
            moreButton.tag =KBirthdayButtonTag;
            moreImageButton.tag =KBirthdayButtonTag;
            
        }else {
            
            moreButton.tag =KGENJINButtonTag;
            moreImageButton.tag =KGENJINButtonTag;
        }
        
    }
    return backgroundView;
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView ==self.publicTableView) {
        
        return 3;
        
    }
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.publicTableView) {
        
        return 44;
        
    }else if (tableView ==self.notificationTableView){
        if (indexPath.section ==0 && indexPath.row ==0) {
            
            return 88.0;
        }else if(indexPath.section ==0 && indexPath.row >0){
            
            return 44.0;
            
        }else if (indexPath.section ==1){
            return 228.0/3;
            
        }
        
    }
    return 0;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
    
}
- (void)clickMoreButton:(UIButton*)bt
{
    NSString* urlString=nil;
    switch (bt.tag) {
        case KPublicButtonTag:
            NSLog(@"KPublicButtonTag");
            
            urlString = self.announceUrl;
            break;
        case KWorkButtonTag:
            NSLog(@"KWorkButtonTag");
            urlString = self.workitemUrl;
            
            break;
        case KOrderButtonTag:
            NSLog(@"KOrderButtonTag");
            urlString = self.unassignedOrderUrl;
            
            break;
        case KBirthdayButtonTag:
            NSLog(@"KBirthdayButtonTag");
            urlString = self.birthdayUrl;
            
            break;
        case KGENJINButtonTag:
            NSLog(@"KGENJINButtonTag");
            urlString = self.followupUrl;
            
            break;
        default:
            break;
    }
    
    WebToViewController* webVC = [[WebToViewController alloc]init];
    webVC.url = urlString;
    if ([urlString length]>0) {
        
        [self.navigationController pushViewController:webVC animated:YES];
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
