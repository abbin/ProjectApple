//
//  PAUser.h
//  ProjectApple
//
//  Created by Abbin Varghese on 29/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import <Parse/Parse.h>

@interface PAUser : PFUser

@property (nonatomic, strong) PFFile *profilePhoto;
@property (nonatomic, strong) NSString *displayName;

@end
