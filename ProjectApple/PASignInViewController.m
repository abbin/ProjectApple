//
//  PASignInViewController.m
//  ProjectApple
//
//  Created by Abbin Varghese on 03/10/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PASignInViewController.h"

@interface PASignInViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation PASignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int height = [UIScreen mainScreen].bounds.size.height/2;
    int width = (height*9)/16;
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-width+width/4,
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
