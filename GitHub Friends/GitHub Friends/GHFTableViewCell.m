//
//  GHFTableViewCell.m
//  GitHub Friends
//
//  Created by Shane Sniteman on 7/24/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "GHFTableViewCell.h"
#import "GHFViewController.h"

@implementation GHFTableViewCell

{
    UILabel * friendName;
    UILabel * friendLocation;
    UIImageView * friendImage;
    UIButton * nextViewButton;
    UIButton * rightNumberButton;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor lightGrayColor];
        
    friendName = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 200, 40)];
        
        friendName.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:25];
        friendName.textColor = [UIColor whiteColor];
        [self.contentView addSubview:friendName];
        
        friendImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self.contentView addSubview:friendImage];
        
        
    friendLocation = [[UILabel alloc] initWithFrame:CGRectMake(120, 30, 210, 50)];
        friendLocation.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15];
        friendLocation.textColor = [UIColor grayColor];
        [self.contentView addSubview:friendLocation];
        
        
        ///// BUTTONS
        
        rightNumberButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 75, 30, 30)];
        
        rightNumberButton.backgroundColor = [UIColor whiteColor];
        rightNumberButton.layer.cornerRadius = 15;
    
        [rightNumberButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [self.contentView addSubview:rightNumberButton];
        
        
        /*
         
         UIViewController has a UIView property called .view
         UITableViewController has a UIView property called .tableView
         UITableViewCell has a UIVIew property called .contentView
         
         */
    
        

        UIButton * gistButton = [[UIButton alloc] initWithFrame:CGRectMake( 225, 75, 80, 30)];
        
        [self.contentView addSubview:gistButton];
        
        gistButton.backgroundColor = [UIColor grayColor];
        gistButton.layer.cornerRadius = 15;
        gistButton.layer.borderWidth = 1;
        gistButton.layer.borderColor = [UIColor whiteColor].CGColor;
        [gistButton setTitle:@"Gists" forState:UIControlStateNormal];
        
        [gistButton addTarget:self action:@selector(gistButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton * upDownButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 75, 30, 30)];
        
        upDownButton.backgroundColor = [UIColor grayColor];
        upDownButton.layer.cornerRadius = 15;
        [self.contentView addSubview:upDownButton];
        
        
        
        UIButton * leftNumberButton = [[UIButton alloc] initWithFrame:CGRectMake(140, 75, 30, 30)];
        
        leftNumberButton.backgroundColor = [UIColor greenColor];
        leftNumberButton.layer.cornerRadius = 15;
        [self.contentView addSubview:leftNumberButton];
        
        
        
//        UIButton * nextViewButton = [[UIButton alloc] initWithFrame:CGRectMake(275, 15, 30, 30)];
//        
//        nextViewButton.backgroundColor = [UIColor redColor];
//        nextViewButton.layer.cornerRadius = 15;
//        [self.contentView addSubview:nextViewButton];
        
    
       //// PNG Images
        
        nextViewButton = [[UIButton alloc] initWithFrame:CGRectMake(275, 15, 30, 30)];
        
        [nextViewButton setImage:[UIImage imageNamed:@"profileArrow"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:nextViewButton];
        
        [nextViewButton addTarget:self action:@selector(nextViewButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        
        ///// PICTURE /////

        friendImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 110, 110)];
        
        [self.contentView addSubview:friendImage];
        
        
        ///// TEXT /////
    
//        UILabel * followersLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 100, 20, 20)];
//        
//        NSString * text = @"Followers: 20";
        
        
      /// GETTING A LABEL WITH BORDER
        
        /*
        UILabel * testLabel = [[UILabel  alloc] initWithFrame:CGRectMake(200, 10, 100, 100)];
        
        testLabel.text = @"Hi";
        testLabel.layer.borderColor = [UIColor blackColor].CGColor;
        testLabel.layer.borderWidth = 3;
        testLabel.backgroundColor = [UIColor clearColor];
        testLabel.textColor = [UIColor blackColor];
        testLabel.font = [UIFont fontWithName:@"helvetivca" size:14];
        
        
        [self.contentView addSubview:testLabel];
        */
        
        
    }
    
    
    return self;
}

//
//@"login": @"ssniteman",
//@"id": @"4793213",
//@"name": @"Shane Sniteman",
//@"location": @"Atlanta",
//@"email": @"ssniteman@gmail.com",
// @"avatar_url": @"https://avatars.githubusercontent.com/u/4793213?",


//////////////// THIS IS THE SETTER METHOD //////////////////////////////////////////////////////

- (void) setFriendInfo:(NSDictionary *)friendInfo
{
   _friendInfo = friendInfo;
   
    NSURL * url = [NSURL URLWithString:friendInfo[@"avatar_url"]];
    
    NSData * data = [NSData dataWithContentsOfURL:url];

    UIImage * image  = [UIImage imageWithData:data];
    
   
    friendImage.image = image;
    
    friendName.text = friendInfo[@"login"];
    
    friendLocation.text = @"Atlanta, GA";
    
    NSNumber* count = self.friendInfo[@"public_gists"];
    
    [rightNumberButton setTitle:[NSString stringWithFormat:@"%@", count] forState:UIControlStateNormal];
    
    
    
    
//    friendLocation.text = friendInfo[@"location"];
    
    
    
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

- (void)nextViewButtonClicked
{
    NSLog(@"Next View Button was clicked");
    
    GHFViewController * profileView = [[GHFViewController alloc] init];
    
    profileView.view.backgroundColor = [UIColor lightGrayColor];
    
    /// SETTER METHOD ////
    
    profileView.friendInfo = self.friendInfo;
    
    [self.navigationController pushViewController:profileView animated:YES];
}

- (void)gistButtonClicked
{
    GHFViewController * gistView = [[GHFViewController alloc] init];
    
    gistView.view.backgroundColor = [UIColor lightGrayColor];
    
    /// SETTER METHOD ////
    
    NSString * gistURL = [NSString stringWithFormat:@"https://gist.github.com/%@",self.friendInfo[@"login"]];
    
    
    gistView.friendInfo = @{@"html_url":gistURL};
    
    [self.navigationController pushViewController:gistView animated:YES];
}
   

@end
