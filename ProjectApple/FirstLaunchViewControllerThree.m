//
//  FirstLaunchViewControllerThree.m
//  ProjectApple
//
//  Created by Abbin Varghese on 03/10/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "FirstLaunchViewControllerThree.h"

@interface FirstLaunchViewControllerThree ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation FirstLaunchViewControllerThree

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int height = [UIScreen mainScreen].bounds.size.height/2;
    int width = (height*9)/16;
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-width/2,
                                                                          -10,
                                                                          width,
                                                                          height)];
    imageview.backgroundColor = [UIColor lightTextColor];
    
    [self.view addSubview:imageview];
    
    NSString *string = @"Found something new? Let the others know. FUUD is always best shared";
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:string];
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"HelveticaNeue-Light" size:25]
                  range:NSMakeRange(0, string.length)];
    
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"HelveticaNeue-Medium" size:25]
                  range:NSMakeRange(16, 3)];
    [hogan addAttribute:NSForegroundColorAttributeName
                  value:[UIColor colorWithWhite:0 alpha:0.8]
                  range:NSMakeRange(16, 3)];
    
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"HelveticaNeue-Medium" size:25]
                  range:NSMakeRange(42, 4)];
    [hogan addAttribute:NSForegroundColorAttributeName
                  value:[UIColor colorWithWhite:0 alpha:0.8]
                  range:NSMakeRange(42, 4)];
    
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
