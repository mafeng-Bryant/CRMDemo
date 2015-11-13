//
//  DTTableView.h
//  tableViewDemo
//
//  Created by DT on 14-6-6.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+MJRefresh.h"

@interface DTTableView : UITableView
/**
 *  页码
 */
@property(nonatomic,assign)int pageNumber;
/**
 *  页数
 */
@property(nonatomic,assign)int pages;

/**
 *  数组集合
 */
@property(nonatomic,strong,readonly)NSMutableArray *tableArray;

/**
 *  第一次添加数据
 *
 *  @param array
 */
-(void)addFirstArray:(NSMutableArray*)array;

/**
 *  加载更多数据
 *
 *  @param array 
 */
-(void)addMoreArray:(NSMutableArray*)array;

@end
