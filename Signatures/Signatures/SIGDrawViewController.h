//
//  SIGDrawViewController.h
//  Signatures
//
//  Created by Shane Sniteman on 8/14/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SIGDrawView;

@interface SIGDrawViewController : UIViewController

@property (nonatomic) SIGDrawView * drawView;


- (void)clearSignature;
-(UIImage *)getSignature;
@end
