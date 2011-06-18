//
//  PetPreviewController.m
//  Amicable CS193p
//
//  Created by Jim Zheng on 5/28/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "PetPreviewController.h"
#import "Pet.h"
#import "PetInformationTableViewController.h"
#import "HSFrameAnimator.h"
#import "BrowseBackgroundViewController.h"
#import "DemoAppViewController.h"
#import "AppInfoViewController.h"

@interface PetPreviewController() <DemoAppViewControllerDelegate, BrowseBackgroundViewcontrollerDelegate>
{
    CALayer *pet_layer;
    HSFrameAnimator *animator_;
}

@property (nonatomic, retain) Pet *pet;
@property (nonatomic, retain) UIImage *petImage;
@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, retain) UIImageView *backgroundImageView;
@property (nonatomic, retain) UIView *animationView;
@property (nonatomic, retain) UIButton *infoButton; 
@end

@implementation PetPreviewController

@synthesize context;
@synthesize user;
@synthesize pet;
@synthesize backgroundImage;
@synthesize backgroundImageView;
@synthesize petImage;
@synthesize animationView;
@synthesize infoButton;

#pragma mark - Initialization

#define PET_ENTITY_NAME @"Pet"

- (Pet *)pet
{
    if (!pet && self.user) {
        pet = self.user.hasPet;
    }
    return pet;
}

#pragma mark - Custom getter/setters

- (UIImage *)petImage
{
    if (!petImage && self.pet) {
        NSData *petImageData = self.pet.ImageData;
        petImage = [[UIImage imageWithData:petImageData] retain];
    }
    return petImage;
}

#define DEFAULT_BACKGROUND @"pet_background3.png"
#define BACKGROUND_KEY @"savedBackground"

- (UIImage *)backgroundImage
{
    // we look first for a background name that's saved in NSUserDefaults. If none is present
    // then we set the default background picture.
    
    if (!backgroundImage) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *savedBackground = [defaults objectForKey:BACKGROUND_KEY];
        if(!savedBackground)
        {
            backgroundImage = [UIImage imageNamed:DEFAULT_BACKGROUND];
            [defaults setObject:DEFAULT_BACKGROUND forKey:BACKGROUND_KEY];
            [defaults synchronize];
        }
        else
        {
            backgroundImage = [UIImage imageNamed:savedBackground];
        }
    }
    return backgroundImage;
}

#pragma mark - View lifecycle

#define PET_INFO_BUTTON_TITLE @"Pet Info"

- (void)showAppInfo:(UIButton *)sender
{
    AppInfoViewController *aivc = [[AppInfoViewController alloc] init];
    [aivc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    aivc.delegate = self;
    [self presentModalViewController:aivc animated:YES];
    [aivc release];
}

-(void)animatePet:(UIButton *)sender
{
    [animator_ registerSprite:pet_layer forFrameset:@"shoyru_turn" andAnimationMode:HSAnimationModeOnce];
}

-(void)pushBrowseBackground:(UIButton *)sender
{
    BrowseBackgroundViewController *bbvc = [[BrowseBackgroundViewController alloc] init];
    [self.navigationController pushViewController:bbvc animated:YES];
    bbvc.delegate = self;
    [bbvc release];
}

- (UIBarButtonItem *)appInfoButton
{
    return [[[UIBarButtonItem alloc] initWithTitle:@"App Info!"
                                             style:UIBarButtonItemStyleBordered
                                            target:self
                                            action:@selector(showAppInfo:)] autorelease];
}

-(UIBarButtonItem *)browseBackgroundsButton
{
    return [[[UIBarButtonItem alloc] initWithTitle:@"Backgrounds"
                                             style:UIBarButtonItemStyleBordered
                                            target:self
                                            action:@selector(pushBrowseBackground:)] autorelease];
}


#pragma mark - View lifecycle, Facebook Integration
#define FB_LOGIN_KEY @"FacebookLoginKey"

-(void)viewWillAppear:(BOOL)animated
{
    [self.backgroundImageView setImage:self.backgroundImage];
    [super viewWillAppear:animated];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    self.title = @"Pet";
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        
    backgroundImageView= [[UIImageView alloc] init];
    backgroundImageView.frame = self.view.bounds;
    [self.view addSubview:backgroundImageView];
    [backgroundImageView release];

    // Initialize pet image with the pet's background, adds an animation
    // layer for the pet, and places both of these UIViews under the main view 
    // animation.
    
    
    animationView = [[UIView alloc] initWithFrame:self.view.frame];
    pet_layer = animationView.layer;
    UIImage *img = self.petImage;
    
    // set up code for animation
    pet_layer.bounds = CGRectMake(CGRectGetWidth(self.view.frame) , CGRectGetHeight(self.view.frame), 150, 150);
    pet_layer.contents = (id)img.CGImage;
    pet_layer.minificationFilter = kCAFilterNearest;
    pet_layer.magnificationFilter = kCAFilterNearest;
    
    // Create the sprite animator
    animator_ = [[HSFrameAnimator alloc] init];
    
    // Load frames
    NSMutableArray *frameset = [[[NSMutableArray alloc] init] autorelease];
    for (int i = 0; i < 11; i++) {
        NSString *filename = [NSString stringWithFormat:@"shoyru%d.tiff", i+1];
        UIImage *img = [UIImage imageNamed:filename];
        [frameset addObject:img];
    }
    [animator_ addFrameset:frameset forKey:@"shoyru_turn"];
    [animator_ registerSprite:pet_layer forFrameset:@"shoyru_turn" andAnimationMode:HSAnimationModeOnce];
    [animator_ setFramerate:1.77/15.0];
    [animator_ setCallback:self];
    [animator_ startTimer];
    [self.view addSubview:animationView];
    [animationView release];
    
    // Add buttons
    self.navigationItem.leftBarButtonItem = [self appInfoButton];
    self.navigationItem.rightBarButtonItem = [self browseBackgroundsButton];
    infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [infoButton setFrame:CGRectMake(0, 0, 50, 50)];
    [infoButton addTarget:self action:@selector(requestPetInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoButton];
    
    //[self PresentFacebookLogin];
}

- (void)tap:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self animatePet:NULL];
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.animationView addGestureRecognizer:tapGesture];
    [tapGesture release];
}

- (void)viewDidUnload
{
    [backgroundImageView release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark - PetInformationTableViewController delegate

// We present a view controller modally detailing the pet's health, status, 
// and other fields

-(void)requestPetInfo:(UIButton *)sender
{
    PetInformationTableViewController *pitvc = [[PetInformationTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [pitvc setTitle:@"Pet Information"];
    [pitvc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    pitvc.delegate = self;
    pitvc.pet = self.pet;
    [self presentModalViewController:pitvc animated:YES];
    [pitvc release];
}

-(void)petInfoTableViewController:(PetInformationTableViewController *)sender
                   didSelectField:(NSString *)field
{    
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - DemoAppViewController delegation

-(void)demoAppViewControllerLoggedIn:(DemoAppViewController *)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - BackgroundViewController delegate methods
-(void)changeBackGround:(BrowseBackgroundViewController *)sender
           toImageNamed:(NSString *)newImage
{
    [self setBackgroundImage:[UIImage imageNamed:newImage]];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - AppInfoViewController delegate methods
-(void)appInfoViewController:(AppInfoViewController *)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Autorotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Deallocation

- (void)dealloc
{
    [petImage release];
    [pet release];
    [backgroundImage release];
    [infoButton release];
    [animationView release];
    [user release];
    [context release];
    [super dealloc];
}

@end
