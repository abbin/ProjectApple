//
//  PAUser.m
//  ProjectApple
//
//  Created by Abbin Varghese on 29/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PAUser.h"
#import <Parse/PFObject+Subclass.h>

@implementation PAUser

@dynamic profilePhoto;
@dynamic displayName;

+ (void)load {
    [self registerSubclass];
}

@end
