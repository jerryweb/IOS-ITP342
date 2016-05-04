//
//  Track.m
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//  This class holds the information for each indiviual track such as volume, pan and the sample loaded.

#import "TrackModel.h"
@interface TrackModel()



@end

@implementation TrackModel
//+(instancetype) sharedModel{
//    static TrackModel
//    *_sharedModel = nil;
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        // code to be executed once - thread safe version
//        _sharedModel = [[self alloc] init];
//    });
//    return _sharedModel;
//}

- (void)initTrack{
        self.sampleName = @"Bar_K";
        self.sampleFileType = @"wav";

        self.trackVolume = 0.5;
        self.trackPan = 0.5;
        self.muted = NO;
}

@end
