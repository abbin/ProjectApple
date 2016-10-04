//
//  PAItem.h
//  ProjectApple
//
//  Created by Abbin Varghese on 04/10/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import <Parse/Parse.h>
#import "PARestaurant.h"
#import "PACuisine.h"
#import "PAUser.h"

@interface PAItem : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *itemCappedName;
@property (nonatomic, strong) NSNumber *itemPrice;
@property (nonatomic, strong) NSNumber *itemRating;
@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, strong) NSString *itemCurrency;
@property (nonatomic, strong) NSString *itemCurrencySymbol;

@property (nonatomic, strong) NSString *itemRestaurantName;
@property (nonatomic, strong) NSString *itemUserName;

@property (nonatomic, strong) PARestaurant *itemRestaurant;
@property (nonatomic, strong) PAUser *itemUser;
@property (nonatomic, strong) PFGeoPoint *itemLocation;
@property (nonatomic, strong) PACuisine *itemCuisine;

@property (nonatomic, strong) NSMutableArray *itemImageArray;
@property (nonatomic, strong) NSMutableArray *itemReviewArray;

@property (nonatomic, strong) NSString *itemDistance;
@property (nonatomic, strong) NSString *itemOpenHours;
@property (nonatomic, strong) NSNumber *itemOpen;



@end
