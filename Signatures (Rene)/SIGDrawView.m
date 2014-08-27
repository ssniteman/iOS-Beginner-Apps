//
//  SIGDrawView.m
//  Signatures
//
//  Created by Rene Candelier on 8/14/14.
//  Copyright (c) 2014 Novus Mobile. All rights reserved.
//

#import "SIGDrawView.h"

@implementation SIGDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        self.scribbles = [@[]mutableCopy];
    }
    return self;
}





// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor colorWithWhite:0.1 alpha:1.0]set];
    CGContextSetLineWidth(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    for (NSMutableArray * scribble in self.scribbles) {
        CGPoint start = [scribble[0] CGPointValue];
        CGContextMoveToPoint(context, start.x, start.y);
        
        for (NSValue * value in scribble){
            CGPoint point = [value CGPointValue];
            
            CGContextAddLineToPoint(context, point.x, point.y);
        }
       
    }
 CGContextStrokePath(context);
    
    if (self.scribbles.count > 0)
        [self saveImageWithContext:context];
    else
        self.scribblesImage = nil;
    
    [self saveImageWithContext:context];
    
}



-(void) saveImageWithContext:(CGContextRef)context{
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    if (self.scribbles.count>0) {
        [self saveImageWithContext:context];
    }else
    self.scribblesImage = [UIImage imageWithCGImage:imgRef];
    
    //top Right
    CGContextMoveToPoint(context, 20.0, 50.0);
    CGContextAddLineToPoint(context, 20.0, 20.0);
    CGContextAddLineToPoint(context, 50.0, 20.0);
    
    
    CGContextMoveToPoint(context, SCREEN_WIDTH -20, 50.0);
    CGContextAddLineToPoint(context, SCREEN_WIDTH -20, 20.0);
    CGContextAddLineToPoint(context, SCREEN_WIDTH -50, 20.0);
    
    
    CGContextMoveToPoint(context, 20.0, 100.0);
    CGContextAddLineToPoint(context, 20.0, 130.0);
    CGContextAddLineToPoint(context, 50.0, 130.0);
    
    CGContextMoveToPoint(context, SCREEN_WIDTH -20, 100.0);
    CGContextAddLineToPoint(context, SCREEN_WIDTH -20, 130.0);
    CGContextAddLineToPoint(context, SCREEN_WIDTH -50, 130.0);
    
    
    CGContextMoveToPoint(context, 40.0, 110.0);
    CGContextAddLineToPoint(context, SCREEN_WIDTH -40, 110.0);
    
    CGContextStrokePath(context);

    
   // CGImageRelease(imgRef);
    //  CGContextRelease(context);
}
@end
