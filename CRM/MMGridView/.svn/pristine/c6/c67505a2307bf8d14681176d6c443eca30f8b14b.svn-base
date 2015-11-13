//
// Copyright (c) 2010-2011 René Sprotte, Provideal GmbH
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
// OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import "MMGridViewCell.h"
#import "UrlImageView.h"

@protocol MMGridViewDefaultCellDelegate <NSObject>

@optional

- (void)changeProdectNumber:(NSDictionary *)dic;

@end

@interface MMGridViewDefaultCell : MMGridViewCell 
{
    UILabel *textLabel;
    
    UILabel *sumLable;
    UIView *textLabelBackgroundView;
    UIView *backgroundView;
    
    UIButton *addButton;
    UIButton *reduceButton;

    UIButton *moreButton;

    NSUInteger  labelHeight;
    NSUInteger  labelInset;
    NSUInteger  sum;
    
    UrlImageView *urlImage;
    UILabel *subscriberLable;
    UILabel *nameLable;
    
    UILabel *priceLable;
    UILabel *forePriceLable;
    NSDictionary *dataDict;
    NSString *catalogName;
    id<MMGridViewDefaultCellDelegate>delegate;
}

@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, retain) UILabel *sumLable;
@property (nonatomic, retain) UIView *textLabelBackgroundView;
@property (nonatomic, retain) UIView *backgroundView;
@property (nonatomic, retain) UIButton *addButton;
@property (nonatomic, retain) UIButton *reduceButton;
@property (nonatomic, retain) UIButton *moreButton;
@property (nonatomic, retain) UrlImageView *urlImage;
@property (nonatomic, assign) NSUInteger  sum;
@property (nonatomic, copy) NSString *catalogName;

@property (nonatomic, retain) id<MMGridViewDefaultCellDelegate>delegate;

- (void) setUpCellData:(NSDictionary *)dict;

@end
