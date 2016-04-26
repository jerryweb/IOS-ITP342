//
//  PlaceModel.h
//  Lab 6
//
//  Created by LJ on 4/25/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <Foundation/Foundation.h>

// constants
static NSString * const kNameKey = @"name";
static NSString * const kWebsiteKey = @"website";
static NSString * const kImageKey = @"image";

@interface PlaceModel : NSObject

// public methods
+ (instancetype) sharedModel;
- (NSUInteger) numberOfPlaces;
- (NSDictionary *) placeAtIndex: (NSUInteger) index;




@end
