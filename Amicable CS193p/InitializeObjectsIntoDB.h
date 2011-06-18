//
//  InitializeObjectsIntoDB.h
//  FinalProjectTemp
//
//  Created by Jim Zheng on 5/28/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InitializeObjectsIntoDB : NSObject

+(void)initializeObjectsForUser:(NSString *)userName InManagedContext:(NSManagedObjectContext *)context;

@end
