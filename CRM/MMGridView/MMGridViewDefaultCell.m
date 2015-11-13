//
// Copyright (c) 2010-2011 René Sprotte, Provideal GmbH
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
// OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#define K_DEFAULT_LABEL_HEIGHT  30
#define K_DEFAULT_LABEL_INSET   5

#import "MMGridViewDefaultCell.h"
#import "OrderHomeViewController.h"
#import "MorePiciListViewController.h"

#import "DetailProduct.h"



@implementation MMGridViewDefaultCell

@synthesize textLabel;
@synthesize sumLable;
@synthesize textLabelBackgroundView;
@synthesize backgroundView;
@synthesize addButton,reduceButton,moreButton;
@synthesize delegate;
@synthesize sum;
@synthesize catalogName;
@synthesize urlImage;

- (void)dealloc
{
    [textLabel release];
    [textLabelBackgroundView release];
    [backgroundView release];
    [addButton release];
    [reduceButton release];
    [sumLable release];
//    [urlImage release];
    [moreButton release];
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) {
        // Background view
        self.backgroundView = [[[UIView alloc] initWithFrame:CGRectNull] autorelease];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundView];
        
        UIImageView *im_line = [[[UIImageView alloc]initWithFrame:CGRectMake(10, 190, 243, 1)] autorelease];
        im_line.image = [UIImage imageNamed:@"img32"];
        [self.backgroundView addSubview:im_line];
        
        self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        [self.addButton addTarget:self action:@selector(btn_add_click:) forControlEvents:UIControlEventTouchUpInside];
        [self.addButton setFrame:CGRectMake(220, 200, 33, 33)];
        [self.backgroundView addSubview:self.addButton];
        
        self.reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.reduceButton setImage:[UIImage imageNamed:@"img11"] forState:UIControlStateNormal];
        [self.reduceButton addTarget:self action:@selector(btn_reduce_click:) forControlEvents:UIControlEventTouchUpInside];
        [self.reduceButton setFrame:CGRectMake(120, 200, 33, 33)];
        [self.backgroundView addSubview:self.reduceButton];

        UIImageView *im_blank = [[[UIImageView alloc]initWithFrame:CGRectMake(163, 201, 50, 28)] autorelease];
        im_blank.image = [UIImage imageNamed:@"img13"];
        [self.backgroundView addSubview:im_blank];
        
        self.sumLable = [[[UILabel alloc] initWithFrame:CGRectMake(163, 203, 50, 28)] autorelease];
        self.sumLable.textAlignment = NSTextAlignmentCenter;
        self.sumLable.backgroundColor = [UIColor clearColor];
        self.sumLable.textColor = [UIColor darkGrayColor];
        self.sumLable.font = [UIFont systemFontOfSize:12];
        [self.backgroundView addSubview:self.sumLable];
        
        urlImage = [[[UrlImageView alloc] initWithFrame:CGRectMake(9, 9, 243, 147)] autorelease];
       // urlImage.image = [UIImage imageNamed:@"cell-image.png"];
        [self.backgroundView addSubview:urlImage];

        subscriberLable = [[[UILabel alloc] initWithFrame:CGRectMake(0, 113, 243, 34)] autorelease];
        subscriberLable.textAlignment = NSTextAlignmentLeft;
        subscriberLable.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.35];
        subscriberLable.textColor = [UIColor whiteColor];
        subscriberLable.font = [UIFont systemFontOfSize:14];
        [urlImage addSubview:subscriberLable];

        nameLable = [[[UILabel alloc] initWithFrame:CGRectMake(10, 162, 150, 22)] autorelease];
        nameLable.textAlignment = NSTextAlignmentLeft;
        nameLable.backgroundColor = [UIColor clearColor];
        nameLable.textColor = [UIColor blackColor];
        nameLable.font = [UIFont systemFontOfSize:15];
        [self.backgroundView addSubview:nameLable];
        
        priceLable = [[[UILabel alloc] initWithFrame:CGRectMake(10, 205,105, 22)] autorelease];
        priceLable.textAlignment = NSTextAlignmentLeft;
        priceLable.backgroundColor = [UIColor clearColor];
        priceLable.textColor = dayiColor;
        priceLable.font = [UIFont systemFontOfSize:15];
        [self.backgroundView addSubview:priceLable];
        
        
        forePriceLable = [[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(priceLable.frame)-40, 205,105, 22)] autorelease];
        forePriceLable.textAlignment = NSTextAlignmentLeft;
        forePriceLable.backgroundColor = [UIColor clearColor];
        forePriceLable.textColor = [UIColor lightGrayColor];
        forePriceLable.font = [UIFont systemFontOfSize:15];
        [self.backgroundView addSubview:forePriceLable];
    }
     return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    labelHeight = K_DEFAULT_LABEL_HEIGHT;
    labelInset = K_DEFAULT_LABEL_INSET;
  
    // Background view
    self.backgroundView.frame = CGRectMake(0, 0, 262, 242);
    self.bounds = CGRectMake(0, 0, 262, 242);
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (IBAction)btn_add_click:(id)sender
{
    sum++;
    self.sumLable.text = [NSString stringWithFormat:@"%d",sum];
    [self changeProdectNumber];
}

- (IBAction)btn_reduce_click:(id)sender
{
    if (sum != 0) {
        sum--;
        self.sumLable.text = [NSString stringWithFormat:@"%d",sum];
        [self changeProdectNumber];

    }
}
- (void) setUpCellData:(DetailProduct *)dict
{
    self.detailProduct = dict;

    NSString* imageurl = [BASE_URL stringByAppendingString:self.detailProduct.FStoreAvatarImageId];
    [urlImage setImageFromUrl:YES withUrl:[BASE_URL stringByAppendingString:self.detailProduct.FStoreAvatarImageId]];
    
    if ([self.detailProduct.goodDescration length]) {
        subscriberLable.text =[NSString stringWithFormat:@" %@",self.detailProduct.goodDescration];
    }
    else{
        subscriberLable.hidden = YES;
    }
    
   
    nameLable.text = [NSString stringWithFormat:@"%@",self.detailProduct.detailProductTitle];

    priceLable.text = [NSString stringWithFormat:@"￥%@/%@",[self.detailProduct.priceNumber stringValue],self.detailProduct.fUnit];
  // forePriceLable.text = [NSString stringWithFormat:@"%@",@124];
    self.sumLable.text = [NSString stringWithFormat:@"%d",sum];
    
//    if ([catalogName integerValue] != 4) {
//        self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.moreButton setImage:[UIImage imageNamed:@"img35"] forState:UIControlStateNormal];
//        [self.moreButton addTarget:self action:@selector(btn_more_click:) forControlEvents:UIControlEventTouchUpInside];
//        [self.moreButton setFrame:CGRectMake(180, 157, 77, 28)];
//        [self.backgroundView addSubview:self.moreButton];
//    }
}

- (void)changeProdectNumber
{
    if (delegate && [delegate respondsToSelector:@selector(changeProdectNumber:)]) {
        
         self.detailProduct.clickCount = sum;
        
        
       // NSDictionary *dic = @{@"productName": [dataDict objectForKey:@"productName"],@"productId":[dataDict objectForKey:@"productId"],@"number":[NSString stringWithFormat:@"%d",sum],@"storePrice":[dataDict objectForKey:@"storePrice"]};
     //   NSDictionary* productDic =@{@"productName": self.detailProduct.detailProductTitle,@"productId":self.detailProduct.detailProductId,@"number":[NSString stringWithFormat:@"%d",sum],@"storePrice":@"23"};
        [delegate changeProdectNumber:self.detailProduct];
    }
}

- (void)btn_more_click:(id)sender
{
//    MorePiciListViewController *ctrl = [[MorePiciListViewController alloc] initWithStyle:UITableViewStyleGrouped];
//    
//    ctrl.productName = [dataDict objectForKey:@"productName"];
//    HomeViewController *home = (HomeViewController *)delegate;
//    ctrl.delegate = home;
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ctrl];
//    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"img29"]forBarMetrics:UIBarMetricsDefault];
//    [home.navigationController presentViewController:nav animated:YES completion:nil];
}
@end
