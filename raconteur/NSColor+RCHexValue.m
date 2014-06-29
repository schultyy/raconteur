//
// Created by Jan Schulte on 26/06/14.
// Copyright (c) 2014 schultyy. All rights reserved.
//

#import "NSColor+RCHexValue.h"


@implementation NSColor (RCHexValue)
-(NSString *)hexColor {

    CGFloat redFloatValue, greenFloatValue, blueFloatValue;
    int redIntValue, greenIntValue, blueIntValue;
    NSString *redHexValue, *greenHexValue, *blueHexValue;

    //Convert the NSColor to the RGB color space before we can access its components
    NSColor *convertedColor=[self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];

    if(convertedColor)
    {
        // Get the red, green, and blue components of the color
        [convertedColor getRed:&redFloatValue green:&greenFloatValue blue:&blueFloatValue alpha:NULL];

        // Convert the components to numbers (unsigned decimal integer) between 0 and 255
        redIntValue= (int) (redFloatValue*255.99999f);
        greenIntValue= (int) (greenFloatValue*255.99999f);
        blueIntValue= (int) (blueFloatValue*255.99999f);

        // Convert the numbers to inColorString strings
        redHexValue=[NSString stringWithFormat:@"%02x", redIntValue];
        greenHexValue=[NSString stringWithFormat:@"%02x", greenIntValue];
        blueHexValue=[NSString stringWithFormat:@"%02x", blueIntValue];

        // Concatenate the red, green, and blue components' inColorString strings together with a "#"
        return [NSString stringWithFormat:@"#%@%@%@", redHexValue, greenHexValue, blueHexValue];
    }
    return nil;
}

+ (NSColor*)colorWithHexColorString:(NSString*)inColorString
{
    if ([inColorString hasPrefix:@"#"]) {
        inColorString = [inColorString substringWithRange:NSMakeRange(1, [inColorString length] - 1)];
    }
    unsigned int colorCode = 0;
    if (inColorString) {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void)[scanner scanHexInt:&colorCode];
    }
    return [NSColor colorWithDeviceRed:((colorCode>>16)&0xFF)/255.0
                                 green:((colorCode>>8)&0xFF)/255.0
                                  blue:((colorCode)&0xFF)/255.0 alpha:1.0];
}

@end
