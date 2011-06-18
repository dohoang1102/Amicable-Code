//
//  PetInformationTableViewController.m
//  Amicable CS193p
//
//  Created by Jim Zheng on 5/28/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "PetInformationTableViewController.h"
#import "PetPreviewController.h"

@interface PetInformationTableViewController()
@property (nonatomic, retain) NSArray *statusArray;
@property (nonatomic, retain) UIButton *dismissButton;
@end

@implementation PetInformationTableViewController

@synthesize delegate;
@synthesize pet;
@synthesize statusArray;
@synthesize dismissButton;

- (void)dealloc
{
    [pet release];
    [statusArray release];
    [dismissButton release];
    [super dealloc];
}

// we implement the getter and lazily instantiate.
-(NSArray *)statusArray
{   
    if(!statusArray)
    {
        statusArray = [[NSArray alloc] initWithObjects:@"Name", @"Birthday", @"Type", @"Health", @"Happiness", @"Sick Status", nil];
    }
    return statusArray;
    
}

-(void)dismissControllerWithNoSelection:(UIButton *)sender
{
    [self.delegate petInfoTableViewController:self didSelectField:nil];
}

#pragma mark - View lifecycle
#define DISMISS_BUTTON_SIDE_LEN (75/2)

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSBundle * appBundle = [NSBundle mainBundle];
    // Initialization of Food objects 
    NSString *petImagePath = [appBundle pathForResource:@"dismissButton" ofType:@"png"];
    CGFloat screenWidth = CGRectGetWidth(self.view.frame);
    CGFloat screenHeight = CGRectGetHeight(self.view.frame);
    
    // Place the dismiss button at the bottom center of the screen
    
    self.dismissButton = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth- DISMISS_BUTTON_SIDE_LEN)/2,(screenHeight - DISMISS_BUTTON_SIDE_LEN), DISMISS_BUTTON_SIDE_LEN, DISMISS_BUTTON_SIDE_LEN)];
    [self.dismissButton setBackgroundImage:[UIImage imageWithContentsOfFile:petImagePath] forState:UIControlStateNormal];
    [self.dismissButton addTarget:self action:@selector(dismissControllerWithNoSelection:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dismissButton];
    [self.view bringSubviewToFront:self.dismissButton];
    [self.dismissButton release];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    // TODO: Will eventually become the number of pets
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.statusArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [statusArray objectAtIndex:[indexPath row]];
    NSString *category = [self.statusArray objectAtIndex:[indexPath row]];
    UIImage *iconImage;
    
    NSBundle * appBundle = [NSBundle mainBundle];
    NSString *imagePath;
    NSString *isSick;
    
    NSDateFormatter *formatter;
    
    
    switch([indexPath row])
    {
        case 0:
            category = [NSString stringWithFormat:@"%@: %@", category, self.pet.Name];
            imagePath = [appBundle pathForResource:@"Contacts" ofType:@"png"];
            iconImage = [UIImage imageWithContentsOfFile:imagePath];
            break;
        case 1:
            // format the birthday to display correctly
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy"];
            //Optionally for time zone converstions
            [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"US/Pacific"]];
            category = [NSString stringWithFormat:@"%@: %@", category, [formatter stringFromDate:self.pet.Birthday]];
            [formatter release];

            imagePath = [appBundle pathForResource:@"Calendar2" ofType:@"png"];
            iconImage = [UIImage imageWithContentsOfFile:imagePath];
            break;
        case 2:
            category = [NSString stringWithFormat:@"%@: %@", category, self.pet.TypeOfPet];
            imagePath = [appBundle pathForResource:@"Search" ofType:@"png"];
            iconImage = [UIImage imageWithContentsOfFile:imagePath];
            break;
        case 3:
            category = [NSString stringWithFormat:@"%@: %@", category, self.pet.Health];
            imagePath = [appBundle pathForResource:@"Health" ofType:@"png"];
            iconImage = [UIImage imageWithContentsOfFile:imagePath];
            break;
        case 4:
            category = [NSString stringWithFormat:@"%@, %@", category, self.pet.Happiness];
            imagePath = [appBundle pathForResource:@"Sun" ofType:@"png"];
            iconImage = [UIImage imageWithContentsOfFile:imagePath];
            break;
        case 5:
            isSick = (self.pet.isSick) ? @"YES" : @"NO";
            category = [NSString stringWithFormat:@"%@: %@", category, isSick];
            imagePath = [appBundle pathForResource:@"NES" ofType:@"png"];
            iconImage = [UIImage imageWithContentsOfFile:imagePath];
            break;
    }
    cell.textLabel.text = category;
    cell.imageView.image = iconImage;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selected = [self.statusArray objectAtIndex:[indexPath row]];
    [self.delegate petInfoTableViewController:self didSelectField:selected];
}

@end
