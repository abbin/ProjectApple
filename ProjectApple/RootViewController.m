//
//  RootViewController.m
//  ProjectApple
//
//  Created by Abbin Varghese on 29/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "RootViewController.h"
#import "ViewControllerTwo.h"
#import "ViewController.h"
#import "ViewControllerThree.h"

@interface RootViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (assign, nonatomic) NSUInteger currentPage;
@property (strong, nonatomic) NSArray *controllerArray;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    
    [self setDataSourceAndDelegate];
    
    ViewController *startingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    ViewControllerTwo *startingViewController2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerTwo"];
    ViewControllerThree *startingViewController3 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerThree"];

    self.controllerArray = @[startingViewController,startingViewController2,startingViewController3];
    
    NSArray *viewControllers = @[[self.controllerArray firstObject]];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = self.view.frame;
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeDataSourceAndDelegate)
                                                 name:@"removeDataSourceAndDelegate"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setDataSourceAndDelegate)
                                                 name:@"setDataSourceAndDelegate"
                                               object:nil];

}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setDataSourceAndDelegate{
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
}

-(void)removeDataSourceAndDelegate{
    self.pageViewController.dataSource = nil;
    self.pageViewController.delegate = nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    if ([viewController.restorationIdentifier isEqualToString:@"ViewControllerTwo"]) {
        return self.controllerArray[0];
    }
    else if ([viewController.restorationIdentifier isEqualToString:@"ViewControllerThree"]){
        return self.controllerArray[1];
    }
    else{
        return nil;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    if ([viewController.restorationIdentifier isEqualToString:@"ViewController"]) {
        return self.controllerArray[1];
    }
    else if ([viewController.restorationIdentifier isEqualToString:@"ViewControllerTwo"]){
        return self.controllerArray[2];
    }
    else{
        return nil;
    }
}

@end
