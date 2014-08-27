//
//  TLATweetCell.h
//  Tweet Like
//
//  Created by Shane Sniteman on 8/11/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFObject;

@protocol TLATweetCellDelegate;


@interface TLATweetCell : UITableViewCell

@property (nonatomic) PFObject * tweetWithLike;

@property (weak, nonatomic) IBOutlet UILabel *heartCountLabel;

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@property (nonatomic,assign) id <TLATweetCellDelegate> delegate;

@end

@protocol TLATweetCellDelegate <NSObject>

-(void)heartsUpdated;

@end
