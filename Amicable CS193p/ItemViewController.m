//
//  ItemViewController.m
//  Amicable CS193p
//
//  Created by Hongxia Zhong on 5/26/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "ItemViewController.h"
#import "User_Init.h"
#import "Food.h"
#import "Food_Init.h"
#import "Weapon.h"
#import "Weapon_Init.h"
#import "Medicine.h"
#import "Medicine_Init.h"

@interface ItemViewController() <UIActionSheetDelegate>
@property (nonatomic, retain) NSData *imageData;
@property (readonly) UIImageView *imageView;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) UIAlertView *alertView;
@end

@implementation ItemViewController {
    IBOutlet UITextView *descriptionView;
    IBOutlet UIButton *purchaseButton;
    IBOutlet UIButton *sellButton;
    IBOutlet UILabel *countLabel;
    IBOutlet UILabel *moneyLabel;
    IBOutlet UIScrollView *scrollView;
}

@synthesize user;
@synthesize context;
@synthesize category;
@synthesize item;
@synthesize imageData;
@synthesize imageView;
@synthesize description;
@synthesize alertView;

- (NSString *)itemNameString
{
    NSString *itemName;
    if (self.item && self.category) {
        if ([self.category isEqualToString:@"Food"]) {
            Food *foodItem = (Food *)self.item;
            itemName = foodItem.Name;
        } else if ([self.category isEqualToString:@"Weapon"]) {
            Weapon *weaponItem = (Weapon *)self.item;
            itemName = weaponItem.Name;
        } else if ([self.category isEqualToString:@"Medicine"]) {
            Medicine *medicineItem = (Medicine *)self.item;
            itemName = medicineItem.Name;
        }
    }
    return itemName;
}

- (int)itemCount
{
    int count = 0;
    if (self.item && self.category) {
        if ([self.category isEqualToString:@"Food"]) {
            Food *foodItem = (Food *)self.item;
            count = [foodItem.Count intValue];
        } else if ([self.category isEqualToString:@"Weapon"]) {
            Weapon *weaponItem = (Weapon *)self.item;
            count = [weaponItem.Count intValue];
        } else if ([self.category isEqualToString:@"Medicine"]) {
            Medicine *medicineItem = (Medicine *)self.item;
            count = [medicineItem.Count intValue];
        }
    }
    return count;
}

- (NSString *)itemCountString
{
    NSString *countText = @"Count: ";
    return [countText stringByAppendingString:[NSString stringWithFormat:@"%d", [self itemCount]]];
}

- (NSString *)userMoneyString
{
    NSString *moneyText = @"Money: ";
    int money = [self.user.Money intValue];
    return [moneyText stringByAppendingString:[NSString stringWithFormat:@"%d", money]];
}

- (NSData *)imageData
{
    if (!imageData && self.item && self.category) {
        if ([self.category isEqualToString:@"Food"]) {
            Food *foodItem = (Food *)self.item;
            imageData = [foodItem.Image retain];
        } else if ([self.category isEqualToString:@"Weapon"]) {
            Weapon *weaponItem = (Weapon *)self.item;
            imageData = [weaponItem.Image retain];
        } else if ([self.category isEqualToString:@"Medicine"]) {
            Medicine *medicineItem = (Medicine *)self.item;
            imageData = [medicineItem.Image retain];
        }
    }
    return imageData;
}

- (NSString *)description
{
    if (!description && self.item && self.category) {
        if ([self.category isEqualToString:@"Food"]) {
            Food *foodItem = (Food *)self.item;
            description = [foodItem.Description retain];
        } else if ([self.category isEqualToString:@"Weapon"]) {
            Weapon *weaponItem = (Weapon *)self.item;
            description = [weaponItem.Description retain];
        } else if ([self.category isEqualToString:@"Medicine"]) {
            Medicine *medicineItem = (Medicine *)self.item;
            description = [medicineItem.Description retain];
        }
    }
    return description;
}

- (UIImageView *)imageView
{
    if (!imageView) imageView = [[UIImageView alloc] init];
    return imageView;
}

- (UIAlertView *)alertView
{
    if (!alertView) {
        static NSString *alertViewTitle = @"Warning";
        static NSString *cancelButtonTitle = @"OK";
        alertView = [[UIAlertView alloc] initWithTitle:alertViewTitle message:@"" delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    }
    return alertView;
}

#pragma mark - View lifecycle

/*// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    self.view = self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
}*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [self itemNameString];
    self.imageView.image = [UIImage imageWithData:self.imageData];
    [self.imageView sizeToFit];
    scrollView.delegate = self; //TO_ADD
    [scrollView addSubview:self.imageView];
    
    NSString *descriptionText = self.description;
    descriptionView.editable = NO;
    NSLog(@"Description View has: %@", descriptionText);
    descriptionView.text = descriptionText;
    countLabel.text = [self itemCountString];
    moneyLabel.text = [self userMoneyString];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    descriptionView = nil;
    purchaseButton = nil;
    sellButton = nil;
    countLabel = nil;
    moneyLabel = nil;
    scrollView = nil;
}

- (float)calculateZoomScaleOfImageSize
{
   /* float widthScale =  scrollView.bounds.size.width/self.imageView.frame.size.width;
    float heightScale = scrollView.bounds.size.height/self.imageView.frame.size.height;
    if (widthScale > heightScale) return widthScale;
    return heightScale;*/
    return 1.0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    scrollView.zoomScale = [self calculateZoomScaleOfImageSize];
}

- (void)incrementItemCountByValue:(int)value
{
    if (self.item && self.category) {
        if ([self.category isEqualToString:@"Food"]) {
            Food *foodItem = (Food *)self.item;
            int count = [foodItem.Count intValue];
            foodItem.Count = [NSNumber numberWithInt:count + value];
            [Food performSelector:@selector(autosave:) withObject:self.context afterDelay:0.2];
        } else if ([self.category isEqualToString:@"Weapon"]) {
            Weapon *weaponItem = (Weapon *)self.item;
            int count = [weaponItem.Count intValue];
            weaponItem.Count = [NSNumber numberWithInt:count + value];
            [Weapon performSelector:@selector(autosave:) withObject:self.context afterDelay:0.2];
        } else if ([self.category isEqualToString:@"Medicine"]) {
            Medicine *medicineItem = (Medicine *)self.item;
            int count = [medicineItem.Count intValue];
            medicineItem.Count = [NSNumber numberWithInt:count + value];
            [Medicine performSelector:@selector(autosave:) withObject:self.context afterDelay:0.2];
        }
    }
}

//TO_ADD
- (int)getItemPrice
{
    int price = 0;
    if (self.item && self.category) {
        if ([self.category isEqualToString:@"Food"]) {
            Food *foodItem = (Food *)self.item;
            price = [foodItem.Price intValue];
        } else if ([self.category isEqualToString:@"Weapon"]) {
            Weapon *weaponItem = (Weapon *)self.item;
            price = [weaponItem.Price intValue];
        } else if ([self.category isEqualToString:@"Medicine"]) {
            Medicine *medicineItem = (Medicine *)self.item;
            price = [medicineItem.Price intValue];        
        }
    }
    return price;
}

//TO_ADD
- (int)getUserMoney
{
    return [self.user.Money intValue];
}

//TO_ADD
- (void)updateUserMoneyWithPrice:(int)price
{
    self.user.Money = [NSNumber numberWithInt:([self getUserMoney]-price)];
    [User performSelector:@selector(autosave:) withObject:self.context afterDelay:0.2];
}

//TO_ADD
- (IBAction)purchaseItem {
    if ([self getUserMoney] >= [self getItemPrice]) {
        [self incrementItemCountByValue:1];
        [self updateUserMoneyWithPrice:[self getItemPrice]];
        countLabel.text = [self itemCountString];
        moneyLabel.text = [self userMoneyString];
    } else {
        static NSString *message = @"Sorry! Not have enough money.";
        self.alertView.message = message;
        [self.alertView show];
    }
}

//TO_ADD
- (IBAction)sellItem {
    if ([self itemCount] > 0) {
        [self incrementItemCountByValue:-1];
        [self updateUserMoneyWithPrice:-(int)([self getItemPrice]/2)];
        countLabel.text = [self itemCountString];
        moneyLabel.text = [self userMoneyString];
    } else {
        static NSString *message = @"Sorry! Item not found.";
        self.alertView.message = message;
        [self.alertView show];
    }
}

#pragma mark - Autorotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Deallocation

- (void)dealloc
{
    [alertView release];
    [user release];
    [context release];
    [category release];
    [item release];
    [imageData release];
    [imageView release];
    [description release];
    [super dealloc];
}

@end
