/*
 * Copyright 2010 Facebook
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0

 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "FBLoginButton.h"

@class DemoAppViewController;

@protocol DemoAppViewControllerDelegate
-(void)demoAppViewControllerLoggedIn:(DemoAppViewController *)sender;
@end

@interface DemoAppViewController : UIViewController
<FBRequestDelegate,
FBDialogDelegate,
FBSessionDelegate>
{    
  UILabel* _label;
  FBLoginButton* _fbButton;
  UIButton* _getUserInfoButton;
  Facebook* _facebook;
  NSArray* _permissions;
}

@property(nonatomic, retain) UILabel* label;
@property (nonatomic, retain) FBLoginButton *_fbButton;
@property(readonly) Facebook *facebook;

@property (assign) id <DemoAppViewControllerDelegate> delegate;
@end
