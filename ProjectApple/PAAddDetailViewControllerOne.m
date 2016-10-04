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
#import "PAConstants.h"

@interface PAAddDetailViewControllerOne ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstrain;

@end

@implementation PAAddDetailViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView setContentInset:UIEdgeInsetsMake(84, 0, 0, 0)];
    self.nextButton.backgroundColor = [PAColor appleRed];
    
    self.nameTextField.text = self.itemName;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
    PAAddViewControllerTwo * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PAAddViewControllerTwo"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (IS_IPHONE_6P) {
        switch (textField.tag) {
            case 2:{
                self.topConstrain.constant = -142;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
                
            default:
                break;
        }
        
    }
    else if (IS_IPHONE_6){
        switch (textField.tag) {
            case 0:{
                self.topConstrain.constant = -30;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
            case 2:{
                self.topConstrain.constant = -202;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
                
            default:
                break;
        }
        
    }
    else if (IS_IPHONE_5){
        switch (textField.tag) {
            case 0:{
                self.topConstrain.constant = -130;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
            case 2:{
                self.topConstrain.constant = -302;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
                
            default:
                break;
        }
        
    }
    else{
        switch (textField.tag) {
            case 0:{
                self.topConstrain.constant = -183;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
            case 2:{
                self.topConstrain.constant = -354;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
                
            default:
                break;
        }
        
    }
    
    if (textField.tag == 2) {
        if ([textField.text isEqualToString:@""]) {
            textField.text = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
        }
    }
}

@end
