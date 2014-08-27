//
//  TLANewTweetVC.m
//  Tweet Like
//
//  Created by Shane Sniteman on 8/11/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "TLANewTweetVC.h"

@interface TLANewTweetVC () <UITextViewDelegate>

@end

@implementation TLANewTweetVC

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
    
    self.tweetTextView.layer.cornerRadius = 10;
    self.tweetTextView.delegate = self;
    
    UIImageView * swipeButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"swipe_button"]];
    
    swipeButton.frame = CGRectMake(135, 450, 60, 60);
    
    [self.view addSubview:swipeButton];
    
    
    self.redButton.layer.cornerRadius = 100;
    self.greenButton.layer.cornerRadius = 100;

    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (IBAction)saveTweet:(id)sender
{
    
    [self.tweets addObject:[@{
                              @"hearts" : @0,
                              @"text" : self.tweetTextView.text
                              
                              } mutableCopy]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
