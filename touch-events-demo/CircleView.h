//
//  circleView.h
//  touch-events-demo
//
//  Created by Oren Kosto on 1/8/15.
//  Copyright (c) 2015 Panda-OS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CircleView : UIView

-(instancetype)initWithRadius:(int)radius withColor:(UIColor *)color atLocation:(CGPoint)location;

@end
