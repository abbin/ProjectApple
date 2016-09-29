//
//  PAManager.m
//  ProjectApple
//
//  Created by Abbin Varghese on 29/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PAManager.h"
#import "PAConstants.h"

@implementation PAManager

+(BOOL)isLocationSet{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kPACurrentLocationKey]) {
        return YES;
    }
    else{
        return NO;
    }
}

@end
