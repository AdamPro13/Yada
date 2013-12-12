//
//  YADASettingsViewController.h
//  Yada
//
//  Created by Adam Proschek on 12/11/13.
//  Copyright (c) 2013 Adam Proschek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YADACanvas.h"

@interface YADASettingsViewController : UIViewController
{
    CGFloat brushWidth;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
}

@property (weak, nonatomic) YADACanvas *canvas;
@property (strong, nonatomic) IBOutlet UIImageView *exampleBrushImageView;
@property (strong, nonatomic) IBOutlet UILabel *brushWidthLabel;
@property (strong, nonatomic) IBOutlet UILabel *redValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *greenValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *blueValueLabel;
@property (strong, nonatomic) IBOutlet UISlider *brushSlider;
@property (strong, nonatomic) IBOutlet UISlider *redValueSlider;
@property (strong, nonatomic) IBOutlet UISlider *greenValueSlider;
@property (strong, nonatomic) IBOutlet UISlider *blueValueSlider;

- (IBAction)closePressed:(UIBarButtonItem *)sender;
- (IBAction)sliderValueChanged:(UISlider *)sender;

@end
