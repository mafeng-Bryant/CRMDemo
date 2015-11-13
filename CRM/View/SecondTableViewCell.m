//
//  SecondTableViewCell.m
//  CRM
//
//  Created by 马峰 on 14-11-27.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "SecondTableViewCell.h"

@implementation SecondTableViewCell

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

- (void)setcellInfomation:(NSArray*)dataArray indexPath:(NSIndexPath*)indexPath
{
    NSArray* titleArray = @[@"新增客户数",@"接送机数",@"维护客户数",@"销售业绩"];
    CGFloat X =0.0;
    UILabel* titleLabel;
      for (int i = 0; i< 8; i++)
      {

          NSDictionary* dic = [dataArray objectAtIndex:indexPath.row-1];
          NSString* subject = [dic objectForKey:@"subject"];//标题名称,科目
          NSString* companymubiao = [dic objectForKey:@"cGoal"];//公司目标
          NSString* coustommubiao = [dic objectForKey:@"pGoal"];//个人目标
          NSString* todayFinshed = [dic objectForKey:@"finish"];//今日完成 或者 本月完成
          NSString* hasfinshPercent = [dic objectForKey:@"rate"];//完成率
          NSString* companyjixiao = [dic objectForKey:@"cPerformanceGoal"];//公司目标绩效
          NSString* coustommjixiao = [dic objectForKey:@"pPerformanceGoal"];//个人目标绩效
          NSString* shijiticheng = [dic objectForKey:@"actualPerformance"];//实际绩效提成

        NSString* titleString = titleArray[indexPath.row-1];
        CGSize size = [titleString sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
         titleLabel = [[UILabel alloc]init];
          
          if (indexPath.row ==2 || indexPath.row ==4) {
              
              
              if (i==0) {
                  
                  titleLabel.frame = CGRectMake(3+X, 12,70, 20);
                  titleLabel.text = subject;
                  
              }else {
                  if (i==1) {
                      
                      titleLabel.frame = CGRectMake(5+X+70*i, 12,size.width, 20);
                      int count = [companymubiao intValue];
                      titleLabel.text =[[NSNumber numberWithInt:count] stringValue];
                      
                  }else if (i==2){
                      titleLabel.frame = CGRectMake(12+X+70*i, 12,size.width, 20);
                      int count = [coustommubiao intValue];
                      titleLabel.text =[[NSNumber numberWithInt:count] stringValue];
                      self.backGroundView = [[UIView alloc]init];
                      self.backGroundView.backgroundColor = [UIColor blackColor];
                      self.backGroundView.alpha = 0.15;
                      
                      
                  }else if (i==3){
                      
                      titleLabel.frame = CGRectMake(30+X+70*i, 12,size.width, 20);
                      int count = [todayFinshed intValue];
                      titleLabel.text =[[NSNumber numberWithInt:count] stringValue];
                  }else if (i==4){
                      
                      titleLabel.frame = CGRectMake(20+X+70*i, 12,size.width, 20);
                      float count = [hasfinshPercent floatValue]*100;
                      
                     titleLabel.text =[NSString stringWithFormat:@"%@%%",[[NSNumber numberWithFloat:count] stringValue]];
                  }else if (i==5){
                      
                      titleLabel.frame = CGRectMake(50+X+70*i, 12,size.width, 20);
                      int count = [companyjixiao intValue];
                      titleLabel.text =[[NSNumber numberWithInt:count] stringValue];
                      
                  }else if (i==6){
                      titleLabel.frame = CGRectMake(90+X+70*i, 12,size.width, 20);
                      int count = [coustommjixiao intValue];
                      titleLabel.text =[[NSNumber numberWithInt:count] stringValue];
                  }else if (i==7){
                      titleLabel.frame = CGRectMake(130+X+70*i, 12,size.width, 20);
                      int count = [shijiticheng intValue];
                      titleLabel.text =[[NSNumber numberWithInt:count] stringValue];
                  }
              }
              
              titleLabel.textColor = [UIColor whiteColor];
              titleLabel.font = [UIFont systemFontOfSize:14.0];
              [self.contentView addSubview:titleLabel];
              
              X+=30.0;
              
              
          }else {
              
              if (i==0) {
                  
                  titleLabel.frame = CGRectMake(3+X, 17,70, 20);
                  titleLabel.text = subject;
                  
              }else {
                  if (i==1) {
                      
                      titleLabel.frame = CGRectMake(5+X+70*i, 17,size.width, 20);
                      
                      int count = [companymubiao intValue];
                      titleLabel.text =[[NSNumber numberWithInt:count] stringValue];
                      
                  }else if (i==2){
                      titleLabel.frame = CGRectMake(12+X+70*i, 17,size.width, 20);
                      
                      int count = [coustommubiao intValue];
                      titleLabel.text =[[NSNumber numberWithInt:count] stringValue];
                      self.backGroundView = [[UIView alloc]init];
                      self.backGroundView.backgroundColor = [UIColor blackColor];
                      self.backGroundView.alpha = 0.15;
                      
                      
                  }else if (i==3){
                      
                      titleLabel.frame = CGRectMake(30+X+70*i, 17,size.width, 20);
                      int count = [todayFinshed intValue];
                      titleLabel.text =[[NSNumber numberWithInt:count] stringValue];
                      
                  }else if (i==4){
                      
                      titleLabel.frame = CGRectMake(20+X+70*i, 17,size.width, 20);
                      float count = [hasfinshPercent floatValue]*100;
                      
                      titleLabel.text =[NSString stringWithFormat:@"%@%%",[[NSNumber numberWithFloat:count] stringValue]];
                      
                      
                  }else if (i==5){
                      
                      titleLabel.frame = CGRectMake(50+X+70*i, 17,size.width, 20);
                      int count = [companyjixiao intValue];
                      titleLabel.text =[[NSNumber numberWithInt:count] stringValue];
                      
                  }else if (i==6){
                      titleLabel.frame = CGRectMake(90+X+70*i, 17,size.width, 20);
                      int count = [coustommjixiao intValue];
                      titleLabel.text =[[NSNumber numberWithInt:count] stringValue];
                      
                  }else if (i==7){
                      titleLabel.frame = CGRectMake(130+X+70*i, 17,size.width, 20);
                      int count = [shijiticheng intValue];
                      titleLabel.text =[[NSNumber numberWithInt:count] stringValue];
                      
                  }
              }
              
              titleLabel.textColor = [UIColor whiteColor];
              titleLabel.font = [UIFont systemFontOfSize:14.0];
              [self.contentView addSubview:titleLabel];
              
              X+=30.0;
          
          }
          
        
        }
}


- (void)layoutSubviews{
 
    [super layoutSubviews];
    
 //   self.contentView.frame = CGRectMake(0, 0, 1024-60*2, 36);
    
    
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
