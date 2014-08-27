//
//  TLATweetCell.m
//  Tweet Like
//
//  Created by Shane Sniteman on 8/11/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "TLATweetCell.h"

#import <Parse/Parse.h>

@implementation TLATweetCell

// IN STORYBOARD, INIT WITH CODER IS THE ONLY THING THAT WORKS

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        
        UIImageView * heart = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"heart"]];
        
        heart.frame = CGRectMake(20, 20, 20, 20);
        
        [self.contentView addSubview:heart];
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        
        [button addTarget:self action:@selector(heartClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:button];
    }
    return self;
}

- (void)heartClicked
{
    int hearts = [self.tweetWithLike[@"hearts"] intValue];
    
    self.tweetWithLike[@"hearts"] = @(hearts + 1);
    
    [self.tweetWithLike saveInBackground];
    
    [self.delegate heartsUpdated];
    
    // self.delegate updateHeartCount
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
