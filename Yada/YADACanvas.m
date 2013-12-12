//
//  YADACanvas.m
//  Yada
//
//  Created by Adam Proschek on 12/11/13.
//  Copyright (c) 2013 Adam Proschek. All rights reserved.
//

#import "YADACanvas.h"

@implementation YADACanvas

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.lines = [[NSMutableArray alloc] init];
        self.brushWidth = [[[NSUserDefaults standardUserDefaults] valueForKey:@"width"] floatValue];
        
        if (self.brushWidth == 0)
        {
            self.brushWidth = 10.0;
            NSNumber *widthToSave = [NSNumber numberWithFloat:self.brushWidth];
            [[NSUserDefaults standardUserDefaults] setValue:widthToSave forKey:@"width"];
        }
        
        CGFloat red = [[[NSUserDefaults standardUserDefaults] valueForKey:@"red"] floatValue];
        CGFloat green = [[[NSUserDefaults standardUserDefaults] valueForKey:@"green"] floatValue];
        CGFloat blue = [[[NSUserDefaults standardUserDefaults] valueForKey:@"blue"] floatValue];
        self.currentColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    }
    
    return self;
}

- (void)addedPointToLine:(NSValue *)currentPoint previousPoint:(NSValue *)previousPoint
{
    [self addLineBetween:previousPoint andPoint:currentPoint withColor:self.currentColor];
}

- (void)reset
{
    self.image = [[UIImage alloc] init];
}

- (void)undo
{
    [self reset];
    
    [self.lines removeLastObject];
    
    for (YADALine *line in self.lines)
    {
        if ([line isKindOfClass:[YADALine class]])
        {
            YADALine *thisLine = line;
            
            for (NSInteger i = 0; i < [thisLine.points count]; i++)
            {
                NSValue *currentPoint = [thisLine.points objectAtIndex:i];
                NSValue *previousPoint = nil;
                
                if (i == 0)
                {
                    previousPoint = currentPoint;
                }
                else
                {
                    previousPoint = [thisLine.points objectAtIndex:i-1];
                }
                
                [self addLineBetween:previousPoint andPoint:currentPoint withColor:line.color];
            }
        }
    }
}

- (void)addLineBetween:(NSValue *)startPoint andPoint:(NSValue *)endPoint withColor:(UIColor *)color
{
    UIGraphicsBeginImageContext(self.frame.size);
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    if (startPoint)
    {
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), startPoint.CGPointValue.x, startPoint.CGPointValue.y);
    }
    else
    {
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), endPoint.CGPointValue.x, endPoint.CGPointValue.y);
    }
    
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), endPoint.CGPointValue.x, endPoint.CGPointValue.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brushWidth );
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    [color getRed:&red green:&green blue:&blue alpha:nil];
    
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
