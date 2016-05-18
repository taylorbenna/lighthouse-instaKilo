//
//  ImageObject.m
//  InstaKilo
//
//  Created by Taylor Benna on 2016-05-18.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import "ImageObject.h"

@implementation ImageObject

- (instancetype)initWithImage:(UIImage *)image section:(NSString *)section location:(NSString *)location
{
    self = [super init];
    if (self) {
        _image = image;
        _section = section;
        _location = location;
    }
    return self;
}

@end
