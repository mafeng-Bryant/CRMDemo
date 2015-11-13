//
//  CoustomField.h
//  CRM
//
//  Created by 马峰 on 14-11-26.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoustomField : UITextField
- (void)drawPlaceholderInRect:(CGRect)rect;
- (CGRect)leftViewRectForBounds:(CGRect)bounds;
-(CGRect)editingRectForBounds:(CGRect)bounds;
-(CGRect)textRectForBounds:(CGRect)bounds;
-(CGRect)placeholderRectForBounds:(CGRect)bounds;
-(CGRect)clearButtonRectForBounds:(CGRect)bounds;



@end
