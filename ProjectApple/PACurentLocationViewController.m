//
//  PACurentLocationViewController.m
//  ProjectApple
//
//  Created by Abbin Varghese on 03/10/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PACurentLocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "PAConstants.h"
#import "RootViewController.h"
#import "AppDelegate.h"

@interface PACurentLocationViewController ()<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (assign, nonatomic) BOOL firstUpdate;

@end

@implementation PACurentLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.geocoder = [[CLGeocoder alloc] init];
    
    int height = [UIScreen mainScreen].bounds.size.height/2;
    int width = ((height*9)/16)/3;
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                          [UIScreen mainScreen].bounds.size.height/16,
                                                                          width,
                                                                          height)];
    imageview.backgroundColor = [UIColor lightTextColor];
    
    [self.view addSubview:imageview];
    
    NSString *string = @"To get started, please set your location\n(or let us do it for you)";
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:string];
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"HelveticaNeue-Light" size:25]
                  range:NSMakeRange(0, string.length)];
    
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"HelveticaNeue-Medium" size:25]
                  range:NSMakeRange(32, 8)];
    [hogan addAttribute:NSForegroundColorAttributeName
                  value:[UIColor colorWithWhite:0 alpha:0.8]
                  range:NSMakeRange(32, 8)];
    
    self.label.attributedText = hogan;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)autoDetectLocation:(id)sender {
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    
    [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    self.view.userInteractionEnabled = YES;
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (!self.firstUpdate) {
        [self.locationManager stopUpdatingLocation];
        CLLocation *currentLocation = locations[0];
        self.firstUpdate = YES;
        [self.geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            self.view.userInteractionEnabled = YES;
            if (error == nil && [placemarks count] > 0) {
                CLPlacemark *placemark = [placemarks lastObject];
                NSDictionary *placemarkDict = placemark.addressDictionary;
                NSMutableDictionary *loc = [NSMutableDictionary new];
                [loc setObject:[placemarkDict objectForKey:@"City"] forKey:kPALocationShortNameKey];
                [loc setObject:[NSNumber numberWithDouble:currentLocation.coordinate.latitude] forKey:kPALocationLatitudeKey];
                [loc setObject:[NSNumber numberWithDouble:currentLocation.coordinate.longitude] forKey:kPALocationLongitudeKey];
                
                NSArray * wordArray = [placemarkDict objectForKey:@"FormattedAddressLines"];
                NSString* nospacestring = [wordArray componentsJoinedByString:@", "];
                [loc setObject:nospacestring forKey:kPALocationFullNameKey];
                
                [[NSUserDefaults standardUserDefaults] setObject:loc forKey:kPACurrentLocationKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                RootViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
                AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [delegate changeRootViewController:vc];
            }
        } ];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
