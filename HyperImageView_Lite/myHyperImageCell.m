//
//  myImageCell.m
//  HyperImageViewTest
//
//  Created by hAmidReza on 12/3/1392 AP.
//  Copyright (c) 1392 AP hAmidReza. All rights reserved.
//

#import "myHyperImageCell.h"
#import "HyperImageView.h"

@implementation myHyperImageCell
@synthesize hyperImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		hyperImageView = [[HyperImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 400)];
		[hyperImageView setVerboseMode:YES];
		[hyperImageView setHyperImageViewDefaultDIR:[@"~/Documents/HyperImageViewCache/" stringByExpandingTildeInPath]];
		[self addSubview:hyperImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
