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

@interface PADetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *detailTableview;

@end

@implementation PADetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
    [self.detailTableview setContentInset:UIEdgeInsetsMake(86, 0, 0, 0)];
    [self.detailTableview setEstimatedRowHeight:286];
    [self.detailTableview setRowHeight:UITableViewAutomaticDimension];
    [self.detailTableview registerNib:[UINib nibWithNibName:@"PADetailHeadingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PADetailHeadingTableViewCell"];
    [self.detailTableview registerNib:[UINib nibWithNibName:@"FALabelTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FALabelTableViewCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
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
        cell.cellLabel.textColor = [UIColor colorWithWhite:0 alpha:1];
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
    else{
        return nil;
    }
}

@end
