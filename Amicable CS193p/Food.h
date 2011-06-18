//
//  Food.h
//  Amicable CS193p
//
//  Created by Hongxia Zhong on 6/2/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Food : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * EffectPoint;
@property (nonatomic, retain) NSNumber * Price;
@property (nonatomic, retain) NSString * Name;
@property (nonatomic, retain) NSNumber * Count;
@property (nonatomic, retain) NSString * Description;
@property (nonatomic, retain) NSData * Image;
@property (nonatomic, retain) User * belongsToUser;

@end
