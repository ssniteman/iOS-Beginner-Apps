//
//  SIGDrawView.m
//  Signatures
//
//  Created by Shane Sniteman on 8/14/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

#import "SIGDrawView.h"

@implementation SIGDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.scribbles = [@[] mutableCopy];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}





// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor colorWithWhite:0.1 alpha:1.0] set];
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    for (NSMutableArray * scribble in self.scribbles)
    {
        CGPoint start = [scribble[0] CGPointValue];
        
        CGContextMoveToPoint(context, start.x, start.y);
        
        for (NSValue * value in scribble)
        {
            CGPoint point = [value CGPointValue];
            
            CGContextAddLineToPoint(context, point.x, point.y);
        }
         CGContextStrokePath(context);
    }
        
    
    
        if(self.scribbles.count > 0)
        {
            [self saveImageWithContext:context];
        }
        else
        {
            self.scribblesImage = nil;
        }
    
        [self saveImageWithContext:context];
    
    CGContextMoveToPoint(context, 20, 50);
    CGContextAddLineToPoint(context, 20, 20);
    CGContextAddLineToPoint(context, 50, 20);
  
     CGContextStrokePath(context);
    
}

-(void)saveImageWithContext:(CGContextRef)context
{
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    
    self.scribblesImage = [UIImage imageWithCGImage:imgRef];
    
//    CGImageRelease(imgRef);
//    CGContextRelease(context);
}



@end
