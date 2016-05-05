//
//  TracksSingleton.m
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//  This is the signleton that will hold all of the tracks and sample data Along with the assign and play methods. This class also holds the reference to the AudioToolBox and is where the sound is triggered and played. There are 8 seperate Audio services, one for each track, used to play the samples assinged to each of the tracks.

#import "TracksSingleton.h"
#import "TrackModel.h"
#import "SequencerModel.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface TracksSingleton(){
    AVAudioPlayer *player;
}

@property (strong, nonatomic) SequencerModel *sequencerModel;
@property (strong, nonatomic) NSMutableArray *tracks;

// This holds the ID for each track. These can be used for any sample as long as the file path to the sample is used
@property (readonly) SystemSoundID track0Id;
@property (readonly) SystemSoundID track1Id;
@property (readonly) SystemSoundID track2Id;
@property (readonly) SystemSoundID track3Id;
@property (readonly) SystemSoundID track4Id;
@property (readonly) SystemSoundID track5Id;
@property (readonly) SystemSoundID track6Id;
@property (readonly) SystemSoundID track7Id;

@end

@implementation TracksSingleton

+(instancetype) sharedModel{
    static TracksSingleton
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
        self.sequencerModel = [SequencerModel sharedModel];

        // Paths to all of the sound files and connections to the URLs for the sound file IDs
        [self generateTracks];
        self.masterVolume = (float)0.5;
    }
    return self;

}


// Create 8 track objects and add them to an array
- (void) generateTracks{
    _tracks = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < 8; i++)
    {
        TrackModel *track = [TrackModel new];
        [track initTrack];
        if(i ==1){
            [track setSampleName:@"Cap_Snr"];
        }
        else if (i == 2){
            [track setSampleName:@"Hi_Shk3"];

        }
        else if (i == 3){
            [track setSampleName:@"Tmb_3"];
            
        }
        else if (i == 4){
            [track setSampleName:@"Perfect 808"];
            
        }
        else if (i == 5){
            [track setSampleName:@"Bngo_3"];
            
        }
        else if (i == 6){
            [track setSampleName:@"Wan_Ohh"];
            
        }
        else if (i == 7){
            [track setSampleName:@"2uicksilver 808 single"];
            
        }
        [_tracks addObject:track];

    }
}

- (NSString *) returnTrackName: (NSUInteger) index{
    if(index >= 0 && index < self.tracks.count){
        return [self.tracks[index] sampleName];
    }
    else return NULL;
}

- (TrackModel *) returnTrack: (NSUInteger) index{
    if(index >= 0 && index < self.tracks.count){
        return self.tracks[index];
    }
    else return NULL;
}


#pragma mark - Public access methods to modify volume, pan and mute settings for each track

- (void) modifyTrackPan: (NSInteger) trackNumber : (float) pan{
    [self.tracks[trackNumber] setTrackPan:pan];

}

- (void) modifyTrackVolume: (NSInteger) trackNumber : (float) volume{
    [self.tracks[trackNumber] setTrackVolume:volume];
}

- (void) toggleTrackMute: (NSInteger) trackNumer : (BOOL) mute{
    [self.tracks[trackNumer] setMuted:mute];
}

#pragma mark - play tracks

// This method plays the samples according the track that is called
- (void) playTrackSample: (NSInteger) trackNumber{
    
    // Connect the sampleName and file type with the file Path and URL
    NSString *trackFilePath = [[NSBundle mainBundle]pathForResource:[self.tracks[trackNumber] sampleName] ofType:[self.tracks[trackNumber] sampleFileType]];
    NSURL *trackURL = [NSURL fileURLWithPath:trackFilePath];
    
    // Remake the AVAudioPlayer; this prevents sluggish response
    player =[[AVAudioPlayer alloc] initWithContentsOfURL:trackURL error:NULL];
    
    // set volume output of track
    
    [player setVolume: ([self.tracks[trackNumber] trackVolume])*(self.masterVolume)];
    
    // set pan of track output
    [player setPan:[self.tracks[trackNumber] trackPan]];
    
    // play sample if the track is not muted
    if(![self.tracks[trackNumber] muted]){
        [player play];
    }

}

@end

