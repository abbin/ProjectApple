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
#import "PAAddViewControllerOne.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,YMSPhotoPickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *nearbyTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nearbyTableView setContentInset:UIEdgeInsetsMake(84, 0, 0, 0)];
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
    if (scrollView.contentOffset.y > -70) {
        [self.view bringSubviewToFront:self.nearbyTableView];
    }
    else{
        [self.view sendSubviewToBack:self.nearbyTableView];
    }
}

- (IBAction)add:(id)sender {
    YMSPhotoPickerViewController *pickerViewController = [[YMSPhotoPickerViewController alloc] init];
    pickerViewController.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:pickerViewController];
    [nav setNavigationBarHidden:YES];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)photoPickerViewControllerDidReceivePhotoAlbumAccessDenied:(YMSPhotoPickerViewController *)picker
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Allow photo album access?", nil) message:NSLocalizedString(@"Need your permission to access photo albumbs", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertController addAction:dismissAction];
    [alertController addAction:settingsAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)photoPickerViewControllerDidReceiveCameraAccessDenied:(YMSPhotoPickerViewController *)picker
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Allow camera access?", nil) message:NSLocalizedString(@"Need your permission to take a photo", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertController addAction:dismissAction];
    [alertController addAction:settingsAction];
    
    // The access denied of camera is always happened on picker, present alert on it to follow the view hierarchy
    [picker presentViewController:alertController animated:YES completion:nil];
}

- (void)photoPickerViewController:(YMSPhotoPickerViewController *)picker didFinishPickingImages:(NSArray *)photoAssets
{
    PHImageManager *imageManager = [[PHImageManager alloc] init];
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.networkAccessAllowed = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.synchronous = YES;
    
    NSMutableArray *mutableImages = [NSMutableArray array];
    
    for (PHAsset *asset in photoAssets) {
        [imageManager requestImageDataForAsset:asset
                                       options:nil
                                 resultHandler:^(NSData * _Nullable imageData,
                                                 NSString * _Nullable dataUTI,
                                                 UIImageOrientation orientation,
                                                 NSDictionary * _Nullable info) {
                                     
                                     UIImage *image = [UIImage imageWithData:imageData];
                                     [mutableImages addObject:image];
                                     
                                     if (photoAssets.count == mutableImages.count) {
                                         PAAddViewControllerOne *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PAAddViewControllerOne"];
                                         vc.images = mutableImages;
                                         [picker.navigationController pushViewController:vc animated:YES];
                                     }
                                 }];
    }
}

@end
