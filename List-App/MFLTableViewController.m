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

// create an array for students - NSString

@property (nonatomic) NSArray * listStudents;

// create an array for colors - UIColor

@property (nonatomic) NSArray * listColors;

// create an array for sizes - NSNumber

@property (nonatomic) NSArray * listNumbers;

// other examples

//@property (nonatomic) NSString* myName;
//@property (nonatomic) int myAge;


///////////
///////////
///////////

@property (nonatomic) NSArray * info;

///////////
///////////
///////////

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
        
        self.listItems = @[@"Monday",@"Tuesay",@"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday"]; // last three
        
        // set 7 students
        
        self.listStudents = @[@"Laura",@"Ted",@"Morgan",@"George",@"Tim",@"Daniel",@"Katie"];
        
        // set 7 colors
    
        self.listColors = @[[UIColor redColor],[UIColor blueColor],[UIColor greenColor],[UIColor yellowColor],[UIColor orangeColor],[UIColor purpleColor],[UIColor grayColor]];
        
        // set 7 numbers (20 - 40)
        
        self.listNumbers = @[@20,@24,@28,@30,@32,@33,@40];
        
        
        self.info = @[
                      @{@"day":@"Monday",@"student":@"Laura"},
                      @{@"day":@"Tuesday"}
                      ];
        
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

    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@""];
    
//    NSString * listItem = [self.listItems objectAtIndex:indexPath.row];
    
//    NSDictionary * infoItem = self.info[indexPath.row];
    
//    NSString * day = infoItem[@"day"];
    
    
    // GETTING ITEM FROM AN ARRAY
    
    NSString * listItem = self.listItems[indexPath.row];
    
    NSLog(@"listItem = %@",listItem);
    
    cell.textLabel.text = listItem;
    
//     cell.textLabel.text = infoItem[@"day"];
    
    // set background color to color in array
    
    UIColor * color = self.listColors[indexPath.row];
    
    cell.backgroundColor = color;
    
    // there is a sub text option/property to set by student name
    
    NSString * listStudents = self.listStudents[indexPath.row];

    cell.detailTextLabel.text = listStudents;
    
    // set the textlabel font size to a number from the last array
    
    NSNumber * listNumbers = self.listNumbers[indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:[listNumbers integerValue]];
    
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
