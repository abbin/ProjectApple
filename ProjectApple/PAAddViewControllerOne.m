//
//  PAAddViewControllerOne.m
//  ProjectApple
//
//  Created by Abbin Varghese on 27/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PAAddViewControllerOne.h"
#import "PAAddDetailViewControllerOne.h"
#import "PAColor.h"
#import <Parse.h>
#import "PAConstants.h"
#import "PAItem.h"

@interface PAAddViewControllerOne ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomConstrain;
@property (weak, nonatomic) IBOutlet UITableView *itemListTableView;

@property (nonatomic, strong) PFQuery *query;
@property (nonatomic, strong) NSMutableArray *itemsArray;

@end

@implementation PAAddViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.interactivePopGestureRecognizer setDelegate:self];
    
#if DEBUG
    self.query = [PFQuery queryWithClassName:kPAItemsClassNameKey];
#endif
    
    self.query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    self.tableViewHeightConstrain.constant = 0;
    
    if (IS_IPHONE_4_OR_LESS) {
        self.nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    }
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



//////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Notifications -

- (void)keyboardDidShow: (NSNotification *) notification{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    double        time  = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    
    self.tableViewBottomConstrain.constant = keyboardFrame.size.height;
    
    [UIView animateWithDuration:time animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardDidHide: (NSNotification *) notification{
    NSDictionary *info  = notification.userInfo;
    double        time  = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.tableViewBottomConstrain.constant = 0;
    self.tableViewHeightConstrain.constant = 0;
    
    [UIView animateWithDuration:time animations:^{
        [self.view layoutIfNeeded];
    }];
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - UITableViewDataSource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if ([[self.itemsArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        cell.textLabel.text = [NSString stringWithFormat:@"Add '%@' as a new item",[self.itemsArray objectAtIndex:indexPath.row]];
        cell.detailTextLabel.text = @"";
    }
    else{
        PAItem *item = [self.itemsArray objectAtIndex:indexPath.row];
        cell.textLabel.text = item.itemName;
        cell.detailTextLabel.text = item.itemRestaurantName;
    }
    return cell;
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - UITableViewDelegate -

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[self.itemsArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        [self.query cancel];
        [self.activityIndicator stopAnimating];
        
        PAAddDetailViewControllerOne *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PAAddDetailViewControllerOne"];
        vc.itemName = [self.itemsArray objectAtIndex:indexPath.row];
        vc.images = self.images;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - UITextFieldDelegate -

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.text.length>0) {
        self.tableViewHeightConstrain.constant = 44 *self.itemsArray.count;
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.tableViewHeightConstrain.constant = 0;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.itemListTableView reloadData];
    }];
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - IBAction -


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)textFieldEditingChanged:(UITextField*)sender {
    [self.query cancel];
    
    if (sender.text.length > 0) {
        NSArray* words = [self.nameTextField.text componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString* trimmedString = [words componentsJoinedByString:@""];
        NSString *lowString = [trimmedString lowercaseString];
        
        [self.query whereKey:kPAItemCappedNameKey hasPrefix:lowString];
        [self.activityIndicator startAnimating];
        [self.query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            [self.activityIndicator stopAnimating];
            if (error == nil) {
                if (objects.count>0) {
                    self.itemsArray = [objects mutableCopy];
                    [self.itemListTableView reloadData];
        
                    self.tableViewHeightConstrain.constant = 44 *self.itemsArray.count;
                    
                    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                        [self.view layoutIfNeeded];
                    } completion:nil];
                }
                else{
                    if (self.itemsArray == nil) {
                        self.itemsArray = [NSMutableArray array];
                    }
                    [self.itemsArray removeAllObjects];
                    NSString* result = [sender.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    
                    [self.itemsArray addObject:result];
                    [self.itemListTableView reloadData];
                    
                    self.tableViewHeightConstrain.constant =  44;
                    
                    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                        [self.view layoutIfNeeded];
                    } completion:nil];
                }
            }
        }];
    }
    else{
        [self.activityIndicator stopAnimating];
        self.tableViewHeightConstrain.constant = 0;
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.itemsArray = nil;
            [self.itemListTableView reloadData];
        }];
    }
}


@end
