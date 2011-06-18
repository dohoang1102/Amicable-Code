//
//  AppInfoViewController.h
//  Amicable CS193p
//
//  Created by Hongxia Zhong on 6/5/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppInfoViewController;

@protocol AppInfoViewControllerDelegate
-(void)appInfoViewController:(AppInfoViewController *)sender;
@end

@interface AppInfoViewController : UIViewController

@property (assign) id <AppInfoViewControllerDelegate> delegate;

@end
