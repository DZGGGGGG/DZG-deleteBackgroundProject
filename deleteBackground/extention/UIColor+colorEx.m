//
//  UIColor+colorEx.m
//  deleteBackground
//
//  Created by bbbdzg on 2020/9/22.
//  Copyright © 2020 image. All rights reserved.
//

#import "UIColor+colorEx.h"

@implementation UIColor (colorEx)
+ (UIColor *)colorRGBA:(CGFloat)Red Green:(CGFloat)Green Blue:(CGFloat)Blue Alpha:(CGFloat)Alpha{
    return [UIColor colorWithRed:Red/255.0 green:Green/255.0 blue:Blue/255.0 alpha:Alpha];
}
@end
