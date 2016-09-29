//
//  PAAddDetailViewControllerOne.m
//  ProjectApple
//
//  Created by Abbin Varghese on 27/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PAAddDetailViewControllerOne.h"
#import "PAAddViewControllerTwo.h"
#import "PAColor.h"

@interface PAAddDetailViewControllerOne ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation PAAddDetailViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
    self.nextButton.backgroundColor = [PAColor appleRed];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
    PAAddViewControllerTwo * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PAAddViewControllerTwo"];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
