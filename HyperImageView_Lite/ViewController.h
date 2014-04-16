//
//  ViewController.h
//  HyperImageView
//
//  Created by hAmidReza on 4/13/14.
//  Copyright (c) 2014 hAmidReza. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIImageViewTestViewController;
@interface ViewController : UIViewController
{
	UIImageViewTestViewController* t;
}

-(IBAction)button_HyperImageView:(id)sender;
-(IBAction)button_UIImageView:(id)sender;
-(IBAction)twitterButton:(id)sender;
-(IBAction)faceBookButton:(id)sender;

@end
