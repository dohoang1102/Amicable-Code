//
//  BrowseBackgroundViewController.h
//  Amicable CS193p
//
//  Created by Jim Zheng on 6/4/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrowseBackgroundViewController;

@protocol BrowseBackgroundViewcontrollerDelegate
- (void)changeBackGround:(BrowseBackgroundViewController *)sender
           toImageNamed:(NSString *)newImage;
@end

@interface BrowseBackgroundViewController : UIViewController <UIScrollViewDelegate>
{
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    
    BOOL pageControlIsChangingPage;
}

@property (nonatomic, retain) UIView *scrollView;
@property (nonatomic, retain) UIPageControl* pageControl;
@property (assign) id <BrowseBackgroundViewcontrollerDelegate> delegate;

/* for pageControl */
- (IBAction)changePage:(id)sender;

/* internal */
- (void)setupPage;

@end
