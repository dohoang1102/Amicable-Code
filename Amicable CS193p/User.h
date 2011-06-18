//
//  User.h
//  Amicable CS193p
//
//  Created by Hongxia Zhong on 6/2/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Food, Medicine, Pet, Weapon;

@interface User : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * Gender;
@property (nonatomic, retain) NSNumber * Money;
@property (nonatomic, retain) NSString * Name;
@property (nonatomic, retain) NSString * Email;
@property (nonatomic, retain) Pet * hasPet;
@property (nonatomic, retain) NSSet* hasMedicine;
@property (nonatomic, retain) NSSet* hasFood;
@property (nonatomic, retain) NSSet* hasWeapon;

@end
