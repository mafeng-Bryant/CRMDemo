//
//  showViewController.m
//  CRM
//
//  Created by 马峰 on 15-1-10.
//  Copyright (c) 2015年 马峰. All rights reserved.
//

#import "showViewController.h"
#import "CoustomWebViewController.h"
#import "AppDelegate.h"

@interface showViewController ()

@end

@implementation showViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.bt setTitle:@"返回" forState:UIControlStateNormal];
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   

}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
//-(void)setRecognizedData:(NSMutableDictionary*)pRecognizedData
//{
//    NSArray* pKeys = [pRecognizedData allKeys];
//    for (id  key in pKeys)
//    {
//        id obj = [pRecognizedData objectForKey:key];
//        if([obj isKindOfClass:[NSMutableArray class]]){
//            
//            NSLog(@"key = %@",[key debugDescription]);
//            NSMutableArray* pArray = (NSMutableArray*)obj;
//            NSMutableString* string = [NSMutableString string];
//              for (id item in pArray) {
//               NSInteger index = [pArray indexOfObject:item];
//                if([item isKindOfClass:[cardPair class]]){
//                    cardPair* pPair  = (cardPair*)item;
//                    NSLog(@"recognize text %@",pPair.strText);
//                    int keyCount =[key integerValue];
//                    switch (keyCount) {
//                        case 0://名字全称
//                    {
//                        if (pArray.count >1) {
//                            
//                            if (index ==pArray.count-1) {
//                                
//                                [string appendFormat:@"%@",pPair.strText];
//                                [self.dataDic setObject:string forKey:@"NamefFullName"];
//                                }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                            }
//                          }else {
//                        
//                        [self.dataDic setObject:pPair.strText forKey:@"NamefFullName"];
//                        }
//                      break;
//                    }
//                    case 1://姓名
//                    {
//                        if (pArray.count >1) {
//                            
//                            if (index ==pArray.count-1) {
//                                
//                                [string appendFormat:@"%@",pPair.strText];
//                                [self.dataDic setObject:string forKey:@"Name"];
//                            }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                            }
//                          }else {
//                            
//                            [self.dataDic setObject:pPair.strText forKey:@"Name"];
//                          }
//                    break;
//                    }
//                  case 2://名字
//                      {
//                        
//                          if (pArray.count >1) {
//                            if (index ==pArray.count-1) {
//                                  
//                                  [string appendFormat:@"%@",pPair.strText];
//                                  [self.dataDic setObject:string forKey:@"FirstName"];
//                              }else {
//                                  [string appendFormat:@"%@,",pPair.strText];
//                              }
//                          }else {
//                              
//                              [self.dataDic setObject:pPair.strText forKey:@"FirstName"];
//                          }
//                          
//                     break;
//                      }
//                    case 3://工作电话
//                    {
//                        if (pArray.count >1) {
//                            if (index ==pArray.count-1) {
//                                
//                                [string appendFormat:@"%@",pPair.strText];
//                                [self.dataDic setObject:string forKey:@"workTelephoneNumber"];
//                            }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                            }
//                        }else {
//                            
//                            [self.dataDic setObject:pPair.strText forKey:@"workTelephoneNumber"];
//                        }
//                    break;
//                    }
//                    case 4://家庭电话
//                    {
//                        if (pArray.count >1) {
//                            if (index ==pArray.count-1) {
//                                
//                                [string appendFormat:@"%@",pPair.strText];
//                                [self.dataDic setObject:string forKey:@"homeTelephoneNumber"];
//                            }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                            }
//                        }else {
//                            
//                            [self.dataDic setObject:pPair.strText forKey:@"homeTelephoneNumber"];
//                        }
//                        break;
//
//                    }
//                    case 5://工作传真
//                    {
//                        if (pArray.count >1) {
//                            if (index ==pArray.count-1) {
//                                
//                                [string appendFormat:@"%@",pPair.strText];
//                                [self.dataDic setObject:string forKey:@"WorkFaxNumber"];
//                            }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                            }
//                        }else {
//                            
//                            [self.dataDic setObject:pPair.strText forKey:@"WorkFaxNumber"];
//                        }
//                        break;
//            }
//                    case 6://工作手机
//                    {
//                        if (pArray.count >1) {
//                            if (index ==pArray.count-1) {
//                                
//                                [string appendFormat:@"%@",pPair.strText];
//                                [self.dataDic setObject:string forKey:@"WorkMobileNumber"];
//                            }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                            }
//                        }else {
//                            
//                            [self.dataDic setObject:pPair.strText forKey:@"WorkMobileNumber"];
//                        }
//                        break;
//                      
//                    }
//                    case 7://工作邮件
//                    {
//                        if (pArray.count >1) {
//                            if (index ==pArray.count-1) {
//                                
//                                [string appendFormat:@"%@",pPair.strText];
//                                [self.dataDic setObject:string forKey:@"WorkEmail"];
//                            }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                            }
//                        }else {
//                            
//                            [self.dataDic setObject:pPair.strText forKey:@"WorkEmail"];
//                        }
//                        break;
//                 
//                    }
//                    case 8://公司网址
//                    {
//                        if (pArray.count >1) {
//                            if (index ==pArray.count-1) {
//                                
//                                [string appendFormat:@"%@",pPair.strText];
//                                [self.dataDic setObject:string forKey:@"CompanyWebsite"];
//                            }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                            }
//                        }else {
//                            
//                            [self.dataDic setObject:pPair.strText forKey:@"CompanyWebsite"];
//                        }
//                        break;
//             
//                    }
//                    case 9://工作职称
//                    {
//                        if (pArray.count >1) {
//                            if (index ==pArray.count-1) {
//                                
//                                [string appendFormat:@"%@",pPair.strText];
//                                [self.dataDic setObject:string forKey:@"Jobspecific"];
//                            }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                            }
//                        }else {
//                            
//                            [self.dataDic setObject:pPair.strText forKey:@"Jobspecific"];
//                        }
//                        break;
//               
//                    }
//                    case 10://公司名字
//                    {
//                        if (pArray.count >1) {
//                            if (index ==pArray.count-1) {
//                                
//                                [string appendFormat:@"%@",pPair.strText];
//                                [self.dataDic setObject:string forKey:@"CompanyName"];
//                            }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                            }
//                        }else {
//                            
//                            [self.dataDic setObject:pPair.strText forKey:@"CompanyName"];
//                        }
//                        break;
//                
//                    }
//                    case 11://公司地址
//                    {
//                       if (pArray.count >1) {
//                            
//                            if (index ==pArray.count-1) {
//                                
//                                [string appendFormat:@"%@",pPair.strText];
//                                
//                                  [self.dataDic setObject:string forKey:@"CompanyAddress"];
//                                
//                            }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                                
//                            }
//                        }else {
//                            
//                            [self.dataDic setObject:pPair.strText forKey:@"CompanyAddress"];
//
//                            
//                        }
//                     break;
//                        
//                    }
//                    case 12://公司地址邮编
//                    {
//                        if (pArray.count >1) {
//                            if (index ==pArray.count-1) {
//                                
//                                [string appendFormat:@"%@",pPair.strText];
//                                [self.dataDic setObject:string forKey:@"CompanyAddressCode"];
//                            }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                            }
//                        }else {
//                            
//                            [self.dataDic setObject:pPair.strText forKey:@"CompanyAddressCode"];
//                        }
//                        break;
//              
//                    }
//                    case 13://备注
//                    {
//                        
//                     if (pArray.count >1) {
//                           
//                            if (index ==pArray.count-1) {
//                                [string appendFormat:@"%@",pPair.strText];
//                                 [self.dataDic setObject:string forKey:@"Remark"];
//                            }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                            }
//            
//                        }else {
//                            
//                            [self.dataDic setObject:pPair.strText forKey:@"Remark"];
//                        }
//                        break;
//                    }
//                    case 14://年龄
//                    {
//                        if (pArray.count >1) {
//                            if (index ==pArray.count-1) {
//                                
//                                [string appendFormat:@"%@",pPair.strText];
//                                [self.dataDic setObject:string forKey:@"Age"];
//                            }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                            }
//                        }else {
//                            
//                            [self.dataDic setObject:pPair.strText forKey:@"Age"];
//                        }
//                        break;
//                
//                    }
//                    case 15://公司部门
//                    {
//                        if (pArray.count >1) {
//                            if (index ==pArray.count-1) {
//                                
//                                [string appendFormat:@"%@",pPair.strText];
//                                [self.dataDic setObject:string forKey:@"companyDepartMent"];
//                            }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                            }
//                        }else {
//                            
//                            [self.dataDic setObject:pPair.strText forKey:@"companyDepartMent"];
//                        }
//                        break;
//                     
//                    }
//                    case 16://出生年月
//                    {
//                        if (pArray.count >1) {
//                            if (index ==pArray.count-1) {
//                                
//                                [string appendFormat:@"%@",pPair.strText];
//                                [self.dataDic setObject:string forKey:@"YearofBirth"];
//                            }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                            }
//                        }else {
//                            
//                            [self.dataDic setObject:pPair.strText forKey:@"YearofBirth"];
//                        }
//                        break;
//               
//                    }
//                    case 17://出生日期
//                    {
//                        
//                        if (pArray.count >1) {
//                            if (index ==pArray.count-1) {
//                                
//                                [string appendFormat:@"%@",pPair.strText];
//                                [self.dataDic setObject:string forKey:@"BirthDate"];
//                            }else {
//                                [string appendFormat:@"%@,",pPair.strText];
//                            }
//                        }else {
//                            
//                            [self.dataDic setObject:pPair.strText forKey:@"BirthDate"];
//                        }
//                        break;
//              
//                     }
//                    default:
//                        break;
//                    }
//                    
//                }
//            }
//            
//     }
//        else if([obj isKindOfClass:[NSNumber class]]){
//            NSNumber* pNumber = (NSNumber *)obj;
//      NSLog(@"determine if the image need reverse, %d",[pNumber boolValue]);
//        }
//        else if([obj isKindOfClass:[UIImage class]]){
//            NSLog(@"the captured card image");
//        }
//    }
//    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(sendMessageWithDic:)]) {
//        
//        [self.delegate sendMessageWithDic:self.dataDic];
//    }
//    
//}
- (IBAction)back:(id)sender {
    
    NSArray* arr = self.navigationController.viewControllers;
    
    CoustomWebViewController* VC = (CoustomWebViewController*)[arr objectAtIndex:1];
    [self.navigationController popToViewController:VC animated:YES];
    
}
@end
