//
//  DTTableView.m
//  tableViewDemo
//
//  Created by DT on 14-6-6.
//  Copyright (c) 2014年 DT. All rights reserved.
//

#import "DTTableView.h"

@interface DTTableView()
{
    NSMutableArray *_tableArray;
//    NSMutableArray *_firstArray;
//    NSMutableArray *_moreArray;
}
@end

@implementation DTTableView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pageNumber = 0;
        self.pages = 20;
        _tableArray = [[NSMutableArray alloc] init];
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        self.separatorColor = [UIColor clearColor];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.pageNumber = 0;
        self.pages = 20;
        _tableArray = [[NSMutableArray alloc] init];
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        self.separatorColor = [UIColor clearColor];
    }
    return self;
}

-(void)addFirstArray:(NSMutableArray *)array
{
    [_tableArray removeAllObjects];
    _tableArray = array;
    [self reloadData];
}

-(void)addMoreArray:(NSMutableArray *)array
{
//    self.footerHidden = YES;
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:[self.tableArray count]-1 inSection:0], nil];
    
    int index = (int)[_tableArray count];
    NSMutableArray * indexPathArray = [NSMutableArray arrayWithCapacity:[array count]];
    [_tableArray addObjectsFromArray:array];
    for(int i=index ;i<[_tableArray count];i++){
        [indexPathArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [self beginUpdates];
    [self insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
    [self endUpdates];
    
    [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

-(NSMutableArray*)tableArray
{
    return _tableArray;
}
@end
