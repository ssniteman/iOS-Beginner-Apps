//
//  MFLTableViewController.m
//  List App
//
//  Created by Shane Sniteman on 7/23/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "MFLTableViewController.h"

@interface MFLTableViewController ()

@property (nonatomic) NSArray * listItems;

// create an array for students - NSStrings

// create an array for colors - UIColors

// create an array for sizes - NSNumbers


@end

@implementation MFLTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        // Custom initialization
        
//        self.listItems = [[NSArray alloc] initWithObjects:@"Monday",@"Tuesay",@"Wednesday",@"Thursday",nil];
//        
//        self.listItems = [NSArray arrayWithObjects:@"Monday",@"Tuesay",@"Wednesday",@"Thursday",nil];
//        
       
        // setter method
//        self.listItems = @[@"Monday",@"Tuesay",@"Wednesday",@"Thursday"];
        
        // getter method
//        [self.listItems:@[@"Monday",@"Tuesay",@"Wednesday",@"Thursday"]];
        
        self.listItems = @[@"Monday",@"Tuesay",@"Wednesday",@"Thursday"]; // last three
        
        // set 7 students
        
        // set 7 colors
        
        // set 7 numbers (20 - 40)
        
        
        
        
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return self.listItems.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell * cell = [[UITableViewCell alloc] init];
    
//    NSString * listItem = [self.listItems objectAtIndex:indexPath.row];
    
    
    // GETTING ITEM FROM AN ARRAY
    
    NSString * listItem = self.listItems[indexPath.row];
    
   // set background color to color in array
    
    NSLog(@"listItem = %@",listItem);
    
    cell.textLabel.text = listItem;
    
    // there is a sub text option/property to set by student name
    
    cell.backgroundColor = [UIColor greenColor];
    
    // set the textlabel font size to a number from the last array
    
    // Configure the cell...
    
    return cell;
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
