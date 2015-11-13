//
//  RBCustomDatePickerView.h
//  RBCustomDateTimePicker
//  e-mail:rbyyy924805@163.com
//  Created by renbing on 3/17/14.
//  Copyright (c) 2014 renbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXSCycleScrollView.h"

typedef void (^DateCallBack) (NSString *date); //Block

@interface RBCustomDatePickerView : UIView <MXSCycleScrollViewDatasource,MXSCycleScrollViewDelegate>
{
    DateCallBack callBack;
}

- (id)initWithFrame:(CGRect)frame block:(DateCallBack)block;

-(void)reloadData;
@end
