//
//  GRAGitHubRequest.h
//  GitHub Request
//
//  Created by Shane Sniteman on 7/28/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRAGitHubRequest : NSObject

+ (NSDictionary *)requestUserInfo: (NSString *)username;

+ (void)saveUsers: (NSArray *)users;

+ (NSArray *)loadUsers;

@end
