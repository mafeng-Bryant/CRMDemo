//
//  BECheckBox.h
//
//  Created by jordenwu-Mac on 10-11-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface BECheckBox : UIButton {
	BOOL isChecked;
	id target;
	SEL fun;
}
@property (nonatomic,assign) BOOL isChecked;

-(IBAction) checkBoxClicked:(id)sender;
-(void)setTarget:(id)tar fun:(SEL )ff;
@end