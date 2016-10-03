//
//  PACurentLocationViewController.m
//  ProjectApple
//
//  Created by Abbin Varghese on 03/10/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PACurentLocationViewController.h"

@interface PACurentLocationViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation PACurentLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
