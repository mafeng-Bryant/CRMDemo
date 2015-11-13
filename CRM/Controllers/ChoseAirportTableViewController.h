//
//  ChoseAirportTableViewController.h
//  CRM
//
//  Created by 马峰 on 15-1-7.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChoseAirportclickIndexPathRowDelegate <NSObject>

- (void)ChoseAirportclickIndexPath:(NSString*)string titleString:(NSString*)title type:(NSString*)airportType;


@end

@interface ChoseAirportTableViewController : UITableViewController
@property(nonatomic,strong) id<ChoseAirportclickIndexPathRowDelegate> choseAirportDelegate;
@property(nonatomic,strong) NSString* airportType;


@end
