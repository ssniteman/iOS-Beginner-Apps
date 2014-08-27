//
//  IWACaptionViewController.m
//  InstaWhat?
//
//  Created by Shane Sniteman on 8/25/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "IWACaptionViewController.h"

#import <Parse/Parse.h>

@interface IWACaptionViewController () <UITextViewDelegate>

@end

@implementation IWACaptionViewController
{
    UIButton * submit;
    UITextView * captionText;
    UIImageView * filterView;
    
    UIView * captionHolder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        filterView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
        filterView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.view addSubview:filterView];
        
        //
        
        captionHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 310, 320, [UIScreen mainScreen].bounds.size.height - 310)];
        
        captionHolder.backgroundColor = [UIColor lightGrayColor];
        captionHolder.layer.borderWidth = 10;
        captionHolder.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [self.view addSubview:captionHolder];
        
        //
        
        captionText = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, 280, captionHolder.frame.size.height - 70)];
        captionText.backgroundColor = [UIColor whiteColor];
        captionText.delegate = self;
        captionText.font = [UIFont fontWithName:@"Helvetica-Neue" size:14];
        
        [captionHolder addSubview:captionText];
        
        
        submit = [[UIButton alloc] initWithFrame:CGRectMake(20, captionHolder.frame.size.height - 60, 280, 40)];
        submit.backgroundColor = [UIColor colorWithRed:1.000f green:0.427f blue:0.212f alpha:1.0f];
        [submit setTitle:@"SUBMIT" forState:UIControlStateNormal];

        [submit addTarget:self action:@selector(saveFace) forControlEvents:UIControlEventTouchUpInside];
        
        [captionHolder addSubview:submit];
        
     
    }
    
    return self;
}

// method apple has created -- NOT ME

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.2 animations:^{
        
        captionHolder.center = CGPointMake(captionHolder.center.x, captionHolder.center.y - 216);
    }];
    
}

// method from touching the submit button

-(void)saveFace
{
    PFObject * face = [PFObject objectWithClassName:@"Faces"];
    
    [face setObject:captionText.text forKey:@"text"];
    
    NSData * data = UIImagePNGRepresentation(filterView.image);
    
    PFFile * file = [PFFile fileWithData:data];
    
    [face setObject:file forKey:@"image"];
    
    [face saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
        
        [nc postNotificationName:@"faceSaved" object:nil];
        
    }];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}







-(void)setFilteredImage:(UIImage *)filteredImage
{
    _filteredImage = filteredImage;

    filterView.image = filteredImage;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
