//
//  GHFTableViewCell.m
//  GitHub Friends
//
//  Created by Shane Sniteman on 7/24/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "GHFTableViewCell.h"

@implementation GHFTableViewCell

{
    UILabel * friendName;
    UILabel * friendLocation;
    UIImageView * friendImage;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    friendName = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 200, 40)];
        
        friendName.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:25];
        friendName.textColor = [UIColor grayColor];
        [self.contentView addSubview:friendName];
        
        friendImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self.contentView addSubview:friendImage];
        
        
    friendLocation = [[UILabel alloc] initWithFrame:CGRectMake(120, 35, 210, 50)];
        friendLocation.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15];
        friendLocation.textColor = [UIColor grayColor];
        [self.contentView addSubview:friendLocation];
        
        
        ///// BUTTONS
        
        UIButton * profileButton = [[UIButton alloc] initWithFrame:CGRectMake( 200, 65, 100, 30)];
        
        [self.contentView addSubview:profileButton];
        
        profileButton.backgroundColor = [UIColor grayColor];
        profileButton.layer.cornerRadius = 10;
        [profileButton setTitle:@"Profile" forState:UIControlStateNormal];
        

        UIButton * gistButton = [[UIButton alloc] initWithFrame:CGRectMake( 200, 105, 100, 30)];
        
        [self.contentView addSubview:gistButton];
        
        gistButton.backgroundColor = [UIColor grayColor];
        gistButton.layer.cornerRadius = 10;
        [gistButton setTitle:@"Gists" forState:UIControlStateNormal];
        
        ///// PICTURE /////
        
        UIButton * pictureButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 110, 110)];
        
        [self.contentView addSubview:pictureButton];
        
        pictureButton.backgroundColor = [UIColor grayColor];
        
        
        ///// TEXT /////
        
//        UILabel * followersLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 100, 20, 20)];
//        
//        NSString * text = @"Followers: 20";
        
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
    
//    NSURL * url = [NSURL URLWithString:friendInfo[@"avatar_url"]];
//    
//    NSData * data = [NSData dataWithContentsOfURL:url];
//
//    UIImage * image  = [UIImage imageWithData:data];
//    
//    friendImage.image = image;
    
    friendName.text = friendInfo[@"login"];
    
    friendLocation.text = @"Atlanta, GA";
    
    
    
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
