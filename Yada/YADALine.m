//
//  YADALine.m
//  Yada
//
//  Created by Adam Proschek on 12/11/13.
//  Copyright (c) 2013 Adam Proschek. All rights reserved.
//

#import "YADALine.h"

@implementation YADALine

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.points = [[NSMutableArray alloc] init];
        self.color = [UIColor blackColor];
    }
    
    return self;
}

- (void)addObject:(NSValue *)point
{
    [self.points addObject:point];
    
    NSValue *previousPoint = nil;
    
    if (self.points.count > 1)
    {
         previousPoint = [self.points objectAtIndex:self.points.count - 2];
    }
    
    [self.delegate addedPointToLine:point previousPoint:previousPoint];
}

@end
