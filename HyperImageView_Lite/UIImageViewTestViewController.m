//
//  UIImageTestViewController.m
//  HyperImageView
//
//  Created by hAmidReza on 4/13/14.
//  Copyright (c) 2014 hAmidReza. All rights reserved.
//

#import "UIImageViewTestViewController.h"
#import "myUIImageCell.h"

@interface UIImageViewTestViewController ()

@end

@implementation UIImageViewTestViewController

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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 65530;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 400;
}

-(UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

	static NSString *CellIdentifier = @"myTableViewCell1";
	myUIImageCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell)
	{
		cell = [[myUIImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.backgroundColor = [UIColor clearColor];
		cell.contentView.backgroundColor = [UIColor clearColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	NSString* fname = [NSString stringWithFormat:@"%03ld", (long)indexPath.row % 10 + 1];
	[cell.imageView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fname ofType:@"jpg"]]];
	
	return cell;
}

@end
