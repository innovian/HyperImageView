//
//  myUIImageCell.m
//  HyperImageViewTest
//
//  Created by hAmidReza on 12/3/1392 AP.
//  Copyright (c) 1392 AP hAmidReza. All rights reserved.
//

#import "myUIImageCell.h"

@implementation myUIImageCell

@synthesize imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 400)];
		[self addSubview:imageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
