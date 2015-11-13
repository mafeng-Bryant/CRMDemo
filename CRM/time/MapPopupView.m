//
//  MapPopupView.m
//  LeTu
//
//  Created by DT on 14-6-11.
//
//

#import "MapPopupView.h"
#import "RBCustomDatePickerView.h"
#import "DTPickView.h"

@interface MapPopupView()
@property(nonatomic,strong)UIButton *sureButton;
@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)RBCustomDatePickerView *pickerView;
@property(nonatomic,strong)DTPickView *pickView;
@property(nonatomic,strong)NSString *value;
@end

@implementation MapPopupView
@synthesize type = _type;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-250, 320, 250)];
        self.showView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.showView];
        
        self.sureButton = [[UIButton alloc] initWithFrame:CGRectMake(40, self.showView.frame.size.height-50, 95, 33)];
        [self.sureButton setImage:[UIImage imageNamed:@"btn_comfirm_nor"] forState:UIControlStateNormal];
        [self.sureButton setImage:[UIImage imageNamed:@"btn_comfirm_pre"] forState:UIControlStateHighlighted];
        self.sureButton.tag = 1;
        [self.sureButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.showView addSubview:self.sureButton];
        
        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(180, self.showView.frame.size.height-50, 95, 33)];
        [self.cancelButton setImage:[UIImage imageNamed:@"btn_concel_nor"] forState:UIControlStateNormal];
        [self.cancelButton setImage:[UIImage imageNamed:@"btn_concel_pre"] forState:UIControlStateHighlighted];
        self.cancelButton.tag = 2;
        [self.cancelButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.showView addSubview:self.cancelButton];
        
    }
    return self;
}
-(void)clickButton:(UIButton*)button
{
    if (button.tag==1) {//确定
        if (self.callBack) {
            self.callBack(_type,1,self.value);
        }
    }else if (button.tag==2){//取消
        if (self.callBack) {
            self.callBack(0,2,@"");
        }
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point=[[touches anyObject] locationInView:self];//触摸点的位置
    if (!CGRectContainsPoint(self.showView.frame, point)) {
//        self.hidden = YES;
        if (self.callBack) {
            self.callBack(0,2,@"");
        }
    }
}
-(void)setType:(int)type
{
    self.pickView.hidden = YES;
    self.pickerView.hidden = YES;
    _type = type;
    if (type==1) {//人数
        if (!self.pickView) {
            self.pickView = [[DTPickView alloc] initWithFrame:CGRectMake(0, 0, 320, self.showView.frame.size.height-50) block:^(NSString *date) {
                self.value = date;
            }];
            [self.showView addSubview:self.pickView];
        }else{
            [self.pickView removeFromSuperview];
             self.pickView = [[DTPickView alloc] initWithFrame:CGRectMake(0, 0, 320, self.showView.frame.size.height-50) block:^(NSString *date) {
                self.value = date;
            }];
            [self.showView addSubview:self.pickView];
        }
        
        self.pickView.hidden = NO;
    }else if (type==2){//时间
        if (!self.pickerView) {
            self.pickerView = [[RBCustomDatePickerView alloc] initWithFrame:CGRectMake(0, 0, 320, self.showView.frame.size.height-50) block:^(NSString *date) {
                self.value = [date substringToIndex:[date length]-3];
            }];
            [self.showView addSubview:self.pickerView];
        }else{
            [self.pickerView removeFromSuperview];
            self.pickerView = [[RBCustomDatePickerView alloc] initWithFrame:CGRectMake(0, 0, 320, self.showView.frame.size.height-50) block:^(NSString *date) {
                self.value = [date substringToIndex:[date length]-3];
            }];
            [self.showView addSubview:self.pickerView];
        }
        self.pickerView.hidden = NO;
    }
}
@end
