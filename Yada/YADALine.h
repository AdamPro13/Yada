//
//  YADALine.h
//  Yada
//
//  Created by Adam Proschek on 12/11/13.
//  Copyright (c) 2013 Adam Proschek. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YADALineDelegate <NSObject>

- (void)addedPointToLine:(NSValue *)currentPoint previousPoint:(NSValue *)previousPoint;

@end

@interface YADALine : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSMutableArray *points;
@property (nonatomic, weak) NSObject<YADALineDelegate> *delegate;

- (void)addObject:(NSValue *)point;

@end
