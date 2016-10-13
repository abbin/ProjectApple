//
//  PAConstants.h
//  ProjectApple
//
//  Created by Abbin Varghese on 29/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

@interface PAConstants : NSObject

FOUNDATION_EXPORT NSString *const kPACurrentLocationKey;

FOUNDATION_EXPORT NSString *const kPALocationShortNameKey;
FOUNDATION_EXPORT NSString *const kPALocationLatitudeKey;
FOUNDATION_EXPORT NSString *const kPALocationLongitudeKey;
FOUNDATION_EXPORT NSString *const kPALocationFullNameKey;

FOUNDATION_EXPORT NSString *const kPAItemsClassNameKey;
FOUNDATION_EXPORT NSString *const kPAItemCappedNameKey;
FOUNDATION_EXPORT NSString *const kPACuisineClassNameKey;
FOUNDATION_EXPORT NSString *const kPARestaurantClassNameKey;
FOUNDATION_EXPORT NSString *const kPARestaurantCappedNameKey;
@end
