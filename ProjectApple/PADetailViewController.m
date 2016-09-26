//
//  PADetailViewController.m
//  ProjectApple
//
//  Created by Abbin Varghese on 26/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PADetailViewController.h"
#import "PADetailHeadingTableViewCell.h"
#import "FALabelTableViewCell.h"
#import "PAColor.h"
#import "PACollectionTableViewCell.h"
#import "PAWorkingHoursTableViewCell.h"
#import "PAReviewTableViewCell.h"

@interface PADetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *detailTableview;

@end

@implementation PADetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.interactivePopGestureRecognizer setDelegate:self];
    
    [self.detailTableview setContentInset:UIEdgeInsetsMake(70, 0, 0, 0)];
    [self.detailTableview setEstimatedRowHeight:286];
    [self.detailTableview setRowHeight:UITableViewAutomaticDimension];
    [self.detailTableview registerNib:[UINib nibWithNibName:@"PADetailHeadingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PADetailHeadingTableViewCell"];
    [self.detailTableview registerNib:[UINib nibWithNibName:@"FALabelTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FALabelTableViewCell"];
    [self.detailTableview registerNib:[UINib nibWithNibName:@"PACollectionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PACollectionTableViewCell"];
    [self.detailTableview registerNib:[UINib nibWithNibName:@"PAWorkingHoursTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PAWorkingHoursTableViewCell"];
    [self.detailTableview registerNib:[UINib nibWithNibName:@"PAReviewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PAReviewTableViewCell"];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        PADetailHeadingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PADetailHeadingTableViewCell"];
        return cell;
    }
    else if (indexPath.row == 1){
        FALabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FALabelTableViewCell"];
        cell.cellLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        cell.cellLabel.textColor = [UIColor colorWithWhite:0 alpha:0.54];
        cell.cellLabel.text = @"Line art icons for the latest iOS and Android operating system. These icons are perfect for social, messaging and productivity apps and websites.";
        return cell;
    }
    else if (indexPath.row == 2){
        FALabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FALabelTableViewCell"];
        cell.cellLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
        cell.cellLabel.text = @"₹ 25";
        return cell;
    }
    else if (indexPath.row == 3){
        FALabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FALabelTableViewCell"];
        cell.cellLabel.textColor = [UIColor colorWithWhite:0 alpha:0.54];
        
        NSMutableAttributedString *atString = [[NSMutableAttributedString alloc] initWithString:@"Open now : 9 AM to 7 PM"];
        [atString addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0]
                         range:NSMakeRange(0, atString.length)];
        [atString addAttribute:NSFontAttributeName
                         value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]
                         range:NSMakeRange(0, 8)];
        [atString addAttribute:NSForegroundColorAttributeName
                         value:[PAColor appleGreen]
                         range:NSMakeRange(0, 8)];
        cell.cellLabel.attributedText = atString;

        return cell;
    }
    else if (indexPath.row == 4){
        PACollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PACollectionTableViewCell"];
        return cell;
    }
    else if (indexPath.row == 5){
        FALabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FALabelTableViewCell"];
        cell.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        cell.cellLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
        cell.cellLabel.text = @"Reviews";
        return cell;
    }
    else if (indexPath.row == 6){
        PAReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PAReviewTableViewCell"];
        return cell;
    }
    else if (indexPath.row == 7){
        PAReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PAReviewTableViewCell"];
        return cell;
    }
    else if (indexPath.row == 8){
        FALabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FALabelTableViewCell"];
        cell.cellLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
        cell.cellLabel.text = @"Read All Reviews";
        cell.cellLabel.textAlignment = NSTextAlignmentRight;
        return cell;
    }
    else if (indexPath.row == 9){
        FALabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FALabelTableViewCell"];
        cell.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        cell.cellLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
        cell.cellLabel.text = @"Working Hours";
        return cell;
    }
    else if (indexPath.row == 10){
        PAWorkingHoursTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PAWorkingHoursTableViewCell"];
        return cell;
    }
    else{
        return nil;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > -70) {
        [self.view bringSubviewToFront:self.detailTableview];
    }
    else{
        [self.view sendSubviewToBack:self.detailTableview];
    }
}

@end
