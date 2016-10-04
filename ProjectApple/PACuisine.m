//
//  PACuisine.m
//  ProjectApple
//
//  Created by Abbin Varghese on 04/10/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PACuisine.h"
#import "PFObject+Subclass.h"
#import "PAConstants.h"

@implementation PACuisine

@dynamic cuisineName;
@dynamic cuisineCappedName;

+(void)load{
    [self registerSubclass];
}

+(NSString *)parseClassName{
    return kPACuisineClassNameKey;
}

@end
