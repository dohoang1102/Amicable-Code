//
//  Pet.h
//  Amicable CS193p
//
//  Created by Hongxia Zhong on 6/2/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Pet : NSManagedObject {
@private
}
@property (nonatomic, retain) NSDate * Birthday;
@property (nonatomic, retain) NSNumber * isSick;
@property (nonatomic, retain) NSData * ImageData;
@property (nonatomic, retain) NSNumber * Health;
@property (nonatomic, retain) NSString * TypeOfPet;
@property (nonatomic, retain) NSNumber * HungerLevel;
@property (nonatomic, retain) NSString * Name;
@property (nonatomic, retain) NSNumber * Happiness;
@property (nonatomic, retain) User * hasOwner;

@end
