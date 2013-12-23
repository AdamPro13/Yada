//
//  YADASettingsViewController.m
//  Yada
//
//  Created by Adam Proschek on 12/11/13.
//  Copyright (c) 2013 Adam Proschek. All rights reserved.
//

#import "YADASettingsViewController.h"

@interface YADASettingsViewController ()

@end

@implementation YADASettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    brushWidth = self.canvas.brushWidth;

    [self.canvas.currentColor getRed:&red green:&green blue:&blue alpha:nil];
    
    self.brushSlider.value = brushWidth/25;
    self.redValueSlider.value = red;
    self.greenValueSlider.value = green;
    self.blueValueSlider.value = blue;
    
    [self refreshLabels];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self updateBrushExample];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)closePressed:(UIBarButtonItem *)sender
{
    self.canvas.currentColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    NSNumber *redValue = [NSNumber numberWithFloat:red];
    NSNumber *greenValue = [NSNumber numberWithFloat:green];
    NSNumber *blueValue = [NSNumber numberWithFloat:blue];
    NSNumber *width = [NSNumber numberWithFloat:brushWidth];
    [[NSUserDefaults standardUserDefaults] setValue:width forKey:@"width"];
    [[NSUserDefaults standardUserDefaults] setValue:redValue forKey:@"red"];
    [[NSUserDefaults standardUserDefaults] setValue:greenValue forKey:@"green"];
    [[NSUserDefaults standardUserDefaults] setValue:blueValue forKey:@"blue"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sliderValueChanged:(UISlider *)sender
{
    if (sender == self.brushSlider)
    {
        brushWidth = (sender.value * 25) + 5;
        self.canvas.brushWidth = brushWidth;
    }
    else if (sender == self.redValueSlider)
    {
        red = sender.value;
    }
    else if (sender == self.greenValueSlider)
    {
        green = sender.value;
    }
    else if (sender == self.blueValueSlider)
    {
        blue = sender.value;
    }
    
    [self refreshLabels];
    [self updateBrushExample];
}

- (void)updateBrushExample
{
    self.exampleBrushImageView.image = [[UIImage alloc] init];
    UIGraphicsBeginImageContext(self.exampleBrushImageView.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brushWidth);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGPoint centerPoint = CGPointMake(self.exampleBrushImageView.frame.size.width/2.0, self.exampleBrushImageView.frame.size.height/2.0);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), centerPoint.x, centerPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), centerPoint.x, centerPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.exampleBrushImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (void)refreshLabels
{
    self.brushWidthLabel.text = [NSString stringWithFormat:@"%.1f", brushWidth];
    self.redValueLabel.text = [NSString stringWithFormat:@"%.0f", red * 255];
    self.greenValueLabel.text = [NSString stringWithFormat:@"%.0f", green * 255];
    self.blueValueLabel.text = [NSString stringWithFormat:@"%.0f", blue * 255];
}

@end
