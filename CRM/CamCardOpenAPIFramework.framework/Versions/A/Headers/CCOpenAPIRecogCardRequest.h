//
//  CCOpenAPIRecogCardRequest.h
//  CCOpenAPIFramework
//
//  Copyright (c) 2013 IntSig Information Co., Ltd. All rights reserved.
//

#import "CCOpenAPIRequest.h"
/*!
 
 @class CCOpenAPIRecogCardRequest
 @abstract If you want to recognize a business card, you could send a request of this type to CamCard.
 NOTE:
 1. Init: you must call "init" to create this type request.
 2. You must assign a value to "CCAppVersion"
 3. If you need to, you could assign a value to these attributes(appKey, cardImage, needShowEditInterface, needSaveInCardHolder, supportLangs)
 */
@interface CCOpenAPIRecogCardRequest : CCOpenAPIRequest

/*!
 
 @attribute cardImage: assign a business card image. If it does not be assigned, CamCard will open it own camera to take a card image when it is opened with this request.
 */
@property (nonatomic, retain) UIImage *cardImage;

/*!
 
 @attribute needSaveInCardHolder: indicate whether the business card from your app need save in CamCard.
 The default value is YES.
 */
@property (nonatomic, assign) BOOL needSaveInCardHolder;

/*!
 
 @attribute supportLangs: if supportLangs is nil or empty, it means that use language setting in camcard. if contains "BCRLanguage_All", it means that support all language.
 It could contain any BCRLanguage string value defined in CCOpenAPICommon.h.
 */
@property (nonatomic, retain) NSMutableDictionary *recognizeLanguageDictionary;

- (void) addRecognizeLanguage:(NSString *) supportLang;
- (void) addRecognizeLanguagesFromArray:(NSArray *) languageArray;

@end
