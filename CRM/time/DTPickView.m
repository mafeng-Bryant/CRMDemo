//
//  DTPickView.m
//  LeTu
//
//  Created by DT on 14-6-12.
//
//

#import "DTPickView.h"
//颜色和透明度设置
#define RGBA(r,g,b,a)               [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
#define DEFAULT_HEIGHT 105
//const int rowHeight = 40;

@interface DTPickView()
{
    UIView                      *timeBroadcastView;//定时播放显示视图
    MXSCycleScrollView          *yearScrollView;//年份滚动视图
    MXSCycleScrollView          *monthScrollView;//月份滚动视图
    MXSCycleScrollView          *dayScrollView;//日滚动视图
    MXSCycleScrollView          *hourScrollView;//时滚动视图
    MXSCycleScrollView          *minuteScrollView;//分滚动视图
    MXSCycleScrollView          *secondScrollView;//秒滚动视图
    UILabel                     *nowPickerShowTimeLabel;//当前picker显示的时间
    UILabel                     *selectTimeIsNotLegalLabel;//所选时间是否合法
    UIButton                    *OkBtn;//自定义picker上的确认按钮
}
@end

@implementation DTPickView

- (id)initWithFrame:(CGRect)frame block:(PeopleCallBack)block;
{
    self = [super initWithFrame:frame];
    if (self) {
        callBack = block;
        [self setTimeBroadcastView];
    }
    return self;
}
#pragma mark -custompicker
//设置自定义datepicker界面
- (void)setTimeBroadcastView
{
    UIView *middleSepView = [[UIView alloc] initWithFrame:CGRectMake(10, 95, 300, 30)];
    [middleSepView setBackgroundColor:RGBA(50, 161, 245, 1.0)];
    [self addSubview:middleSepView];
    
    nowPickerShowTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(17.0, 115.0-DEFAULT_HEIGHT, 278.5, 18)];
    [nowPickerShowTimeLabel setBackgroundColor:[UIColor clearColor]];
    [nowPickerShowTimeLabel setFont:[UIFont systemFontOfSize:18.0]];
    [nowPickerShowTimeLabel setTextColor:RGBA(51, 51, 51, 1)];
    [nowPickerShowTimeLabel setTextAlignment:NSTextAlignmentCenter];
    nowPickerShowTimeLabel.text = @"人数:1人";
    [self addSubview:nowPickerShowTimeLabel];
    if (callBack) {
        callBack(@"1");
    }
    timeBroadcastView = [[UIView alloc] initWithFrame:CGRectMake(20+18.5, 140-DEFAULT_HEIGHT, 278.5-37, 150.0)];
    timeBroadcastView.layer.masksToBounds = YES;
    [self addSubview:timeBroadcastView];
    
    [self setLineView];
    [self setScrollView];
}
-(void)setScrollView
{
    dayScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 278.5-37, 150.0)];
    [dayScrollView setCurrentSelectPage:4];
    dayScrollView.delegate = self;
    dayScrollView.datasource = self;
    [self setAfterScrollShowView:dayScrollView andCurrentPage:1];
    [timeBroadcastView addSubview:dayScrollView];
}
- (void)setAfterScrollShowView:(MXSCycleScrollView*)scrollview  andCurrentPage:(NSInteger)pageNumber
{
    UILabel *oneLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber];
    [oneLabel setFont:[UIFont systemFontOfSize:14]];
    [oneLabel setTextColor:RGBA(186.0, 186.0, 186.0, 1.0)];
    UILabel *twoLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+1];
    [twoLabel setFont:[UIFont systemFontOfSize:16]];
    [twoLabel setTextColor:RGBA(113.0, 113.0, 113.0, 1.0)];
    
    UILabel *currentLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+2];
    [currentLabel setFont:[UIFont systemFontOfSize:18]];
    [currentLabel setTextColor:[UIColor whiteColor]];
    
    UILabel *threeLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+3];
    [threeLabel setFont:[UIFont systemFontOfSize:16]];
    [threeLabel setTextColor:RGBA(113.0, 113.0, 113.0, 1.0)];
    UILabel *fourLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+4];
    [fourLabel setFont:[UIFont systemFontOfSize:14]];
    [fourLabel setTextColor:RGBA(186.0, 186.0, 186.0, 1.0)];
}
#pragma mark mxccyclescrollview delegate
#pragma mark mxccyclescrollview databasesource
- (NSInteger)numberOfPages:(MXSCycleScrollView*)scrollView
{
    return 6;
}

- (UIView *)pageAtIndex:(NSInteger)index andScrollView:(MXSCycleScrollView *)scrollView
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, scrollView.bounds.size.width, scrollView.bounds.size.height/5)];
    l.tag = index+1;
    l.text = [NSString stringWithFormat:@"%d人",1+index];
    
    l.font = [UIFont systemFontOfSize:12];
    l.textAlignment = NSTextAlignmentCenter;
    l.backgroundColor = [UIColor clearColor];
    return l;
}
//滚动时上下标签显示(当前时间和是否为有效时间)
- (void)scrollviewDidChangeNumber
{
    UILabel *dayLabel = [[(UILabel*)[[dayScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    nowPickerShowTimeLabel.text = [NSString stringWithFormat:@"人数:%@",dayLabel.text];
    if (callBack) {
        callBack([dayLabel.text substringToIndex:[dayLabel.text length]-1]);
    }
}

-(void)setLineView
{
    UIView *lineView = nil;
    lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 35, 300, 1)];
    [lineView setBackgroundColor:RGBA(237.0, 237.0, 237.0, 1.0)];
    [self addSubview:lineView];
    lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 65, 300, 1)];
    [lineView setBackgroundColor:RGBA(237.0, 237.0, 237.0, 1.0)];
    [self addSubview:lineView];
    lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 95, 300, 1)];
    [lineView setBackgroundColor:RGBA(237.0, 237.0, 237.0, 1.0)];
    [self addSubview:lineView];
    lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 125, 300, 1)];
    [lineView setBackgroundColor:RGBA(237.0, 237.0, 237.0, 1.0)];
    [self addSubview:lineView];
    lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 155, 300, 1)];
    [lineView setBackgroundColor:RGBA(237.0, 237.0, 237.0, 1.0)];
    [self addSubview:lineView];
    lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 185, 300, 1)];
    [lineView setBackgroundColor:RGBA(237.0, 237.0, 237.0, 1.0)];
    [self addSubview:lineView];
}
@end
