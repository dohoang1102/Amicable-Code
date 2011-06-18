//
//  BrowseBackgroundViewController.m
//  Amicable CS193p
//
//  Created by Jim Zheng on 6/4/11.
//  Copyright 2011 Stanford University. All rights reserved.
//

#import "BrowseBackgroundViewController.h"


@implementation BrowseBackgroundViewController
@synthesize scrollView;
@synthesize pageControl;
@synthesize delegate;

- (void)dealloc
{
    [scrollView release];
    [pageControl release];
    [super dealloc];
}

#pragma mark - View lifecycle

#define BACKGROUND_KEY @"savedBackground"

-(void)changeBackgroundTo:(UIButton *)sender
{
    int curPage = self.pageControl.currentPage; 
    NSString *backgroundPicToSave = [NSString stringWithFormat:@"pet_background%d.png", curPage + 1];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:backgroundPicToSave forKey:BACKGROUND_KEY];
    [defaults synchronize];
    
    [self.delegate changeBackGround:self toImageNamed:backgroundPicToSave];
}

-(void)setupSelectionButton
{
    self.navigationItem.rightBarButtonItem = 
    [[[UIBarButtonItem alloc] initWithTitle:@"Select"
                                      style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(changeBackgroundTo:)] autorelease];
}

- (void)viewDidLoad
{
    [self setupPage];
    [self setupSelectionButton];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - setting up the display items and page



// set up a series of UIImageViews to place into a scrollview
// so that the user can scroll in between. We also link the 
// scroling to a page control so that scrolling changes 
// the dots in the page control

- (void)setupPage
{
	scrollView.delegate = self;
    
	[self.scrollView setBackgroundColor:[UIColor blackColor]];
	[scrollView setCanCancelContentTouches:NO];
	
	scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView.clipsToBounds = YES;
	scrollView.scrollEnabled = YES;
	scrollView.pagingEnabled = YES;
	
	NSUInteger nimages = 1;
	CGFloat cx = 0;
	for (; ; nimages++) {
		NSString *imageName = [NSString stringWithFormat:@"pet_background%d.png", (nimages + 1)];
		UIImage *image = [UIImage imageNamed:imageName];
		if (image == nil) {
			break;
		}
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        CGRect imageFrame = CGRectMake(cx , 0 ,CGRectGetWidth(scrollView.bounds), CGRectGetHeight(scrollView.bounds));
        [imageView setFrame:imageFrame];
        
		[scrollView addSubview:imageView];
		[imageView release];
        
		cx += scrollView.frame.size.width;
	}
    
	self.pageControl.numberOfPages = nimages - 1;
	[scrollView setContentSize:CGSizeMake(cx, [scrollView bounds].size.height)];
}

#pragma mark -
#pragma mark UIScrollViewDelegate stuff
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    if (pageControlIsChangingPage) {
        return;
    }
    
	/*
	 *	We switch page at 50% across
	 */
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView 
{
    pageControlIsChangingPage = NO;
}

#pragma mark -
#pragma mark PageControl stuff
- (IBAction)changePage:(id)sender 
{
	/*
	 *	Change the scroll view
	 */
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
	
    [scrollView scrollRectToVisible:frame animated:YES];
    
	/*
	 *	When the animated scrolling finishings, scrollViewDidEndDecelerating will turn this off
	 */
    pageControlIsChangingPage = YES;
}

@end
