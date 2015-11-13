//
//  cardRecognizedData.h
//  Recognize4IOS
//
//  Created by sandy on 14/12/10.
//
//

#import <Foundation/Foundation.h>

typedef enum{eCardNameItem,eCardSurNameItem,eCardPostNameItem,eCardJobTelephoneItem,eCardHomeTelephoneItem,eCardFaxItem,
    eCardMobileItem,eCardMailItem,eCardURLItem,eCardTitleItem,eCardCompanyItem,eCardAddressItem,eCardPostcodeItem,eCardNoteItem,eCardAgeItem,eCardDepartmentItem,eCardDateItem,eCardBirthDayItem,eCardImage,eCardImageNeedReverse,eCardMaxItem}eCardRecognizedItem;
@interface cardPair: NSObject

@property (nonatomic,strong) NSString* strText;
@property (nonatomic,strong)NSData* imageData ;

@end

@protocol cardSDKProtocol<NSObject>
@optional
-(void)setRecognizedData:(NSMutableDictionary*)pRecognizedData;
@end