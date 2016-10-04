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

@interface PAAddViewControllerOne ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) PFQuery *query;
@property (nonatomic, strong) NSMutableArray *itemsArray;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomConstrain;
@property (weak, nonatomic) IBOutlet UITableView *itemListTableView;

@property (assign, nonatomic) int originalTopConstrain;

@end

@implementation PAAddViewControllerOne

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self.nameTextField becomeFirstResponder];
//    [self.navigationController.interactivePopGestureRecognizer setDelegate:self];
//    
//    self.query = [PFQuery queryWithClassName:kPAItemsClassNameKey];
//}
//
//- (void)keyboardWasShown:(NSNotification *)notification
//{
//    
//    // Get the size of the keyboard.
//    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    //Given size may not account for screen rotation
//    int height = MIN(keyboardSize.height,keyboardSize.width);
//    
//    if (self.tableViewBottomConstrain.constant == 0) {
//        self.tableViewBottomConstrain.constant = height;
//        self.tableViewTopConstrain.constant = self.view.frame.size.height - self.tableViewBottomConstrain.constant;
//        self.originalTopConstrain = self.tableViewTopConstrain.constant;
//    }
//    else{
//        if (self.nameTextField.text.length > 0) {
//            self.itemListTableView.hidden = NO;
//            self.tableViewTopConstrain.constant = self.originalTopConstrain - 44 *self.itemsArray.count;
//            
//            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//                [self.view layoutIfNeeded];
//            } completion:nil];
//        }
//
//    }
//}
//
//-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    return YES;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.itemsArray.count;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
//    if ([[self.itemsArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
//        cell.textLabel.text = [NSString stringWithFormat:@"Add '%@' as a new item",[self.itemsArray objectAtIndex:indexPath.row]];
//        cell.detailTextLabel.text = @"";
//    }
//    else{
//        PAItem *item = [self.itemsArray objectAtIndex:indexPath.row];
//        cell.textLabel.text = item.itemName;
//        cell.detailTextLabel.text = item.itemRestaurantName;
//    }
//
//    return cell;
//}
//
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWasShown:)
//                                                 name:UIKeyboardDidShowNotification
//                                               object:nil];
//}
//
//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:UIKeyboardDidShowNotification
//                                                  object:nil];
//}
//
//
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self.nameTextField becomeFirstResponder];
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.nameTextField resignFirstResponder];
//}
//
//- (IBAction)back:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (IBAction)textFieldEditingChanged:(UITextField*)sender {
//    [self.query cancel];
//    
//    if (sender.text.length > 0) {
//        NSArray* words = [self.nameTextField.text componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        NSString* trimmedString = [words componentsJoinedByString:@""];
//        NSString *lowString = [trimmedString lowercaseString];
//        
//        [self.query whereKey:kPAItemCappedNameKey hasPrefix:lowString];
//        [self.activityIndicator startAnimating];
//        [self.query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//            [self.activityIndicator stopAnimating];
//            if (error == nil) {
//                if (objects.count>0) {
//                    self.itemsArray = [objects mutableCopy];
//                    [self.itemListTableView reloadData];
//                    
//                    self.itemListTableView.hidden = NO;
//                    self.tableViewTopConstrain.constant = self.originalTopConstrain - 44 *self.itemsArray.count;
//                    
//                    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//                        [self.view layoutIfNeeded];
//                    } completion:nil];
//                }
//                else{
//                    if (self.itemsArray == nil) {
//                        self.itemsArray = [NSMutableArray array];
//                    }
//                    [self.itemsArray removeAllObjects];
//                    NSString* result = [sender.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//                    
//                    [self.itemsArray addObject:result];
//                    [self.itemListTableView reloadData];
//                    
//                    self.itemListTableView.hidden = NO;
//                    self.tableViewTopConstrain.constant = self.originalTopConstrain - 44;
//                    
//                    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//                        [self.view layoutIfNeeded];
//                    } completion:nil];
//                    
//                }
//            }
//        }];
//    }
//    else{
//        
//        [self.activityIndicator stopAnimating];
//        
//        self.tableViewTopConstrain.constant = self.originalTopConstrain;
//        
//        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//            [self.view layoutIfNeeded];
//        } completion:^(BOOL finished) {
//            self.itemsArray = nil;
//            [self.itemListTableView reloadData];
//            self.itemListTableView.hidden = YES;
//        }];
//    }
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([[self.itemsArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
//        
//        [self.query cancel];
//        [self.activityIndicator stopAnimating];
//        
//        self.tableViewTopConstrain.constant = self.originalTopConstrain;
//        
//        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//            [self.view layoutIfNeeded];
//        } completion:^(BOOL finished) {
//            self.itemListTableView.hidden = YES;
//            [self.itemListTableView reloadData];
//        }];
//        
//        PAAddDetailViewControllerOne *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PAAddDetailViewControllerOne"];
//        vc.itemName = [self.itemsArray objectAtIndex:indexPath.row];
//        vc.images = self.images;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else{
////        MReviewViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MReviewViewController"];
////        [self.navigationController pushViewController:vc animated:YES];
//    }
//}

@end
