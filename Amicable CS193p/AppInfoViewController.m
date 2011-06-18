//
//  AppInfoViewController.m
//  Amicable CS193p
//
//  Created by Hongxia Zhong on 6/5/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "AppInfoViewController.h"

@interface AppInfoViewController()
@property (nonatomic, retain) UIImageView *imageView;
@end

@implementation AppInfoViewController

@synthesize delegate;
@synthesize imageView;

#pragma mark - Deallocation

- (void)dealloc
{
    [imageView release];
    [super dealloc];
}

#pragma mark -View lifecycle

- (void)tap:(UITapGestureRecognizer *)gesture
{
    NSLog(@"asdfasdf");
    if (gesture.state == UIGestureRecognizerStateEnded) {
        NSLog(@"asdfasdf");
        [self.delegate appInfoViewController:self];
    }
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tutorial.png"]];
    imageView.backgroundColor = [UIColor blackColor];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageView.frame = self.view.bounds;
    [self.view addSubview:self.imageView];
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tgr.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tgr];
    [tgr release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
