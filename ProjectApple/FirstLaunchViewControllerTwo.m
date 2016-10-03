//
//  FirstLaunchViewControllerTwo.m
//  ProjectApple
//
//  Created by Abbin Varghese on 03/10/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "FirstLaunchViewControllerTwo.h"

@interface FirstLaunchViewControllerTwo ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation FirstLaunchViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    int height = [UIScreen mainScreen].bounds.size.height/2;
    int width = (height*250)/667;
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                          [UIScreen mainScreen].bounds.size.height/8,
                                                                          width,
                                                                          height)];
    imageview.backgroundColor = [UIColor lightTextColor];
    
    [self.view addSubview:imageview];
    
    NSString *string = @"We sort them for you by Location";
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:string];
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"HelveticaNeue-Light" size:25]
                  range:NSMakeRange(0, string.length)];
    
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"HelveticaNeue-Medium" size:25]
                  range:NSMakeRange(24, 8)];
    [hogan addAttribute:NSForegroundColorAttributeName
                  value:[UIColor colorWithWhite:0 alpha:0.8]
                  range:NSMakeRange(24, 8)];
    
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
