//
//  YADAViewController.m
//  Yada
//
//  Created by Adam Proschek on 12/11/13.
//  Copyright (c) 2013 Adam Proschek. All rights reserved.
//

#import "YADAViewController.h"
#import "YADASettingsViewController.h"

@interface YADAViewController ()

@end

@implementation YADAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.currentLine = [[YADALine alloc] init];
    self.currentLine.delegate = self.canvas;
    self.currentLine.color = [self.canvas currentColor];
    [self.canvas.lines addObject:self.currentLine];
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    NSValue *point = [NSValue valueWithCGPoint:touchPoint];
    [self.currentLine addObject:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    NSValue *point = [NSValue valueWithCGPoint:currentPoint];
    [self.currentLine addObject:point];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.currentLine = nil;
}

- (IBAction)undoButtonPressed:(UIBarButtonItem *)sender
{
    [self.canvas undo];
}

- (IBAction)shareButtonPressed:(UIBarButtonItem *)sender
{
    [self presentActivityController];
}

- (IBAction)resetButtonPressed:(UIBarButtonItem *)sender
{
    NSString *alertString = [NSString stringWithFormat:@"Are you sure you want to delete your work?"];
    UIAlertView *deleteConfirmation = [[UIAlertView alloc]
                                        initWithTitle:@"Delete Confirmation"
                                        message: alertString
                                        delegate:self
                                        cancelButtonTitle:@"Cancel"
                                        otherButtonTitles:@"Confirm", nil];
    [deleteConfirmation show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self.canvas reset];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"SettingsSegue"])
    {
        YADASettingsViewController *settingsController = segue.destinationViewController;
        settingsController.canvas = self.canvas;
    }
}

- (void)presentActivityController
{
    NSString *shareString = @"Check out my drawing!";
    UIImage *shareImage = self.canvas.image;
    NSArray *activityItems = [NSArray arrayWithObjects:shareString, shareImage, nil];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}
@end
