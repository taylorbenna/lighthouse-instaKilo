//
//  ImageObject.h
//  InstaKilo
//
//  Created by Taylor Benna on 2016-05-18.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageObject : NSObject

@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *section;
@property (nonatomic) NSString *location;

- (instancetype)initWithImage:(UIImage *)image section:(NSString *)section location:(NSString *)location;

@end
