//
//  GHFTableViewController.m
//  GitHub Friends
//
//  Created by Shane Sniteman on 7/24/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "GHFTableViewController.h"
#import "GHFTableViewCell.h"
#import "GHFViewController.h"
@interface GHFTableViewController ()

@end

@implementation GHFTableViewController

////// SECOND THING WE DID 2nd--------------

{
    
    NSMutableArray * githubFriends;

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        ///// THIRD THING WE DID 3rd -----------
        

        
        githubFriends = [@[
                           @{
                            @"login": @"ssniteman",
                            @"id": @"4793213",
                            @"html_url":@"https://github.com/ssniteman",
                            @"avatar_url": @"https://avatars.githubusercontent.com/u/4793213?",
                            @"name": @"Shane Sniteman",
                            @"location": @"Atlanta",
                            @"email": @"ssniteman@gmail.com"},
                           @{@"login":@"mertid"},
                           @{@"login":@"npeterson213"},
                           @{@"login":@"schwaebek"},
                           @{@"login":@"josephlausf"},
                           @{@"login":@"Kalson"},
                           @{@"login":@"jeremycbutler"},
                           @{@"login":@"renecandelier"},
                           @{@"login":@"ericstephen"},
                           @{@"login":@"schwaebek"},
                           @{@"login":@"EWJSeidel"},
                           @{@"login":@"mjhend11"},
                           @{@"login":@"ssneller"},
                           @{@"login":@"dmerrill88"},
                           @{@"login":@"JaimeConnor"},
                           ] mutableCopy];
        
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //////// HEADER VIEW /////////////
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 70)];
    
    headerView.backgroundColor = [UIColor colorWithRed:0.976f green:0.094f blue:0.329f alpha:1.0f];
    
    self.tableView.tableHeaderView = headerView;
    
    UITextField * headerTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 15, 250, 40)];
    
    headerTextField.layer.borderColor = [UIColor grayColor].CGColor;
    headerTextField.layer.borderWidth = 1;
    headerTextField.layer.cornerRadius = 10;
    headerTextField.backgroundColor = [UIColor whiteColor];
    
    [headerView addSubview:headerTextField];

    
    
    
    
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

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
//    return 1;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    /////////////////// FOURTH THING 4th -------------
    return githubFriends.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GHFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    if (cell == nil)
    {
        cell = [[GHFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"cell"];
    }
    
    
    /// THIS IS CALLING THE SETTER METHOD
    
    cell.friendInfo = githubFriends[indexPath.row];
    
    
    
    // Configure the cell...
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Select row at %@",indexPath);
    
    GHFViewController * profileView = [[GHFViewController alloc] init];
    
    profileView.view.backgroundColor = [UIColor lightGrayColor];
    
    /// SETTER METHOD ////
    
    profileView.friendInfo = githubFriends[indexPath.row];
    
    [self.navigationController pushViewController:profileView animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
