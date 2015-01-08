//
//  ViewController.m
//  touch-events-demo
//
//  Created by Oren Kosto on 1/8/15.
//  Copyright (c) 2015 Panda-OS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

int fingersOnScreen = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setMultipleTouchEnabled:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event //finger down
{
    fingersOnScreen += [touches count];
    NSLog(@"touch started, %d %@ on screen", fingersOnScreen, fingersOnScreen == 1 ? @"finger" : @"fingers");
    [self updateLabel];
    // enumerate screen touches and draw circles where the touches occured
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        // get the touch and its location
        UITouch *touch = obj;
        CGPoint touchLocation = [touch locationInView:self.view];
        
        CircleView *circleView = [[CircleView alloc] initWithRadius:50 withColor:[UIColor blueColor] atLocation:touchLocation];
        [self.view addSubview:circleView];
        if (fingersOnScreen == 1) {
            self.singleCircle = circleView;
        }
    }];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event //finger moved
{
    if (fingersOnScreen == 1 && self.singleCircle != nil) {
        [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
            UITouch *touch = obj;
            self.singleCircle.center = [touch locationInView:self.view];
        }];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event //finger up
{
    fingersOnScreen -= [touches count];
    NSLog(@"touch ended, %d %@ lifted from screen", fingersOnScreen, fingersOnScreen == 1 ? @"finger" : @"fingers");
    [self updateLabel];
    NSArray *subviews = [self.view subviews];
    if (fingersOnScreen == 0) {
        for (UIView *view in subviews) {
            if ([view isKindOfClass:[CircleView class]]) {
                [view removeFromSuperview]; //remove all of the circles we created so far
            }
        }
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event //touch interrupted (i.e. user received a phone call)
{
    
}

-(void)updateLabel {
    self.titleLabel.text = fingersOnScreen == 0
    ? @"Touch Something!"
    : [NSString stringWithFormat:@"%d %@ on screen", fingersOnScreen, fingersOnScreen == 1 ? @"finger" : @"fingers"];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


@end
