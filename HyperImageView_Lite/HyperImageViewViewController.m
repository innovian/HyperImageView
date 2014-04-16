//
//  HyperImageViewViewController.m
//  HyperImageView
//
//  Created by hAmidReza on 4/13/14.
//  Copyright (c) 2014 hAmidReza. All rights reserved.
//

#import "HyperImageViewViewController.h"
#import "myHyperImageCell.h"
#import "HyperImageView.h"

@interface HyperImageViewViewController ()

@end

@implementation HyperImageViewViewController

@synthesize tableView, cachePlaceHolder, progressView;

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
	NSString* myHyperCacheDIR = [@"~/Documents/HyperImageViewCache/" stringByExpandingTildeInPath];
	
	[[NSFileManager defaultManager] createDirectoryAtPath:myHyperCacheDIR withIntermediateDirectories:NO attributes:nil error:nil];
	
	NSArray* paths = [[NSBundle mainBundle] pathsForResourcesOfType:@"jpg" inDirectory:@""];
	
	SEL progressInvoSEL = @selector(hyperCacheProgressCallBack:);
	NSMethodSignature* progressSign = [self methodSignatureForSelector:progressInvoSEL];
	NSInvocation* progressInvo = [NSInvocation invocationWithMethodSignature:progressSign];
	progressInvo.selector = progressInvoSEL;
	progressInvo.target = self;
	
	SEL finishInvoSEL = @selector(hyperCacheFinishCallBack);
	NSMethodSignature* finishSign = [self methodSignatureForSelector:finishInvoSEL];
	NSInvocation* finishInvo = [NSInvocation invocationWithMethodSignature:finishSign];
	finishInvo.selector = finishInvoSEL;
	finishInvo.target = self;

	CGSize size = CGSizeMake(768, 400);
	[HyperImageView cacheImagesWithPaths:paths forSize:size finishCallBack:finishInvo progressInvocation:progressInvo cacheDIR:myHyperCacheDIR priority:hyperIMGCachePriority_Background verboseMode:NO];
	
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)hyperCacheProgressCallBack:(NSNumber*)percent
{
	progressView.progress = [percent floatValue] / 100;
}

-(void)hyperCacheFinishCallBack
{
	tableView.delegate = self;
	tableView.dataSource = self;
	[tableView reloadData];
	
	tableView.transform = CGAffineTransformMakeScale(.8, .8);
	
	[UIView animateWithDuration:1 animations:^{
		tableView.transform = CGAffineTransformMakeScale(1, 1);
		tableView.alpha = 1;
		cachePlaceHolder.alpha = 0;
	}];
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
	static NSString *CellIdentifier = @"myTableViewCell2";
	myHyperImageCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell)
	{
		cell = [[myHyperImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.backgroundColor = [UIColor clearColor];
		cell.contentView.backgroundColor = [UIColor clearColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	NSString* fname = [NSString stringWithFormat:@"%03ld", (long)indexPath.row % 10 + 1];
	[cell.hyperImageView loadImageWithPath:[[NSBundle mainBundle] pathForResource:fname ofType:@"jpg"] priority:hyperIMGCachePriority_Default];
	
	return cell;
	
}


@end
