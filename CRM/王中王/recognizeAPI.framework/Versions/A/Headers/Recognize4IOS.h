//
//  Recognize4IOS.h
//  Recognize4IOS
//
//  Created by zheng hongjun on 11/7/13.
//
//

#import <Foundation/Foundation.h>
#import "cardRecognizedData.h"
@interface Recognize4IOS : NSObject
+(void)startRecognize:(UINavigationController*)navController image:(UIImage*)pImage pushController:(UIViewController*)pPushController;
//if pImage is NULL, need take photo, otherwise directly recognize
@end
