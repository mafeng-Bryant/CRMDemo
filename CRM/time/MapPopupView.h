//
//  MapPopupView.h
//  LeTu
//
//  Created by DT on 14-6-11.
//
//

#import <UIKit/UIKit.h>

/**
 *  拼车选择View
 */
@interface MapPopupView : UIView

@property(nonatomic,strong)UIView *showView;

/**
 *  类型 1:人数 2:时间
 */
@property(nonatomic,assign)int type;
/**
 *  回调函数
 *  type 类型 1:人数 2:时间
 *  status 状态 1:确定 2:取消、背景
 *  value 返回值
 */
@property(strong , nonatomic) void (^callBack) (int type,int status,NSString *value);

@end
