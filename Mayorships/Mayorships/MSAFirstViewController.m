//
//  MSAFirstViewController.m
//  Mayorships
//
//  Created by Shane Sniteman on 8/19/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "MSAFirstViewController.h"

#import "MSARequest.h"

#import <CoreLocation/CoreLocation.h>

@interface MSAFirstViewController () <UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>

@end

@implementation MSAFirstViewController
{
    NSArray * mayorships;
    
    CLLocationManager * locationManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    
    
    self.mayorList.dataSource = self;
    self.mayorList.delegate = self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{

    CLLocation * location = locations[0];
    
        // we were returning a array
    
//    mayorships = [MSARequest findMayorshipsWithLocation:location];
    
    [MSARequest findMayorshipsWithLocation:location completion:^(NSArray *mayors) {
         mayorships = mayors;
        
        [self.mayorList reloadData];
        
        [locationManager stopUpdatingLocation];
    }];

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mayorships.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [self.mayorList dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary * mayor = mayorships[indexPath.row];
    
   
    ///// PHOTO
    
    NSString * mayorImage = [NSString stringWithFormat:@"%@100x100%@",mayor[@"user"][@"photo"][@"prefix"],mayor[@"user"][@"photo"][@"suffix"]];
    
    NSURL * imageURL = [NSURL URLWithString:mayorImage];
    
    NSString * documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    // saving the file so when we scroll, it's not reloading everytime
    
    NSString * filePath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",mayor[@"user"][@"id"]]];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    
    if (!fileExists)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            // this is running the request... we want this to be on a different THREAD
            
            NSData * data = [NSData dataWithContentsOfURL:imageURL];
            
            [data writeToFile:filePath atomically:YES];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIImage * img = [[UIImage alloc] initWithData:data];
                cell.imageView.image = img;
            });
        
        });
    
    } else {
        
        cell.imageView.image = [UIImage imageWithContentsOfFile:filePath];
    }
    
    
    int mayorCount = [mayor[@"count"] intValue];
    
    if (mayorCount > 0)
    {
        NSLog(@"%@", mayor);
        
        if (mayor[@"user"])
        {
            if (mayor[@"user"][@"firstName"])
            {
                cell.textLabel.text = mayor[@"user"][@"firstName"];
            } else {
                NSLog(@"AHAAAA maybe i found the cause of my damn crash %@", mayor);
            }
            

//            NSString * mayorImage = [NSString stringWithFormat:@"%@100x100%@",mayor[@"user"][@"photo"][@"prefix"],mayor[@"user"][@"photo"][@"suffix"]];
//            
//            NSURL * imageURL = [NSURL URLWithString:mayorImage];
//            
//            NSData * data = [NSData dataWithContentsOfURL:imageURL];
//            UIImage * img = [[UIImage alloc] initWithData:data];
//            cell.imageView.image = img;
        } else {
            NSLog(@"GOT IT");
        }
    }
    
    return cell;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
