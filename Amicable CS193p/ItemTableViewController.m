//
//  ItemTableViewController.m
//  Amicable CS193p
//
//  Created by Hongxia Zhong on 6/2/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "ItemTableViewController.h"
#import "ItemViewController.h"
#import "Food.h"
#import "Weapon.h"
#import "Medicine.h"

@interface ItemTableViewController()
@property (nonatomic, retain) UIImageView *backgroundImageView;
@end

@implementation ItemTableViewController

@synthesize category;
@synthesize user;
@synthesize items;
@synthesize context;
@synthesize backgroundImageView;

#pragma mark - Initialization

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
    self.title = self.category;
    self.tableView.separatorColor = [UIColor blackColor];    
    self.tableView.backgroundView = self.backgroundImageView;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
    return [self.items count];
}

- (NSString *)nameOfItem:(id)item
{
    NSString *itemName;
    if ([self.category isEqualToString:@"Food"]) {
        itemName = ((Food *)item).Name;
    } else if ([self.category isEqualToString:@"Weapon"]) {
        itemName = ((Weapon *)item).Name;
    } else if ([self.category isEqualToString:@"Medicine"]) {
        itemName = ((Medicine *)item).Name;
    }
    return itemName;
}

- (int)numberOfItem:(id)item
{
    int count = 0;
    if ([self.category isEqualToString:@"Food"]) {
        count = [((Food *)item).Count intValue];
    } else if ([self.category isEqualToString:@"Weapon"]) {
        count = [((Weapon *)item).Count intValue];
    } else if ([self.category isEqualToString:@"Medicine"]) {
        count = [((Medicine *)item).Count intValue];
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ItemTableViewController_Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    id item = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = [self nameOfItem:item];
    cell.textLabel.font = [UIFont fontWithName:@"Marker felt" size:20];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor lightGrayColor];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemViewController *ivc = [[ItemViewController alloc] init];
    ivc.context = self.context;
    ivc.category = self.category;
    ivc.item = [self.items objectAtIndex:indexPath.row];
    ivc.user = self.user;
    [self.navigationController pushViewController:ivc animated:YES];
    [ivc release];
}

#pragma mark - Autorotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Deallocation

- (void)dealloc
{
    [category release];
    [items release];
    [user release];
    [context release];
    [backgroundImageView release];
    [super dealloc];
}

@end
