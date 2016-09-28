//
//  PAAddViewControllerOne.m
//  ProjectApple
//
//  Created by Abbin Varghese on 27/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PAAddViewControllerOne.h"
#import "PAAddDetailViewControllerOne.h"

@interface PAAddViewControllerOne ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (strong, nonatomic) IBOutlet UIView *toolBar;

@end

@implementation PAAddViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nameTextField becomeFirstResponder];
    self.nameTextField.inputAccessoryView = self.toolBar;
    [self.navigationController.interactivePopGestureRecognizer setDelegate:self];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.nameTextField becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.nameTextField resignFirstResponder];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
    PAAddDetailViewControllerOne *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PAAddDetailViewControllerOne"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
