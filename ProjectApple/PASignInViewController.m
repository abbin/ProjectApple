//
//  PASignInViewController.m
//  ProjectApple
//
//  Created by Abbin Varghese on 03/10/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PASignInViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "PAUser.h"
#import "PAManager.h"
#import "PACurentLocationViewController.h"
#import "RootViewController.h"
#import "AppDelegate.h"

@interface PASignInViewController ()<FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *logInButton;

@property (nonatomic, strong) void(^completionHandler)();

@end

@implementation PASignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int height = [UIScreen mainScreen].bounds.size.height/2;
    int width = ((height*9)/16)/3*2;
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-width,
                                                                          [UIScreen mainScreen].bounds.size.height/16,
                                                                          width,
                                                                          height)];
    imageview.backgroundColor = [UIColor lightTextColor];
    
    [self.view addSubview:imageview];
    
    NSString *string = @"Connect with Friends and know what they have been up to. Newsfeed!";
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:string];
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"HelveticaNeue-Light" size:25]
                  range:NSMakeRange(0, string.length)];
    
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"HelveticaNeue-Medium" size:25]
                  range:NSMakeRange(13, 7)];
    [hogan addAttribute:NSForegroundColorAttributeName
                  value:[UIColor colorWithWhite:0 alpha:0.8]
                  range:NSMakeRange(13, 7)];
    
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"HelveticaNeue-Medium" size:25]
                  range:NSMakeRange(57, 9)];
    [hogan addAttribute:NSForegroundColorAttributeName
                  value:[UIColor colorWithWhite:0 alpha:0.8]
                  range:NSMakeRange(57, 9)];
    self.label.attributedText = hogan;
    
    self.logInButton.delegate = self;
    self.logInButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];

}

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    if (error == nil && [FBSDKAccessToken currentAccessToken].tokenString) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,first_name,last_name,email,picture.width(100).height(100)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                if ([result objectForKey:@"email"]) {
                    PAUser *user = [PAUser user];
                    user.password = @"password";
                    user.email = [result objectForKey:@"email"];
                    user.username = [result objectForKey:@"email"];
                    user.displayName = [NSString stringWithFormat:@"%@ %@",[result objectForKey:@"first_name"],[result objectForKey:@"last_name"]];
                    NSString *url = [[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"];
                    
                    PFFile *image;
                    if (url.length>0) {
                        image = [PFFile fileWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
                    }
                    user.profilePhoto = image;
                    
                    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (!error) {
                            if (![PAManager isLocationSet]) {
                                if ([self isModal]) {
                                    PACurentLocationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PACurentLocationViewController"];
                                    [self.navigationController pushViewController:vc animated:YES];
                                }
                                else{
                                    _completionHandler();
                                }
                            }
                            else{
                                if ([self isModal]) {
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                }
                                else{
                                    RootViewController *rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
                                    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                                    [delegate changeRootViewController:rootViewController];
                                }
                            }
                        }else{
                            if (error.code == 202 || error.code == 203) {
                                [PFUser logInWithUsernameInBackground:[result objectForKey:@"email"] password:@"password"
                                                                block:^(PFUser *user, NSError *error) {
                                                                    if (user && error == nil) {
                                                                        if (![PAManager isLocationSet]) {
                                                                            if ([self isModal]) {
                                                                                PACurentLocationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PACurentLocationViewController"];
                                                                                [self.navigationController pushViewController:vc animated:YES];
                                                                            }
                                                                            else{
                                                                                _completionHandler();
                                                                            }
                                                                        }
                                                                        else{
                                                                            if ([self isModal]) {
                                                                                [self dismissViewControllerAnimated:YES completion:nil];
                                                                            }
                                                                            else{
                                                                                RootViewController *rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
                                                                                AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                                                                                [delegate changeRootViewController:rootViewController];
                                                                            }
                                                                        }
                                                                    }
                                                                }];
                            }
                        }
                    }];
                    
                }
            }
        }];
    }
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    
}

- (BOOL)isModal {
    return self.presentingViewController.presentedViewController == self
    || (self.navigationController != nil && self.navigationController.presentingViewController.presentedViewController == self.navigationController)
    || [self.tabBarController.presentingViewController isKindOfClass:[UITabBarController class]];
}

-(void)withCompletionHandler:(void(^)())handler{
    _completionHandler = handler;
}

@end
