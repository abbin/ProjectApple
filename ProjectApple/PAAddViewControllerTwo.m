//
//  PAAddViewControllerTwo.m
//  ProjectApple
//
//  Created by Abbin Varghese on 28/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PAAddViewControllerTwo.h"
#import "PAAddDetailViewControllerTwo.h"
#import "PAColor.h"
#import "PAConstants.h"
#import "PARestaurant.h"

@interface PAAddViewControllerTwo ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *restNameTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewBottomConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UITableView *restTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) PFQuery *query;
@property (nonatomic, strong) NSMutableArray *restArray;

@end

@implementation PAAddViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.query = [PFQuery queryWithClassName:kPARestaurantClassNameKey];
    
#if DEBUG
    self.query.cachePolicy = kPFCachePolicyCacheElseNetwork;
#endif
    
    self.tableViewHeight.constant = 0;
    
    if (IS_IPHONE_4_OR_LESS) {
        self.restNameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.restNameTextField becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.restNameTextField resignFirstResponder];
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
    
    self.tableviewBottomConstrain.constant = keyboardFrame.size.height;
    
    [UIView animateWithDuration:time animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardDidHide: (NSNotification *) notification{
    NSDictionary *info  = notification.userInfo;
    double        time  = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.tableviewBottomConstrain.constant = 0;
    self.tableviewBottomConstrain.constant = 0;
    
    [UIView animateWithDuration:time animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)next:(id)sender {
    PAAddDetailViewControllerTwo *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PAAddDetailViewControllerTwo"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - UITextFieldDelegate -

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.text.length>0) {
        self.tableViewHeight.constant = 44 *self.restArray.count;
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.tableViewHeight.constant = 0;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.restTableView reloadData];
    }];
}

- (IBAction)textFieldDidChangeEditing:(UITextField *)sender {
    [self.query cancel];
    
    if (sender.text.length > 0) {
        NSArray* words = [sender.text componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString* trimmedString = [words componentsJoinedByString:@""];
        NSString *lowString = [trimmedString lowercaseString];
        
        [self.query whereKey:kPARestaurantCappedNameKey hasPrefix:lowString];
        [self.activityIndicator startAnimating];
        [self.query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            [self.activityIndicator stopAnimating];
            if (error == nil) {
                if (objects.count>0) {
                    self.restArray = [objects mutableCopy];
                    [self.restTableView reloadData];
                    
                    self.tableViewHeight.constant = 44 *self.restArray.count;
                    
                    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                        [self.view layoutIfNeeded];
                    } completion:nil];
                }
                else{
                    if (self.restArray == nil) {
                        self.restArray = [NSMutableArray array];
                    }
                    [self.restArray removeAllObjects];
                    NSString* result = [sender.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    
                    [self.restArray addObject:result];
                    [self.restTableView reloadData];
                    
                    self.tableViewHeight.constant =  44;
                    
                    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                        [self.view layoutIfNeeded];
                    } completion:nil];
                }
            }
        }];
    }
    else{
        [self.activityIndicator stopAnimating];
        self.tableViewHeight.constant = 0;
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.restArray = nil;
            [self.restTableView reloadData];
        }];
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - UITableViewDataSource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.restArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if ([[self.restArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        cell.textLabel.text = [NSString stringWithFormat:@"Add '%@' as a new restaurant",[self.restArray objectAtIndex:indexPath.row]];
        cell.detailTextLabel.text = @"";
    }
    else{
        PARestaurant *item = [self.restArray objectAtIndex:indexPath.row];
        cell.textLabel.text = item.restaurantName;
        cell.detailTextLabel.text = item.restaurantAddress;
    }
    
    return cell;
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - UITableViewDelegate -

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[self.restArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        [self.query cancel];
        [self.activityIndicator stopAnimating];
        
        PAAddDetailViewControllerTwo *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PAAddDetailViewControllerTwo"];
        vc.restName = [self.restArray objectAtIndex:indexPath.row];
        vc.images = self.images;
        vc.item = self.item;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
