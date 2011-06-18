//
//  ExploreViewController.m
//  Amicable CS193p
//
//  Created by Hongxia Zhong on 5/30/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "ExploreViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Pet.h"
#import "PetInformationTableViewController.h"
#import "ExploreAnimationViewController.h"

@interface ExploreViewController() <MKMapViewDelegate, CLLocationManagerDelegate, PetInformationTableViewControllerDelegate>
@property (nonatomic, retain) Pet *pet;
@property (nonatomic, retain) CLLocationManager *locManager;
@property (readonly) MKMapView *mapView;
@property (nonatomic, retain) UISegmentedControl *mapModeControl;
@property (nonatomic, retain) UIBarButtonItem *petInfoButton;
@property (nonatomic, retain) UIBarButtonItem *animationButton;
@property (nonatomic, retain) ExploreAnimationViewController *eavc;
@property float totalExploreDistance;
@end

@implementation ExploreViewController

@synthesize user;
@synthesize context;
@synthesize pet;
@synthesize locManager;
@synthesize mapView;
@synthesize mapModeControl;
@synthesize petInfoButton;
@synthesize animationButton;
@synthesize totalExploreDistance;
@synthesize eavc;

#pragma mark - Initialization

#define UPDATE_DISTANCE_FILTER 5.0f

static NSString *petEntity = @"Pet";

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self) {
        self.locManager = [[[CLLocationManager alloc] init] autorelease];
        if (!self.locManager.locationServicesEnabled) {
            NSLog(@"User has opted out of location services.");
        }
        self.locManager.delegate = self;
        self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locManager.distanceFilter = UPDATE_DISTANCE_FILTER;
        totalExploreDistance = 0.0f;
    }
    return self;
}

- (Pet *)pet
{
    if (!pet) {
        pet = self.user.hasPet;
    }
    return pet;
}

- (ExploreAnimationViewController *)eavc
{
    if (!eavc) {
        eavc = [[ExploreAnimationViewController alloc] init];
    }
    return eavc;
}

#pragma mark - MapViewSetUp

- (MKMapView *)mapView
{
    if (!mapView) {
        mapView = [[MKMapView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        mapView.delegate = self;
    }
    return mapView;
}

#pragma mark - ExploreAnimationViewSetUp

- (void)animationButtonPressed:(UIButton *)sender
{
    if (self.mapView.hidden) {
        self.animationButton.title = @"Animation";
        self.mapView.hidden = NO;
        self.mapModeControl.hidden = NO;
        self.eavc.view.hidden = YES;
    } else {
        self.animationButton.title = @"Map";
        self.mapView.hidden = YES;
        self.mapModeControl.hidden = YES;
        self.eavc.view.hidden = NO;
    }
}

- (UIBarButtonItem *)animationButton
{
    if (!animationButton) {
        static NSString *animationButtonTitle = @"Animation";
        animationButton = [[UIBarButtonItem alloc] initWithTitle:animationButtonTitle style:UIBarButtonItemStyleBordered target:self action:@selector(animationButtonPressed:)];
    }
    return animationButton;
}

#pragma mark - PetInformationTableViewDelegate

-(void)petInfoTableViewController:(PetInformationTableViewController *)sender
                   didSelectField:(NSString *)field
{
    BOOL isMapHidden;
    if (self.mapView.hidden) isMapHidden = YES;
    else isMapHidden = NO;
    
    [self dismissModalViewControllerAnimated:YES];
    self.mapView.hidden = isMapHidden;
    self.mapModeControl.hidden = isMapHidden;
    self.eavc.view.hidden = (!isMapHidden);
}

- (void)petInfoButtonPressed:(UIButton *)sender
{
    PetInformationTableViewController *pitvc = [[PetInformationTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [pitvc setTitle:@"Pet Information"];
    [pitvc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    pitvc.delegate = self;
    pitvc.pet = self.pet;
    [self presentModalViewController:pitvc animated:YES];
    [pitvc release];
}

- (UIBarButtonItem *)petInfoButton
{
    if (!petInfoButton) {
        static NSString *popOverButtonTitle = @"Info";
        petInfoButton = [[UIBarButtonItem alloc] initWithTitle:popOverButtonTitle
                                                         style:UIBarButtonItemStyleBordered 
                                                        target:self action:@selector(petInfoButtonPressed:)];
    }
    return petInfoButton;
}

#pragma mark - Segmented Control

- (UISegmentedControl *)mapModeControl
{
    if (!mapModeControl) {
        NSArray *viewStyleArray = [NSArray arrayWithObjects:@"Map", @"Earth", @"Hybrid", nil];
        mapModeControl = [[UISegmentedControl alloc] initWithItems:viewStyleArray];
        mapModeControl.segmentedControlStyle = UISegmentedControlStyleBar;
        [mapModeControl addTarget:self
                           action:@selector(switchMapMode:)
                 forControlEvents:UIControlEventValueChanged];
    }
    return mapModeControl;
}

- (void)switchMapMode:(UISegmentedControl *)sender
{
    int selectedIndex = self.mapModeControl.selectedSegmentIndex;
    if (selectedIndex == 0) {
        self.mapView.mapType = MKMapTypeStandard;
    } else if (selectedIndex == 1) {
        self.mapView.mapType = MKMapTypeSatellite;
    } else if (selectedIndex == 2) {
        self.mapView.mapType = MKMapTypeHybrid;
    }
}

#pragma mark - CLLocation Manager Delegate

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Location manager error: %@", [error description]);
    return;
}

#define MAP_DISPLAY_SPAN 0.0005f

- (MKCoordinateSpan)spanOfMapDisplayRegion
{
    MKCoordinateSpan span;
    span.latitudeDelta = MAP_DISPLAY_SPAN;
    span.longitudeDelta = MAP_DISPLAY_SPAN;
    return span;
}

- (MKCoordinateRegion)findAppropriateRegionWithLocation:(CLLocation *)loc
{
    MKCoordinateRegion appropriateRegion;
    appropriateRegion.center = loc.coordinate;
    appropriateRegion.span = [self spanOfMapDisplayRegion];
    return appropriateRegion;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    self.mapView.region = [self findAppropriateRegionWithLocation:newLocation];
    totalExploreDistance += UPDATE_DISTANCE_FILTER;
}

#pragma mark - View lifecycle

#define MAP_MODE_CONTROL_OFFSET_X 10.0
#define MAP_MODE_CONTROL_OFFSET_Y 10.0

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.navigationItem.leftBarButtonItem = self.petInfoButton;
    self.navigationItem.rightBarButtonItem = self.animationButton;
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.mapModeControl];
    [self.view addSubview:self.eavc.view];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.locManager startUpdatingLocation];
    self.mapView.region = [self findAppropriateRegionWithLocation:self.locManager.location];
    self.mapModeControl.selectedSegmentIndex = 0;
}

- (void)viewDidUnload
{
    [self.locManager stopUpdatingLocation];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mapView.frame = self.view.bounds;
    self.mapView.hidden = NO;
    self.eavc.view.frame = self.view.bounds;
    //self.eavc.backgroundImage = [self backgroundImageForAnimationView];
    self.eavc.view.hidden = YES;
    
    
    float mapControlOriginX = self.mapView.bounds.origin.x + MAP_MODE_CONTROL_OFFSET_X;
    float mapControlOriginY = self.mapView.bounds.origin.y + self.mapView.bounds.size.height - self.mapModeControl.frame.size.height - MAP_MODE_CONTROL_OFFSET_Y;
    self.mapModeControl.frame = CGRectMake(mapControlOriginX, mapControlOriginY, self.mapModeControl.frame.size.width, self.mapModeControl.frame.size.height);
    self.mapModeControl.hidden = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Deallocation

- (void)dealloc
{
    [user release];
    [context release];
    [pet release];
    [locManager release];
    [mapView release];
    [mapModeControl release];
    [petInfoButton release];
    [animationButton release];
    [eavc release];
    [super dealloc];
}

@end
