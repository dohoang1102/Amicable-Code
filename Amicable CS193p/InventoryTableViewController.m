//
//  InventoryTableViewController.m
//  Amicable 193p
//
//  Created by Hongxia Zhong on 5/25/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "InventoryTableViewController.h"
#import "ItemTableViewController.h"

@interface InventoryTableViewController()
@property (nonatomic, retain) NSArray *categories;
@property (nonatomic, retain) UIImageView *backgroundImageView;
@end

@implementation InventoryTableViewController

@synthesize context;
@synthesize user;
@synthesize categories;
@synthesize backgroundImageView;

#pragma mark - Initialization

- (NSArray *)categories
{
    if (!categories) {
        categories = [[NSArray alloc] initWithObjects:@"Foods", @"Weapons", @"Medicines", nil];
    }
    return categories;
}

-(UIImageView *)backgroundImageView
{
    if(!backgroundImageView)
    {
        backgroundImageView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inventory_background.png"]];
        backgroundImageView.frame = [[UIScreen mainScreen] bounds];
    }
    return backgroundImageView;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor blackColor];
    [self.tableView setBackgroundView:self.backgroundImageView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    //[self.backgroundImageView release];
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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InventoryTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text  = [self.categories objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Marker felt" size:20];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

#pragma mark - Table view delegate

- (NSArray *)getItemOfCategory:(NSString *)category
{
    NSArray *items;
    if ([category isEqualToString:@"Food"]) {
        NSSet *itemSet = self.user.hasFood;
        items = [NSArray arrayWithArray:[itemSet allObjects]];
    } else if ([category isEqualToString:@"Weapon"]) {
        NSSet *itemSet = self.user.hasWeapon;
        items = [NSArray arrayWithArray:[itemSet allObjects]];
    } else if ([category isEqualToString:@"Medicine"]) {
        NSSet *itemSet = self.user.hasMedicine;
        items = [NSArray arrayWithArray:[itemSet allObjects]];   
    }
    return items;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    NSString *categoryName = [self.categories objectAtIndex:indexPath.row];
    
    ItemTableViewController *itvc = [[ItemTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    itvc.context = self.context;
    itvc.user = self.user;
    itvc.items = [self getItemOfCategory:[categoryName substringToIndex:[categoryName length]-1]];
    itvc.category = [categoryName substringToIndex:[categoryName length]-1];
    
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:itvc animated:YES];
    [itvc release];
}

#pragma mark - Autorotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Deallocation

- (void)dealloc
{
    [context release];
    [user release];
    [categories release];
    [backgroundImageView release];
    [super dealloc];
}

@end
