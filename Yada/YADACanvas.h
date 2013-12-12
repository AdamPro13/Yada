//
//  YADACanvas.h
//  Yada
//
//  Created by Adam Proschek on 12/11/13.
//  Copyright (c) 2013 Adam Proschek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YADALine.h"

@interface YADACanvas : UIImageView <YADALineDelegate>

@property CGFloat brushWidth;
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong) NSMutableArray *lines;

- (void)reset;
- (void)undo;

@end
