//
//  LABViewController.m
//  Labyrinth
//
//  Created by Shane Sniteman on 8/14/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "LABViewController.h"
#import "LABGraphView.h"
#import <CoreMotion/CoreMotion.h>

@interface LABViewController ()

@end

@implementation LABViewController
{
    CMMotionManager * motionManager;
    
    UIDynamicAnimator * animator;
    UIGravityBehavior * gravityBehavior;
    UICollisionBehavior * collisionBehavior;
    UIDynamicItemBehavior * wallBehavior;
    
    float xRotation;
    float yRotation;
    
    UIView * hole;
}

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
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    gravityBehavior = [[UIGravityBehavior alloc] init];
    [animator addBehavior:gravityBehavior];
    
    collisionBehavior = [[UICollisionBehavior alloc] init];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [animator addBehavior:collisionBehavior];
    
    wallBehavior = [[UIDynamicItemBehavior alloc] init];
    wallBehavior.density = 1000000000;
    [animator addBehavior:wallBehavior];
    
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
    
    UIView * ball = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    ball.center = self.view.center;
    ball.backgroundColor = [UIColor magentaColor];
    ball.layer.cornerRadius = 20;
    [self.view addSubview:ball];
    
    [gravityBehavior addItem:ball];
    [collisionBehavior addItem:ball];
    
    UIView * wall1 = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 50, 220)];
    
    wall1.backgroundColor = [UIColor colorWithRed:0.714f green:0.647f blue:0.498f alpha:1.0f];
    wall1.layer.cornerRadius = 20;
    [self.view addSubview:wall1];
    [collisionBehavior addItem:wall1];
    
    
    UIView * wall1Mask = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 50, 30)];
    
    wall1Mask.backgroundColor = [UIColor colorWithRed:0.714f green:0.647f blue:0.498f alpha:1.0f];
    [self.view addSubview:wall1Mask];
    
    
    
    UIView * wall2 = [[UIView alloc] initWithFrame:CGRectMake(200, 250, 50, 100)];
    
    wall2.backgroundColor = [UIColor colorWithRed:0.714f green:0.647f blue:0.498f alpha:1.0f];
    wall2.layer.cornerRadius = 20;
    [self.view addSubview:wall2];
    [collisionBehavior addItem:wall2];
    
    
    UIView * wall2Mask = [[UIView alloc] initWithFrame:CGRectMake(200, 270, 50, 50)];
    
    wall2Mask.backgroundColor = [UIColor colorWithRed:0.714f green:0.647f blue:0.498f alpha:1.0f];
    [self.view addSubview:wall2Mask];
    
    
    
    hole = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 20, 40, 40)];
    
    hole.backgroundColor = [UIColor greenColor];
    hole.layer.cornerRadius = 20;
    [self.view addSubview:hole];
    
    
    
    
//    LABGraphView * graphView = [[LABGraphView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
//    
//    [self.view addSubview:graphView];
//    
    
    motionManager = [[CMMotionManager alloc] init];
    
    [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        
        NSLog(@"x %f y %f z %f", motion.rotationRate.x,motion.rotationRate.y,motion.rotationRate.z);
        
        xRotation -= motion.rotationRate.x / 30;
        yRotation += motion.rotationRate.y / 30;
        
        [self updateGravity];
//        
//        if (graphView.xPlots.count == self.view.frame.size.height / 10.0)
//        {
//            [graphView.xPlots removeObjectAtIndex:0];
//        }
//        
//        
//        [graphView.xPlots addObject:@(motion.rotationRate.x * 20)];
//        [graphView setNeedsDisplay];
    }];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateGravity
{
    gravityBehavior.gravityDirection = CGVectorMake(xRotation, yRotation);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    xRotation = yRotation = 0;
    [self updateGravity];
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

-(BOOL)prefersStatusBarHidden{ return YES; }


@end
