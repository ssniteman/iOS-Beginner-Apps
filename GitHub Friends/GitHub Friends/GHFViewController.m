//
//  GHFViewController.m
//  GitHub Friends
//
//  Created by Shane Sniteman on 7/25/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "GHFViewController.h"

@interface GHFViewController ()
{
    UIWebView * webView;
}

@end

@implementation GHFViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        
        [self.view addSubview:webView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    webView = [[UIWebView alloc] initWithFrame:self.view.frame];
//    
//    [self.view addSubview:webView];
    
  
}


- (void)setFriendInfo:(NSDictionary *)friendInfo
{
    _friendInfo = friendInfo;
    
    NSURL * url = [NSURL URLWithString:friendInfo[@"html_url"]];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"%@",webView);
    
    [webView loadRequest:request];
    
    
    
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
