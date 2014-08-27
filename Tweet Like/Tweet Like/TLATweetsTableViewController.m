//
//  TLATweetsTableViewController.m
//  Tweet Like
//
//  Created by Shane Sniteman on 8/11/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "TLATweetsTableViewController.h"
#import "TLANewTweetVC.h"

#import <AFNetworking/AFNetworking.h>

#import <Parse/Parse.h>

@interface TLATweetsTableViewController () <TLATweetCellDelegate>

@end

@implementation TLATweetsTableViewController
{
    NSMutableArray * tweets;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        
        [Parse setApplicationId:@"cZFUuojbreu9ZeeD8TR9OinJz0rJWwLLVFyefxKN"
                      clientKey:@"kig4GvXRs0vnKH4uZ7ZNi5TlFPN5FBb8wkLhdvrC"];
        
        PFObject * testObject = [PFObject objectWithClassName:@"TestObject"];
        testObject[@"foo"] = @"bar";
        [testObject saveInBackground];
        
        tweets = [@[
                    
                    [@{
                       @"text" : @"This is a tweet",
                       @"hearts" : @32
                       } mutableCopy],
                    [@{
                       @"text" : @"This is a better tweet",
                       @"hearts" : @33
                       } mutableCopy]
                    ] mutableCopy];
        
        
        AFHTTPRequestOperationManager * operationManager = [[AFHTTPRequestOperationManager alloc] init];
        
        [operationManager GET:@"http://jo2.co/twitter.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"%@",responseObject);
            
//            tweets = [responseObject mutableCopy];
            
           // querying from parse = PFQUERY - looking through our tweet like table
            
            PFQuery * query = [PFQuery queryWithClassName:@"TweetTable"];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                
               // look for the tweets in my json
                
                for (NSDictionary * tweetFromJSON in responseObject)
                {
                    BOOL tweetFoundWithSameID = NO;
                    
                    for (PFObject * tweetIdFromParse in objects)
                    {
                        if ([tweetFromJSON[@"id"] isEqual:tweetIdFromParse[@"id"]])
                        {
                            tweetFoundWithSameID = YES;
                            [tweets addObject:tweetIdFromParse];
                        }
                    }
                    
                    if (!tweetFoundWithSameID)
                    {
                        PFObject * newTweet = [PFObject objectWithClassName:@"TweetTable"];
                        
                        [newTweet setObject:tweetFromJSON[@"id"] forKey:@"id"];
                        [newTweet setObject:tweetFromJSON[@"text"] forKey:@"text"];
                        [newTweet setObject:@0 forKey:@"hearts"];
                        
                        // save objects in the parse cell
                        [newTweet saveInBackground];
                        
                        [tweets addObject:newTweet];
                    }
                }
                
                //refreshes the table view once the loops run
                
                [self.tableView reloadData];
                
            }];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    }
    return self;
}

- (void)heartsUpdated
{
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIImageView * logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_logo"]];
    
    logo.frame = CGRectMake(0,0,121,24);
    logo.center = self.navigationController.navigationBar.center;
    [self.navigationController.navigationBar addSubview:logo];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return tweets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLATweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    PFObject * tweetObject = tweets[indexPath.row];
    
    cell.heartCountLabel.text = [NSString stringWithFormat:@"%@",tweetObject[@"hearts"]];
    cell.tweetTextView.text = tweetObject[@"text"];
    
    
    // setter method - tweetWithLike is just called so that we can use it in the TweetCell
    // declared it as a PFObject in the TweetCell.h and called in the TweetCell.m
    
    cell.tweetWithLike = tweets[indexPath.row];
    
    cell.delegate = self;
    
    return cell;
}

// updateHeartCount that runs reloadData


// METHOD USED TO GRAB DATA FROM NEW TWEET ENTRY WHEN CLICK SAVE
    // goes back to initial table view

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"showNewTweetVC"])
    {
        
        TLANewTweetVC * newTweetVC = segue.destinationViewController;
        
        newTweetVC.tweets = tweets;
        
    }
  
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
