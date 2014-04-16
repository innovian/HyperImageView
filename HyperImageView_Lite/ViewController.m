//
//  ViewController.m
//  HyperImageView
//
//  Created by hAmidReza on 4/13/14.
//  Copyright (c) 2014 hAmidReza. All rights reserved.
//

#import "ViewController.h"
#import "HyperImageViewViewController.h"
#import "UIImageViewTestViewController.h"
#import "HyperImageView.h"
//#import <myfake1/HyperImageView.h>

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)button_HyperImageView:(id)sender
{
	HyperImageViewViewController* hyperView = [[HyperImageViewViewController alloc] initWithNibName:@"HyperImageViewViewController" bundle:nil];
	[self presentViewController:hyperView animated:YES completion:^{}];
}

-(void)button_UIImageView:(id)sender
{
	UIImageViewTestViewController* uiimageView = [[UIImageViewTestViewController alloc] initWithNibName:@"UIImageViewTestViewController" bundle:nil];
		[self presentViewController:uiimageView animated:YES completion:^{}];
}

-(void)twitterButton:(id)sender
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/intent/user?screen_name=xerxes235"]];
}

-(void)faceBookButton:(id)sender
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/xerxes235"]];
}

@end
