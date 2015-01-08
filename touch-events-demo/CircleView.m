//
//  circleView.m
//  touch-events-demo
//
//  Created by Oren Kosto on 1/8/15.
//  Copyright (c) 2015 Panda-OS. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

-(instancetype)initWithRadius:(int)radius withColor:(UIColor *)color atLocation:(CGPoint)location
{
    self = [super initWithFrame:CGRectMake(location.x - radius, location.y - radius, radius * 2, radius * 2)];
    [self setBackgroundColor:color];
    self.layer.cornerRadius = radius;
    return self;
}

@end
