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

@interface PAAddDetailViewControllerOne ()<UITextViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *doneButtonBottomConstrain;
@property (weak, nonatomic) IBOutlet UIView *naviBar;
@property (weak, nonatomic) IBOutlet UITextField *cuisineTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;

@end

@implementation PAAddDetailViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView setContentInset:UIEdgeInsetsMake(84, 0, 0, 0)];
    self.nextButton.backgroundColor = [PAColor appleRed];
    self.nameTextField.text = self.itemName;
    
    if (IS_IPHONE_4_OR_LESS) {
        self.cuisineTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.descriptionTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view endEditing:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

-(void)viewDidLayoutSubviews{
    if (self.scrollView.contentOffset.y <= -70) {
        if (self.topConstrain.constant<0) {
            [self.view sendSubviewToBack:self.naviBar];
        }
        else{
            [self.view bringSubviewToFront:self.naviBar];
        }
    }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Notifications -

- (void)keyboardDidShow: (NSNotification *) notification{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    
    self.doneButtonBottomConstrain.constant = keyboardFrame.size.height +15;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardDidHide: (NSNotification *) notification{
    
    self.doneButtonBottomConstrain.constant = 15;
    self.topConstrain.constant = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - UIScrollViewDelegate -

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > -70) {
        [self.view sendSubviewToBack:self.naviBar];
    }
    else{
        [self.view bringSubviewToFront:self.naviBar];
    }
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - IBAction -

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (IS_IPHONE_4_OR_LESS) {
        if (textField.tag == 0) {
            self.topConstrain.constant = 0;
        }
        else if (textField.tag == 1) {
            self.topConstrain.constant = -95;
        }
        else if (textField.tag == 2){
            self.topConstrain.constant = -190;
        }
    }
    else if (IS_IPHONE_5){
        if (textField.tag == 0) {
            self.topConstrain.constant = 0;
        }
        else if (textField.tag == 1) {
            self.topConstrain.constant = -95;
        }
        else if (textField.tag == 2){
            self.topConstrain.constant = -190;
        }
    }
    else if (IS_IPHONE_6){
        if (textField.tag == 0) {
            self.topConstrain.constant = 0;
        }
        else if (textField.tag == 1) {
            self.topConstrain.constant = 0;
        }
        else if (textField.tag == 2){
            self.topConstrain.constant = -50;
        }
    }
    
    if (textField.tag == 1) {
        if ([textField.text isEqualToString:@""]) {
            textField.text = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
        }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 1) {
        if ([textField.text isEqualToString:[[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol]]) {
            textField.text = @"";
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == 1) {
        if ((range.location == 0 && range.length == 1) || (range.location > 6 && range.length == 0)) {
            return NO;
        }
        else{
            return YES;
        }
    }
    else{
        return YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 0) {
        [self.priceTextField becomeFirstResponder];
        return YES;
    }
    else if (textField.tag == 2){
        [self.cuisineTextField becomeFirstResponder];
        return YES;
    }
    else{
        return YES;
    }
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - UITextViewDelegate -

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"say something about this"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    if (IS_IPHONE_4_OR_LESS) {
        self.topConstrain.constant = -285;
    }
    else if (IS_IPHONE_5){
        self.topConstrain.constant = -210;
    }
    else if (IS_IPHONE_6){
        self.topConstrain.constant = -130;
    }
    else if (IS_IPHONE_6P){
        self.topConstrain.constant = -90;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"say something about this";
        textView.textColor = [UIColor colorWithWhite:0 alpha:0.25];
    }
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - IBAction -

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
    NSString* name = [self.nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* price = [self.priceTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* cuisine = [self.cuisineTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* descript = [self.descriptionTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (name.length == 0) {
        
    }
    else if (price.length == 0){
        
    }
    else if (cuisine.length == 0){
        
    }
    else{
        PACuisine *cuisineObj = [PACuisine object];
        cuisineObj.cuisineName = cuisine;
        
        NSArray* words = [cuisine componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString* trimmedString = [words componentsJoinedByString:@""];
        NSString *lowString = [trimmedString lowercaseString];
        
        cuisineObj.cuisineCappedName = lowString;
        
        PAAddViewControllerTwo * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PAAddViewControllerTwo"];
       
        PAItem *newItem = [PAItem object];
        newItem.itemName = name;
        newItem.itemCuisine = cuisineObj;
        newItem.itemPrice = [NSNumber numberWithInteger:[price integerValue]];
        
        if (self.descriptionTextView.text.length>0) {
            newItem.itemDescription = descript;
        }
        
        vc.item = newItem;
        vc.images = self.images;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)didTapOnOview:(id)sender {
    [self.view endEditing:YES];
}

@end
