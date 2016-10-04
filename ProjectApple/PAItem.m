//
//  PAItem.m
//  ProjectApple
//
//  Created by Abbin Varghese on 04/10/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PAItem.h"
#import "PFObject+Subclass.h"
#import "PAConstants.h"

@implementation PAItem

@dynamic itemName;
@dynamic itemPrice;
@dynamic itemRating;
@dynamic itemRestaurantName;
@dynamic itemUserName;
@dynamic itemUser;
@dynamic itemLocation;
@dynamic itemDescription;
@dynamic itemCurrency;
@dynamic itemCurrencySymbol;
@dynamic itemImageArray;
@dynamic itemReviewArray;
@dynamic itemRestaurant;
@dynamic itemCappedName;
@dynamic itemDistance;
@dynamic itemOpenHours;
@dynamic itemCuisine;
@dynamic itemOpen;

+(void)load{
    [self registerSubclass];
}

+(NSString *)parseClassName{
    return kPAItemsClassNameKey;
}

@end
