//
//  TrackModel.h
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackModel : NSObject

// public methods
+ (instancetype) sharedModel;
- (void) playTrackSample: (NSInteger) trackNumber;

@end
