//
//  PAAddDetailViewControllerTwo.m
//  ProjectApple
//
//  Created by Abbin Varghese on 28/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PAAddDetailViewControllerTwo.h"

@interface PAAddDetailViewControllerTwo ()

@property (weak, nonatomic) IBOutlet UIScrollView *scroolView;

@end

@implementation PAAddDetailViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scroolView setContentInset:UIEdgeInsetsMake(84, 0, 0, 0)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
