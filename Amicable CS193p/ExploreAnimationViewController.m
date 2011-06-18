//
//  ExploreAnimationViewController.m
//  Amicable CS193p
//
//  Created by Hongxia Zhong on 6/5/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "ExploreAnimationViewController.h"
#import "Pet.h"
#import "HSFrameAnimator.h"
#import "BrowseBackgroundViewController.h"

@interface ExploreAnimationViewController()
{
    CALayer *pet_layer;
    HSFrameAnimator *animator_;
}
@property (nonatomic, retain) UIImageView *backgroundImageView;
@property (nonatomic, retain) UIView *animationView;
@end

@implementation ExploreAnimationViewController

@synthesize backgroundImage;
@synthesize backgroundImageView;
@synthesize animationView;
@synthesize pet;

#pragma mark - Initialization



#define DEFAULT_BACKGROUND @"pet_background3.png"
#define BACKGROUND_KEY @"savedBackground"

- (UIImage *)backgroundImage
{
    if (!backgroundImage) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *savedBackground = [defaults objectForKey:BACKGROUND_KEY];
        if(!savedBackground) {
            backgroundImage = [UIImage imageNamed:DEFAULT_BACKGROUND];
            [defaults setObject:DEFAULT_BACKGROUND forKey:BACKGROUND_KEY];
            [defaults synchronize];
        } else {
            backgroundImage = [UIImage imageNamed:savedBackground];
        }
    }
    return backgroundImage;
}

- (UIImageView *)backgroundImageView
{
    if (!backgroundImageView) {
        backgroundImageView = [[UIImageView alloc] init];
    }
    return backgroundImageView;
}

#pragma mark - Deallocation

- (void)dealloc
{
    [backgroundImage release];
    [backgroundImageView release];
    [animationView release];
    [super dealloc];
}

#pragma mark - View lifecycle

#define DEFAULT_BACKGROUND @"pet_background3.png"
#define BACKGROUND_KEY @"savedBackground"

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.backgroundImageView.image = self.backgroundImage;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"View did load");
    
    // add background view
    self.backgroundImageView.frame = self.view.bounds;
    [self.view addSubview:self.backgroundImageView];
    
    // Initialize pet image with the pet's background, adds an animation
    // layer for the pet, and places both of these UIViews under the main view 
    // animation.
    
    self.animationView = [[UIView alloc] init];
    self.animationView.frame = self.view.bounds;
    pet_layer = self.animationView.layer;
    UIImage *img = [UIImage imageWithData:self.pet.ImageData];
    
    pet_layer.bounds = CGRectMake(CGRectGetWidth(self.view.frame) , CGRectGetHeight(self.view.frame), 150, 150);
    pet_layer.contents = (id)img.CGImage;
    pet_layer.minificationFilter = kCAFilterNearest;
    pet_layer.magnificationFilter = kCAFilterNearest;
    
    animator_ = [[HSFrameAnimator alloc] init];
    
    // Load frames
    NSMutableArray *frameset = [[[NSMutableArray alloc] init] autorelease];
    for (int i = 0; i < 6; i++) {
        NSString *filename = [NSString stringWithFormat:@"shoyruJump%d.tiff", i+1];
        UIImage *img = [UIImage imageNamed:filename];
        if(img) [frameset addObject:img];
    }
    [animator_ addFrameset:frameset forKey:@"shoyru_jump"];
    [animator_ registerSprite:pet_layer forFrameset:@"shoyru_jump" andAnimationMode:HSAnimationModeLoop];
    [animator_ setFramerate:1.77/15.0];
    [animator_ setCallback:self];
    [animator_ startTimer];
    [self.view addSubview:self.animationView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.backgroundImage release];
    [super viewWillDisappear:animated];
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
