//
//  HyperImageViewViewController.h
//  HyperImageView
//
//  Created by hAmidReza on 4/13/14.
//  Copyright (c) 2014 hAmidReza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HyperImageViewViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView* tableView;
@property (retain, nonatomic) IBOutlet UIView* cachePlaceHolder;
@property (retain, nonatomic) IBOutlet UIProgressView* progressView;

@end
