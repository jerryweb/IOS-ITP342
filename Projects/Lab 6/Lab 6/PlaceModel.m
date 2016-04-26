//
//  PlaceModel.m
//  Lab 6
//
//  Created by LJ on 4/25/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import "PlaceModel.h"

static NSString * const kPlacesPList = @"PropertyList.plist";

@interface PlaceModel()

@property (strong, nonatomic) NSMutableArray *places;
@property (nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) NSString *filePath;

@end


@implementation PlaceModel

+(instancetype) sharedModel {
    static PlaceModel *_sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once - thread safe version
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}

- (instancetype) init {
    self = [super init];
    if (self){
        NSString * path = [[NSBundle mainBundle]pathForResource:@"Places" ofType:@"plist"];
        
        _places = [[NSMutableArray alloc] initWithContentsOfFile:path];

    }
    return self;
}

-(NSUInteger) numberOfPlaces{
    //    NSLog(@"the num of cards direct is: %li", (long)[self.flashcards count]);
    return [self.places count];
}

- (NSDictionary *) placeAtIndex: (NSUInteger) index {
    if(index >= self.places.count){
        index = 0;
    }
    return self.places[index];
}

@end
