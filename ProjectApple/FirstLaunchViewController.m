//
//  FirstLaunchViewController.m
//  ProjectApple
//
//  Created by Abbin Varghese on 29/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "FirstLaunchViewController.h"
#import "FirstLaunchViewControllerOne.h"
#import "FirstLaunchViewControllerTwo.h"
#import "FirstLaunchViewControllerThree.h"
#import <AVFoundation/AVFoundation.h>
#import "PASignInViewController.h"
#import "PACurentLocationViewController.h"
#import "PAUser.h"
#import "PAManager.h"

@interface FirstLaunchViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (assign, nonatomic) NSUInteger currentPage;
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (nonatomic, strong) AVPlayer *avplayer;

@end

@implementation FirstLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0 alpha:0.1];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:0 alpha:0.2];
    pageControl.backgroundColor = [UIColor clearColor];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstLaunchPageViewController"];
    
    if ([PAUser currentUser]) {
        PACurentLocationViewController *startingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PACurentLocationViewController"];
        NSArray *viewControllers = @[startingViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    else{
        FirstLaunchViewControllerOne *startingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstLaunchViewControllerOne"];
        NSArray *viewControllers = @[startingViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    
    
    
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    self.pageViewController.view.frame = self.view.frame;
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    NSError *sessionError = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&sessionError];
    [[AVAudioSession sharedInstance] setActive:YES error:&sessionError];
    
    //Set up player
    NSURL *movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IMG_0102" ofType:@"mp4"]];
    AVAsset *avAsset = [AVAsset assetWithURL:movieURL];
    AVPlayerItem *avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
    self.avplayer = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
    AVPlayerLayer *avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:self.avplayer];
    [avPlayerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [avPlayerLayer setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.playerView.layer addSublayer:avPlayerLayer];
    
    //Config player
    [self.avplayer seekToTime:kCMTimeZero];
    [self.avplayer setVolume:0.0f];
    [self.avplayer setActionAtItemEnd:AVPlayerActionAtItemEndNone];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.avplayer currentItem]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerStartPlaying)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];

    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.avplayer pause];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.avplayer play];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

- (void)playerStartPlaying
{
    [self.avplayer play];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    if ([viewController.restorationIdentifier isEqualToString:@"FirstLaunchViewControllerTwo"]) {
        FirstLaunchViewControllerOne *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstLaunchViewControllerOne"];
        return vc;
    }
    else if ([viewController.restorationIdentifier isEqualToString:@"FirstLaunchViewControllerThree"]){
        FirstLaunchViewControllerTwo *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstLaunchViewControllerTwo"];
        return vc;
    }
    else if (([viewController.restorationIdentifier isEqualToString:@"PASignInViewController"])){
        FirstLaunchViewControllerThree *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstLaunchViewControllerThree"];
        return vc;
    }
    else if (([viewController.restorationIdentifier isEqualToString:@"PACurentLocationViewController"])){
        PASignInViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PASignInViewController"];
        [vc withCompletionHandler:^{
            PACurentLocationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PACurentLocationViewController"];
            [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        }];
        return vc;
    }
    else{
        return nil;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    if ([viewController.restorationIdentifier isEqualToString:@"FirstLaunchViewControllerOne"]) {
        FirstLaunchViewControllerTwo *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstLaunchViewControllerTwo"];
        return vc;
    }
    else if ([viewController.restorationIdentifier isEqualToString:@"FirstLaunchViewControllerTwo"]){
        FirstLaunchViewControllerThree *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstLaunchViewControllerThree"];
        return vc;
    }
    else if (([viewController.restorationIdentifier isEqualToString:@"FirstLaunchViewControllerThree"])){
        PASignInViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PASignInViewController"];
        [vc withCompletionHandler:^{
            PACurentLocationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PACurentLocationViewController"];
            [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        }];
        return vc;
    }
    else if (([viewController.restorationIdentifier isEqualToString:@"PASignInViewController"])){
        PACurentLocationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PACurentLocationViewController"];
        return vc;
    }
    else{
        return nil;
    }
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 5;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


@end
