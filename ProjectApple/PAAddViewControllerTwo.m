//
//  PAAddViewControllerTwo.m
//  ProjectApple
//
//  Created by Abbin Varghese on 28/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PAAddViewControllerTwo.h"
#import "PAAddDetailViewControllerTwo.h"

@interface PAAddViewControllerTwo ()

@property (strong, nonatomic) IBOutlet UIView *tooBar;
@property (weak, nonatomic) IBOutlet UITextField *restNameTextField;

@end

@implementation PAAddViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.restNameTextField.inputAccessoryView = self.tooBar;
    [self.restNameTextField becomeFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.restNameTextField becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.restNameTextField resignFirstResponder];
}

- (IBAction)next:(id)sender {
    PAAddDetailViewControllerTwo *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PAAddDetailViewControllerTwo"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
