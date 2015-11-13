//
//  FourTableViewCell.m
//  CRM
//
//  Created by 马峰 on 14-11-27.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "FourTableViewCell.h"

@interface FourTableViewCell()
@property(nonatomic,strong) UIImageView* avatorImageView;
@property(nonatomic,strong) UILabel* countLabel;


@end

@implementation FourTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setcellInfomation:(NSArray*)dataArray indexPath:(NSIndexPath*)indexPath
{
    NSArray* subview = self.contentView.subviews;
    for (UIView* view in subview) {
        if ([view isKindOfClass:[UILabel class]]) {
            
            [view removeFromSuperview];
        }
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row %2 ==0 && indexPath.row !=0) {
        
        UIView* view = [[UIView alloc]init];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.15;
        self.backgroundView = view;
    }
    if (indexPath.row ==1) {
    
        UIImage* firstImage = [UIImage imageNamed:@"first.png"];
        self.avatorImageView = [[UIImageView alloc]init];
        self.avatorImageView.frame = CGRectMake(10, 15.0, firstImage.size.width/2.0, firstImage.size.height/2.0);
        self.avatorImageView.image = firstImage;
        [self.contentView addSubview:self.avatorImageView];
        
        self.countLabel = [[UILabel alloc]init];
        self.countLabel.frame = CGRectMake(17, 7,10, 40);
        self.countLabel.textColor = [UIColor colorWithRed:255.0/255 green:45.0/255 blue:5.0/255 alpha:1.0];
        self.countLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
        [self.contentView addSubview:self.countLabel];
        
        
    }else if (indexPath.row ==2){
        UIImage* secondImage = [UIImage imageNamed:@"second.png"];
        self.avatorImageView = [[UIImageView alloc]init];
        self.avatorImageView.frame = CGRectMake(10, 12.0, secondImage.size.width/2.0, secondImage.size.height/2.0);
        self.avatorImageView.image = secondImage;
        [self.contentView addSubview:self.avatorImageView];
        
        self.countLabel = [[UILabel alloc]init];
        self.countLabel.frame = CGRectMake(17, 4,10, 40);
        self.countLabel.textColor = [UIColor colorWithRed:255.0/255 green:147.0/255 blue:11.0/255 alpha:1.0];
        self.countLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
        [self.contentView addSubview:self.countLabel];
    
    }else if (indexPath.row ==3){
        UIImage* threeImage = [UIImage imageNamed:@"three.png"];
        self.avatorImageView = [[UIImageView alloc]init];
        self.avatorImageView.frame = CGRectMake(10, 12.0, threeImage.size.width/2.0, threeImage.size.height/2.0);
        self.avatorImageView.image = threeImage;
        [self.contentView addSubview:self.avatorImageView];
        self.countLabel = [[UILabel alloc]init];
        self.countLabel.frame = CGRectMake(17, 4,10, 40);
        self.countLabel.textColor = [UIColor colorWithRed:255.0/255 green:210.0/255 blue:0.0/255 alpha:1.0];
        self.countLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
        [self.contentView addSubview:self.countLabel];
    }else {
        
        UIImage* fourImage = [UIImage imageNamed:@"four.png"];
        self.avatorImageView = [[UIImageView alloc]init];
        self.avatorImageView.frame = CGRectMake(10, 12.0, fourImage.size.width/2.0, fourImage.size.height/2.0);
        self.avatorImageView.image = fourImage;
        [self.contentView addSubview:self.avatorImageView];
        self.countLabel = [[UILabel alloc]init];
        self.countLabel.frame = CGRectMake(17, 4,10, 40);
        if (indexPath.row ==10) {
            self.countLabel.frame = CGRectMake(13, 4,16, 40);
            self.countLabel.font = [UIFont systemFontOfSize:14];
   
        }
        self.countLabel.textColor = [UIColor whiteColor];
        self.countLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
        [self.contentView addSubview:self.countLabel];
    
    }
    
    CGFloat X =0.0;
    UILabel* titleLabel;
    //复制过程
    for (int i =0 ; i <7; i++) {


        NSDictionary* dic = [dataArray objectAtIndex:indexPath.row-1];
        NSString* name = [dic objectForKey:@"name"];
        NSString* addCoustom = [dic objectForKey:@"addcoustom"];
        NSString* jiesong = [dic objectForKey:@"jiesong"];
        NSString* weihu = [dic objectForKey:@"weihu"];
        NSString* xiaoshou = [dic objectForKey:@"xiaoshou"];
        NSString* jixiao = [dic objectForKey:@"score"];
        
         CGSize size;
          titleLabel = [[UILabel alloc]init];
          titleLabel.textColor = [UIColor whiteColor];
         if (i==0) {
             
           size = [name sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
            titleLabel.frame = CGRectMake(100.0+X, 10.0,size.width+10, 30);
            titleLabel.text = name;

            
        }else if(i==1){
            int count = [addCoustom intValue];
            NSString* string =[[NSNumber numberWithInt:count] stringValue];
            size = [string sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
            titleLabel.frame = CGRectMake(100.0+X, 10.0,size.width+10, 30);
            titleLabel.text =string;
            
      }else if (i==2){
          int count = [jiesong intValue];
          NSString* string =[[NSNumber numberWithInt:count] stringValue];
           size = [string sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
            titleLabel.frame = CGRectMake(100.0+X, 10.0,size.width+10, 30);
            titleLabel.text = string;

            
        }else if (i==3){
            int count = [weihu intValue];
            NSString* string =[[NSNumber numberWithInt:count] stringValue];
            size = [string sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
            titleLabel.frame = CGRectMake(100.0+X, 10.0,size.width+10, 30);
            titleLabel.text = string;

        }else if (i==4){
            int count = [xiaoshou intValue];
            NSString* string =[[NSNumber numberWithInt:count] stringValue];
            size = [string sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
            titleLabel.frame = CGRectMake(100.0+X, 10.0,size.width+10, 30);
            titleLabel.text = string;
        }else if (i==5){
            
          
            size = [jixiao sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
            titleLabel.frame = CGRectMake(100.0+X, 10.0,size.width+10, 30);
            titleLabel.text = jixiao;
        }
        
      [self.contentView addSubview:titleLabel];
        
        X+=152.0;
    }
}

@end
