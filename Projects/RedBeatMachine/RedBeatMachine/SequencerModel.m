//
//  SequencerModel.m
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//  This class holds the thread that powers the midi sequencer that plays the given drum pattern. It holds references to the Track singleton and connects the sequencer view controller to the tracks.

#import "SequencerModel.h"
#import "TrackModel.h"


@implementation SequencerModel

+(instancetype) sharedModel{
    static SequencerModel
    *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once - thread safe version
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.play = NO;
        self.bpm = 90;
        
        
    }
    return self;
}

@end
