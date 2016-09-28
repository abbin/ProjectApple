//
//  PAAddDetailViewControllerOne.m
//  ProjectApple
//
//  Created by Abbin Varghese on 27/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PAAddDetailViewControllerOne.h"

@interface PAAddDetailViewControllerOne ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation PAAddDetailViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
