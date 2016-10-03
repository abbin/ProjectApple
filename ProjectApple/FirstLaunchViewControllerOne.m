//
//  FirstLaunchViewControllerOne.m
//  ProjectApple
//
//  Created by Abbin Varghese on 03/10/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "FirstLaunchViewControllerOne.h"

@interface FirstLaunchViewControllerOne ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation FirstLaunchViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    int height = [UIScreen mainScreen].bounds.size.height/2;
    int width = (height*125)/667;
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-width,
                                                                          [UIScreen mainScreen].bounds.size.height/8,
                                                                          width,
                                                                          height)];
    imageview.backgroundColor = [UIColor lightTextColor];
    
    [self.view addSubview:imageview];
    
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
    
    NSString *string = @"Join FUUD\nDiscover great eats";
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:string];
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"HelveticaNeue-Light" size:25]
                  range:NSMakeRange(0, string.length)];
    
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"HelveticaNeue-Medium" size:25]
                  range:NSMakeRange(5, 4)];
    [hogan addAttribute:NSForegroundColorAttributeName
                  value:[UIColor colorWithWhite:0 alpha:0.8]
                  range:NSMakeRange(5, 4)];
    
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
