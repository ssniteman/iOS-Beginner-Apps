//
//  SIGListTableViewCell.m
//  Signatures
//
//  Created by Shane Sniteman on 8/14/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "SIGListTableViewCell.h"

@implementation SIGListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.signatureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        [self.contentView addSubview:self.signatureView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
