//
//  TLANewTweetVC.h
//  Tweet Like
//
//  Created by Shane Sniteman on 8/11/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLANewTweetVC : UIViewController

// adding this manually so view controllers can talk to each other

@property (nonatomic) NSMutableArray * tweets;



@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@property (weak, nonatomic) IBOutlet UIView *greenButton;
@property (weak, nonatomic) IBOutlet UIView *redButton;

// IBAction is a method

- (IBAction)saveTweet:(id)sender;

@end
