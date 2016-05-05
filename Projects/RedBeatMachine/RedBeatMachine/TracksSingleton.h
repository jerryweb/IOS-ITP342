//
//  TracksSingleton.h
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackModel.h"
@interface TracksSingleton : NSObject

// public methods
+ (instancetype) sharedModel;
- (void) playTrackSample: (NSInteger) trackNumber;
//- (void) setMasterVolume: (float) volume;
- (NSString *) returnTrackName: (NSUInteger) index;     // Returns the name of the sample for the given track

- (TrackModel *) returnTrack: (NSUInteger) index;

- (void) modifyTrackVolume: (NSInteger) trackNumber : (float) volume;   // Public method called by the mixer to change individual track volumes 

- (void) modifyTrackPan: (NSInteger) trackNumber : (float) pan;   // Public method called by the mixer to change individual track pan

- (void) toggleTrackMute: (NSInteger) trackNumer : (BOOL) mute;  // This toggles the track mute: if the track is muted, it will unmute and vice-versa



@property (nonatomic) float masterVolume;

@end
