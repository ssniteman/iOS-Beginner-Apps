//
//  MSARequest.m
//  Mayorships
//
//  Created by Shane Sniteman on 8/19/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "MSARequest.h"

#define API @"https://api.foursquare.com/v2/"
#define CLIENT_ID @"BTLGTNB3Z4BD20DR3A4DBSAHBEI2ZQEVAZN4FPDFYHMYGEUX"
#define CLIENT_SECRET @"SRZHNWY0U1HHTZ5BXSYRMVYTQELKZAFYXWWQWH1KXL2YTG5M"


@implementation MSARequest

//+(NSArray *)findMayorshipsWithLocation:(CLLocation *)location
+ (void)findMayorshipsWithLocation:(CLLocation *)location completion:(void (^)(NSArray *mayors))completion
{
    
//    NSArray * venues = [MSARequest findVenuesWithLocation:location];
    
    [MSARequest findVenuesWithLocation:location completion:^(NSArray *venues) {
       
        NSMutableArray * mayors = [@[] mutableCopy];
        
        for (NSDictionary * venue in venues)
        {
            NSString * endpoint = [NSString stringWithFormat:@"venues/%@",venue[@"id"]];
            
            //        NSDictionary * venueInfo = [MSARequest foursquareRequestWithEndpoint:endpoint andParameters:@{}];
            
            
            [MSARequest foursquareRequestWithEndpoint:endpoint andParameters:@{} completion:^(NSDictionary *responseInfo) {
                
                NSDictionary * mayor = responseInfo[@"response"][@"venue"][@"mayor"];
                
                [mayors addObject:mayor];
                
                if(completion) completion(mayors);
            }];
            //[mayors addObject:mayorImage];
        }
        //    return mayors;
    }];
    
    }


+(void)findVenuesWithLocation:(CLLocation *)location completion:(void(^)(NSArray * venues))completion
{
    NSDictionary * parameters = @{
                                  @"ll" : [NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude]
                                  };
    
    [MSARequest foursquareRequestWithEndpoint:@"venues/search" andParameters:parameters completion:^(NSDictionary *responseInfo) {
        
        if(completion) completion(responseInfo[@"response"][@"venues"]);
        
    }];

   
//    return [MSARequest foursquareRequestWithEndpoint:@"venues/search" andParameters:parameters][@"response"][@"venues"];
    
}


+ (void)foursquareRequestWithEndpoint: (NSString *)endpoint andParameters:(NSDictionary *)parameters completion:(void(^)(NSDictionary * responseInfo))completion
{
    
    NSMutableString * requestString = [[API stringByAppendingString:endpoint] mutableCopy];
    
    // make v custom to current day
    
    [requestString appendString:[NSString stringWithFormat:@"?client_id=%@&client_secret=%@&v=20140819",CLIENT_ID,CLIENT_SECRET]];
    
    for (NSString * key in [parameters allKeys])
         {
             
                 [requestString appendFormat:@"&%@=%@", key, [parameters objectForKey:key]];

         }
    
    
    NSLog(@"%@",requestString);
    

    NSURL * requestURL = [NSURL URLWithString:requestString];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:requestURL];
  
//    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
      
//        will run after the request finishes
        
        NSDictionary * responseInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        // waiting for the response to finish, then we call block
        
        if (completion) completion(responseInfo);

        
    }];
    
   
//    NSLog(@"%@",responseInfo);
    
//    return responseInfo;
    
    
}


@end
