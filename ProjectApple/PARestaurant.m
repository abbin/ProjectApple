//
//  PARestaurant.m
//  ProjectApple
//
//  Created by Abbin Varghese on 04/10/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PARestaurant.h"
#import "PAConstants.h"
#import <Parse/PFObject+Subclass.h>

@implementation PARestaurant

@dynamic restaurantName;
@dynamic restaurantAddress;
@dynamic restaurantLocation;
@dynamic restaurantPhoneNumbers;
@dynamic restaurantWorkingHours;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return kPARestaurantClassNameKey;
}

+(PARestaurant*)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate phonumber:(NSMutableArray*)phoneNumber workingDays:(NSMutableArray*)workingDays from:(NSString*)from till:(NSString*)till{
    PARestaurant *restObj = [PARestaurant object];
    
    restObj.restaurantName = name;
    restObj.restaurantAddress = address;
    restObj.restaurantLocation = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    if (phoneNumber.count>0) {
        restObj.restaurantPhoneNumbers = phoneNumber;
    }
    if (workingDays.count>0) {
        for (NSMutableDictionary *dict in workingDays) {
            [[dict objectForKey:@"close"] setObject:till forKey:@"time"];
            [[dict objectForKey:@"open"] setObject:from forKey:@"time"];
        }
        restObj.restaurantWorkingHours = workingDays;
    }
    return restObj;
}

+(PARestaurant*)initWithDictionary:(NSDictionary*)dictionary{
    PARestaurant *restObj = [PARestaurant object];
    
    @try {
        restObj.restaurantName = [dictionary objectForKey:@"name"];
    } @catch (NSException *exception) {
        restObj.restaurantName = @"";
    }
    
    @try {
        restObj.restaurantAddress = [dictionary objectForKey:@"formatted_address"];
    } @catch (NSException *exception) {
        restObj.restaurantAddress = @"";
    }
    
    @try {
        double lat = [[[[dictionary objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"] doubleValue];
        double lng = [[[[dictionary objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"] doubleValue];
        restObj.restaurantLocation = [PFGeoPoint geoPointWithLatitude:lat longitude:lng];
    } @catch (NSException *exception) {
        
    }
    
    @try {
        restObj.restaurantPhoneNumbers = [NSMutableArray arrayWithObject:[dictionary objectForKey:@"formatted_phone_number"]];
    } @catch (NSException *exception) {
    }
    
    @try {
        NSArray *periods = [[dictionary objectForKey:@"opening_hours"] objectForKey:@"periods"];
        NSMutableArray *array = [NSMutableArray new];
        for (NSDictionary *dict in periods) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSArray *daySymbols = dateFormatter.standaloneWeekdaySymbols;
            
            NSInteger dayIndex = [[[dict objectForKey:@"close"] objectForKey:@"day"] integerValue]; // 0 = Sunday, ... 6 = Saturday
            NSString *dayName = daySymbols[dayIndex];
            
            NSMutableDictionary *close = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          [[dict objectForKey:@"close"] objectForKey:@"day"],@"day",
                                          [[dict objectForKey:@"close"] objectForKey:@"time"],@"time",
                                          dayName, @"dayName", nil];
            
            NSMutableDictionary *open = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         [[dict objectForKey:@"open"] objectForKey:@"day"],@"day",
                                         [[dict objectForKey:@"open"] objectForKey:@"time"],@"time",
                                         dayName, @"dayName", nil];
            
            NSMutableDictionary *mainDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:close,@"close",open,@"open", nil];
            [array addObject:mainDict];
        }
        restObj.restaurantWorkingHours = array;
    } @catch (NSException *exception) {
        
    }
    return restObj;
}


@end
