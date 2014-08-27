//
//  GRAGitHubRequest.m
//  GitHub Request
//
//  Created by Shane Sniteman on 7/28/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "GRAGitHubRequest.h"

@implementation GRAGitHubRequest

+ (NSDictionary *)requestUserInfo: (NSString *)username
{
    // take the username and call the github url
    
    NSString * urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@?access_token=6f942548f31e328c4661f9ccfd856127c34e0372",username];
    
    NSURL * url = [NSURL URLWithString:urlString];

    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    // mutuable request
    
    NSMutableURLRequest * mutableRequest = [NSMutableURLRequest requestWithURL:url];

    [mutableRequest setHTTPMethod:@"POST"];
    
    
    
    //////////////////////////////////
    
    NSURLResponse * response = nil;
    NSError * error = nil;
    
    // gets data from the website
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // line above gets data into a NON friendly format
    
    // line below converts to human friendly
 
    NSDictionary * userInfo = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&error];
    
    NSLog(@"response data = %@",responseData);
    
    NSLog(@"user info = %@",userInfo);
    
    return userInfo;
}

// not returning anything, so it's void

+ (void)saveUsers: (NSArray *)users
{
    // path to what we are saving
    
    NSString * path = [GRAGitHubRequest usersArchivePath];
    
    // then we archive
    
    NSData * userData = [NSKeyedArchiver archivedDataWithRootObject:users];
    
    // the we save file
    
    [userData writeToFile:path options:NSDataWritingAtomic error:nil];
}

// returning something


+ (NSArray *)loadUsers
{
    // path to what we are loading
    
    NSString * path = [GRAGitHubRequest usersArchivePath];
    
    // then we unarchive
    
    NSArray * users = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    // then we return the array
    
    return users;
}

+ (NSString *)usersArchivePath
{
    // return array of directories
    
    NSArray * documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // grab first path from about array
    
    NSString * documentDirectory = documentDirectories[0];
    
    // return path/users.data
    
    return [documentDirectory stringByAppendingString:@"users.data"];
}

@end
