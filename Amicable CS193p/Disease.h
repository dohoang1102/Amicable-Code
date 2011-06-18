//
//  Disease.h
//  Amicable CS193p
//
//  Created by Hongxia Zhong on 6/2/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Disease : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * Description;
@property (nonatomic, retain) NSString * Name;
@property (nonatomic, retain) NSNumber * EffectPoint;

@end
