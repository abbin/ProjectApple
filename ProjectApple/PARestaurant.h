//
//  PARestaurant.h
//  ProjectApple
//
//  Created by Abbin Varghese on 04/10/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import <Parse/Parse.h>

@interface PARestaurant : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (strong, nonatomic) NSString *restaurantName;
@property (strong, nonatomic) NSString *restaurantAddress;
@property (strong, nonatomic) PFGeoPoint *restaurantLocation;
@property (strong, nonatomic) NSMutableArray *restaurantPhoneNumbers;
@property (strong, nonatomic) NSMutableArray *restaurantWorkingHours;

+(PARestaurant*)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate phonumber:(NSMutableArray*)phoneNumber workingDays:(NSMutableArray*)workingDays from:(NSString*)from till:(NSString*)till;

+(PARestaurant*)initWithDictionary:(NSDictionary*)dictionary;

@end
