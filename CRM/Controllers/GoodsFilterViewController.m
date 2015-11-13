//
//  GoodsFilterViewController.m
//  CRM
//
//  Created by 马峰 on 14-12-3.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "GoodsFilterViewController.h"
#import "ProductButton.h"
#import "DetailProduct.h"
#import "ChildProduct.h"



#define NAVIGATION_BAR_HEIGHT 44.0

@interface GoodsFilterViewController ()
@property(nonatomic,assign) BOOL isViewWillAppeared;
@property(nonatomic,strong) UIView* showView;
@property(nonatomic,strong) NSMutableArray* buttonsArray;

@property(nonatomic,strong) NSString* categoryString;



@end

@implementation GoodsFilterViewController

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
    self.buttonsArray = [NSMutableArray array];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    if (self.isViewWillAppeared) {
        return;
    } else {
        self.isViewWillAppeared = YES;
    }
    self.view.userInteractionEnabled = YES;
    
   
    // Mask
    self.maskView = [[UIView alloc]init];
    self.maskView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.5;
    self.maskView.hidden = NO;
    self.maskView.userInteractionEnabled = YES;
    [self.view addSubview:self.maskView];
    
    UITapGestureRecognizer *maskTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskPressed:)];
    maskTap.numberOfTapsRequired = 1;
    maskTap.numberOfTouchesRequired = 1;
    [self.maskView addGestureRecognizer:maskTap];
    
    self.showView = [[UIView alloc]init];
    self.showView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, NAVIGATION_BAR_HEIGHT);
    self.showView.backgroundColor =UIColorFromRGB(225, 223, 220);
    self.showView.userInteractionEnabled = YES;
    [self.view addSubview:self.showView];
    
    //加载数据源
    UIImage* backImage = [UIImage imageNamed:@"menuselected.png"];
    for (int i =0; i<self.goodsArray.count+1; i++) {
        CGFloat X=0.0;
        ProductButton* bt = [[ProductButton alloc]init];
        bt.frame = CGRectMake(40.0+X+100*i, 10.0, 80, 22);
        bt.titleLabel.font = [UIFont systemFontOfSize:14];
        bt.tag = i+20;
       if (i==0) {

         [bt setTitle:@"全部" forState:UIControlStateNormal];
         [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          bt.productButtonId =self.childProduct.secondProductId;
           [bt setBackgroundImage:backImage forState:UIControlStateNormal];
           bt.hasSelected = YES;
           self.categoryString = self.childProduct.secondProductId;
     
         }else {
            DetailProduct* detailProduct = [self.goodsArray objectAtIndex:i-1];
            bt.productButtonId = detailProduct.detailProductId;
             self.categoryString = detailProduct.detailProductId;
             [bt setTitle:detailProduct.detailProductTitle forState:UIControlStateNormal];
             [bt setTitleColor:UIColorFromRGB(76.0, 76.0, 74.0) forState:UIControlStateNormal];
             bt.hasSelected = NO;
        }
        X+=80.0;
        [bt addTarget:self action:@selector(filterGoodsMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonsArray addObject:bt];
        [self.showView addSubview:bt];
    }
    
}
- (void)filterGoodsMethod:(ProductButton*)bt
{
    UIImage* backImage = [UIImage imageNamed:@"menuselected.png"];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt setBackgroundImage:backImage forState:UIControlStateNormal];
    bt.hasSelected = YES;
    for (ProductButton* button in self.buttonsArray) {
        
        if (button.hasSelected ==YES)
        {
            if (![button isEqual:bt]) {
                
                button.hasSelected = NO;
                [button setBackgroundImage:nil forState:UIControlStateNormal];
                [button setTitleColor:UIColorFromRGB(76.0, 76.0, 74.0) forState:UIControlStateNormal];
            }else {
                button.hasSelected = YES;
                [button setBackgroundImage:backImage forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(hideFilterSubmenu)]) {
        
        [self.delegate hideFilterSubmenu];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectProduct: categoryString:)]) {
            
            [self.delegate didSelectProduct:bt categoryString:self.categoryString];
            
        }
    }
}

- (void)maskPressed:(UITapGestureRecognizer *)tapGestureRecognizer
{
    NSLog(@"maskPressed");
    if (self.delegate && [self.delegate respondsToSelector:@selector(hideFilterSubmenu)]) {
        
        [self.delegate hideFilterSubmenu];
        
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
