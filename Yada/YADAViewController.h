//
//  YADAViewController.h
//  Yada
//
//  Created by Adam Proschek on 12/11/13.
//  Copyright (c) 2013 Adam Proschek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YADACanvas.h"
#import "YADALine.h"

@interface YADAViewController : UIViewController

@property (strong, nonatomic) IBOutlet YADACanvas *canvas;
@property (strong, nonatomic) YADALine *currentLine;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *undoButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *shareButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *resetButton;

- (IBAction)undoButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)shareButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)resetButtonPressed:(UIBarButtonItem *)sender;

@end
