//
//  TracksSingleton.h
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TracksSingleton : NSObject

// public methods
+ (instancetype) sharedModel;
- (void) playTrackSample: (NSInteger) trackNumber;
//- (void) setMasterVolume: (float) volume;
- (NSString *) returnTrackName: (NSUInteger) index;     // Returns the name of the sample for the given track

@property (nonatomic) float masterVolume;

@end
