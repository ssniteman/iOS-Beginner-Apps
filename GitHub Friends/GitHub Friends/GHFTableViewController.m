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
#import "GRAGitHubRequest.h"

// 6f942548f31e328c4661f9ccfd856127c34e0372

@interface GHFTableViewController ()
@end

@implementation GHFTableViewController

////// SECOND THING WE DID 2nd--------------

{
    
    NSMutableArray * githubFriends;
    UITextField * headerTextField;

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        ///// THIRD THING WE DID 3rd -----------
        

        
        githubFriends = [@[] mutableCopy];
        
        NSArray * loadedUsers = [GRAGitHubRequest loadUsers];
        
        if (loadedUsers)
        {
            githubFriends = [loadedUsers mutableCopy];
        }
        
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
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
    
    headerTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 15, 250, 40)];
    
    headerTextField.layer.borderColor = [UIColor grayColor].CGColor;
    headerTextField.layer.borderWidth = 1;
    headerTextField.layer.cornerRadius = 10;
    headerTextField.backgroundColor = [UIColor whiteColor];
    
    [headerView addSubview:headerTextField];
    
    UIButton * glassButton = [[UIButton alloc] initWithFrame:CGRectMake(270, 15, 40, 40)];
    
    glassButton.backgroundColor = [UIColor whiteColor];
    glassButton.layer.cornerRadius = 20;
    [glassButton addTarget:self action:@selector(addUser) forControlEvents:UIControlEventTouchUpInside];
    
    
    [headerView addSubview:glassButton];

    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)addUser
{
    NSLog(@"search button has been touched up inside");
    
    NSDictionary * userInfo = [GRAGitHubRequest requestUserInfo:headerTextField.text];
    
//    [githubFriends addObject:userInfo];
    
    // add an object to the beginning
    
    [githubFriends insertObject:userInfo atIndex:0];
    
    [self.tableView reloadData];
    
    [GRAGitHubRequest saveUsers:githubFriends];
    
    [headerTextField resignFirstResponder];

}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
//    return 1;
//}


// height of each cell

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
    cell.navigationController = self.navigationController;
    
    
    
    // Configure the cell...
    
    return cell;
}

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Select row at %@",indexPath);
    
    GHFViewController * profileView = [[GHFViewController alloc] init];
    
    profileView.view.backgroundColor = [UIColor lightGrayColor];
    
    /// SETTER METHOD ////
    
    profileView.friendInfo = githubFriends[indexPath.row];
    
    [self.navigationController pushViewController:profileView animated:YES];
}
*/


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [githubFriends removeObjectAtIndex:indexPath.row];
        
        [GRAGitHubRequest saveUsers:githubFriends];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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

@end
