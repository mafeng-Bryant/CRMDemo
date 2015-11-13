//
//  JsonMa.m
//  CRM
//
//  Created by 马峰 on 14-12-3.
//  Copyright (c) 2014年 马峰. All rights reserved.
//

#import "JsonMa.h"
#import "Product.h"
#import "ChildProduct.h"
#import "DetailProduct.h"


@implementation JsonMa
- (BOOL)jsonOk:(NSArray*)jsonArray
{
    Product* product = [jsonArray objectAtIndex:0];
    NSLog(@"%@",product.commendTitle);
    NSLog(@"%@",product.comendProductId);
    NSLog(@"arr = %@",product.childArray);
    NSLog(@"arr count = %d",product.childArray.count);
    for (ChildProduct* childDuct in product.childArray) {
        
        NSLog(@"child id = %@",childDuct.secondProductId);
        NSLog(@"child title = %@",childDuct.secondProductTitle);
        
        if (childDuct.secondChildArray.count > 0) {
            
            NSLog(@"%d",childDuct.secondChildArray.count);
            NSLog(@"%@",childDuct.secondChildArray);
            for (DetailProduct* detailPt in childDuct.secondChildArray) {
                
                NSLog(@"detailPt id = %@",detailPt.detailProductId);
                NSLog(@"detailPt title = %@",detailPt.detailProductTitle);
            }
            
        }
    }
      return YES;
    
}
@end
