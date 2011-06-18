//
//  InitializeObjectsIntoDB.m
//  FinalProjectTemp
//
//  Created by Jim Zheng on 5/28/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "InitializeObjectsIntoDB.h"
#import "User_Init.h"
#import "Food_Init.h"
#import "Weapon_Init.h"
#import "Medicine_Init.h"
#import "Pet_Init.h"

@interface InitializeObjectsIntoDB()

+(void)InitializeUser:(NSString *)userName InContext:(NSManagedObjectContext *)context;
+(Pet *)InitializePetInContext:(NSManagedObjectContext *)context;
+(NSSet *)InitializeFoodInContext:(NSManagedObjectContext *)context;
+(NSSet *)InitializeMedicineInContext:(NSManagedObjectContext *)context;
+(NSSet *)InitializeWeaponInContext:(NSManagedObjectContext *)context;

@end

@implementation InitializeObjectsIntoDB

+ (void)initializeObjectsForUser:(NSString *)userName InManagedContext:(NSManagedObjectContext *)context
{
    [self InitializeUser:userName InContext:context];
}

+(void)InitializeUser:(NSString *)userName InContext:(NSManagedObjectContext *)context
{
    Pet *pet = [self InitializePetInContext:context];
    NSSet *foods = [self InitializeFoodInContext:context];
    NSLog(@" username is : %@, count is : %d", userName, [foods count]);
    NSSet *medicines = [self InitializeMedicineInContext:context];
    NSSet *weapons = [self InitializeWeaponInContext:context];
    [User userWithName:userName withGender:@"male" withEmail:@"hzhong62@stanford.edu" withMoney:1000 withPet:pet withFoods:foods withWeapons:weapons withMedicines:medicines inManagedObjectContext:context];
}

+(Pet *)InitializePetInContext:(NSManagedObjectContext *)context
{
    NSBundle * appBundle = [NSBundle mainBundle];
    // Initialization of Food objects 
    NSString *petImagePath = [appBundle pathForResource:@"shoyru1" ofType:@"tiff"];
    NSData *petImageData = [NSData dataWithContentsOfFile:petImagePath];

    // Pet initialization
    NSString *petName = @"JackOfAllTrades";
    Pet *myPet = [Pet petWithName:petName withTypeOfPet:@"Dragon" withBirthday:[NSDate date] withHealth:(double)100 withHappiness:(double)100 withHungerLevel:0 withImageData:petImageData isSick:0 inManagedObjectContext:context];
    return myPet;
}

+(NSSet *)InitializeFoodInContext:(NSManagedObjectContext *)context
{
    // Initialize objects to be stored in the database. 
    NSBundle * appBundle = [NSBundle mainBundle];
    
    Food *food;
    NSMutableSet *foods = [NSMutableSet setWithObjects:nil];
    
    // Initialization of Food objects 
    NSString *foodImagePath = [appBundle pathForResource:@"carrot" ofType:@"gif"];
    NSData *foodImage = [NSData dataWithContentsOfFile:foodImagePath];
    food = [Food foodWithName:@"Carrot" withDescription:@"A healthy carrot!" withImage:foodImage withPrice:10 withEffectPoint:2 withCount:0 inManagedObjectContext:context];
    [foods addObject:food];
    
    foodImagePath = [appBundle pathForResource:@"redapple" ofType:@"gif"];
    foodImage = [NSData dataWithContentsOfFile:foodImagePath];
    food = [Food foodWithName:@"Red Apple" withDescription:@"An apple a day keeps the doctor away!" withImage:foodImage withPrice:15 withEffectPoint:4 withCount:0 inManagedObjectContext:context];
    [foods addObject:food];
    
    foodImagePath = [appBundle pathForResource:@"greenapple" ofType:@"gif"];
    foodImage = [NSData dataWithContentsOfFile:foodImagePath];
    food = [Food foodWithName:@"Green Apple" withDescription:@"Beware the green apple..." withImage:foodImage withPrice:15 withEffectPoint:4 withCount:0 inManagedObjectContext:context];
    [foods addObject:food];
    
    foodImagePath = [appBundle pathForResource:@"goldenapple" ofType:@"gif"];
    foodImage = [NSData dataWithContentsOfFile:foodImagePath];
    food = [Food foodWithName:@"Golden Apple" withDescription:@"The glorious golden apple; What effects does it have...?" withImage:foodImage withPrice:45 withEffectPoint:10 withCount:0 inManagedObjectContext:context];
    [foods addObject:food];
    
    foodImagePath = [appBundle pathForResource:@"hotdog" ofType:@"gif"];
    foodImage = [NSData dataWithContentsOfFile:foodImagePath];
    food = [Food foodWithName:@"Hot Dog" withDescription:@"Wow, this hot dog is spicy!" withImage:foodImage withPrice:20 withEffectPoint:5 withCount:0 inManagedObjectContext:context];
    [foods addObject:food];
    
    return foods;
}

+(NSSet *)InitializeMedicineInContext:(NSManagedObjectContext *)context
{
    NSMutableSet *medicines = [NSMutableSet setWithObjects:nil];
    return medicines;
}

+(NSSet *)InitializeWeaponInContext:(NSManagedObjectContext *)context
{
    NSMutableSet *weapons = [NSMutableSet setWithObjects:nil];
    return weapons;
}


@end
