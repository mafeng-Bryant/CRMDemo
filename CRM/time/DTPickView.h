//
//  DTPickView.h
//  LeTu
//
//  Created by DT on 14-6-12.
//
//

#import <UIKit/UIKit.h>
#import "MXSCycleScrollView.h"

typedef void (^PeopleCallBack) (NSString *date); //Block

@interface DTPickView : UIView <MXSCycleScrollViewDatasource,MXSCycleScrollViewDelegate>
{
    PeopleCallBack callBack;
}

- (id)initWithFrame:(CGRect)frame block:(PeopleCallBack)block;

@end
