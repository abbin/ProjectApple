//
//  ViewController.m
//  ProjectApple
//
//  Created by Abbin Varghese on 26/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "ViewController.h"
#import "PANearbyTableViewCell.h"
#import "PADetailViewController.h"
#import "UIViewController+YMSPhotoHelper.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,YMSPhotoPickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *nearbyTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nearbyTableView setContentInset:UIEdgeInsetsMake(70, 0, 0, 0)];
    [self.nearbyTableView setEstimatedRowHeight:286];
    [self.nearbyTableView setRowHeight:UITableViewAutomaticDimension];
    [self.nearbyTableView registerNib:[UINib nibWithNibName:@"PANearbyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PANearbyTableViewCell"];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PANearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PANearbyTableViewCell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PADetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PADetailViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y > -70) {
        [self.view bringSubviewToFront:self.nearbyTableView];
    }
    else{
        [self.view sendSubviewToBack:self.nearbyTableView];
    }
}

- (IBAction)add:(id)sender {
    [self yms_presentAlbumPhotoViewWithDelegate:self];
}

@end
