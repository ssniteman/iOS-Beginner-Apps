//
//  SIGRootViewController.m
//  Signatures
//
//  Created by Rene Candelier on 8/14/14.
//  Copyright (c) 2014 Novus Mobile. All rights reserved.
//

#import "SIGRootViewController.h"
#import "SIGListTableViewController.h"
#import "SIGDrawViewController.h"

@interface SIGRootViewController ()
{
    SIGDrawViewController * drawVC;
    SIGListTableViewController * listTVC;
}
@end

@implementation SIGRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    drawVC = [[SIGDrawViewController alloc]init];
    
    drawVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    
    [self.view addSubview:drawVC.view];
    
    listTVC = [[SIGListTableViewController alloc]init];
    
    listTVC.view.frame = CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT -200);
    
    [self.view addSubview:listTVC.tableView];
    
    [self addChildViewController:drawVC];
    [self addChildViewController:listTVC];

    
    //Save Button
    
    UIButton * saveSignatureButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 150, 100, 30)];
    saveSignatureButton.backgroundColor = [UIColor colorWithRed:0.000f green:1.000f blue:0.569f alpha:1.0f];
    
    saveSignatureButton.layer.cornerRadius = 15;
    
    [saveSignatureButton addTarget:self action:@selector(saveSignature) forControlEvents:UIControlEventTouchUpInside];
    [saveSignatureButton setTitle:@"SAVE" forState:UIControlStateNormal];
    
    
    
    [self.view addSubview:saveSignatureButton];
    
    
        //Clear Button
    UIButton * clearSignatureButton = [[UIButton alloc] initWithFrame:CGRectMake(180, 150, 100, 30)];
    clearSignatureButton.backgroundColor = [UIColor colorWithRed:1.000f green:0.212f blue:0.000f alpha:1.0f];
    
    
    [clearSignatureButton addTarget:drawVC action:@selector(clearSignature) forControlEvents:UIControlEventTouchUpInside];
    clearSignatureButton.layer.cornerRadius = 15;
    [clearSignatureButton setTitle:@"CLEAR" forState:UIControlStateNormal];

    [self.view addSubview:clearSignatureButton];
    
    

}

-(void)saveSignature{
    
    
    UIImage * image = [drawVC getSignature];
    
    [listTVC.signitures addObject:image];
    
    [listTVC.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
