//
//  PACuisine.h
//  ProjectApple
//
//  Created by Abbin Varghese on 04/10/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import <Parse/Parse.h>

@interface PACuisine : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (nonatomic,strong) NSString *cuisineName;
@property (nonatomic,strong) NSString *cuisineCappedName;

@end
