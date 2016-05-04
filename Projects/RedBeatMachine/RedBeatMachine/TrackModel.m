//
//  TrackModel.m
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//  This is the signleton that will hold all of the tracks and sample data Along with the assign and play methods. This class also holds the reference to the AudioToolBox and is where the sound is triggered and played. There are 8 seperate Audio services, one for each track, used to play the samples assinged to each of the tracks.

#import "TrackModel.h"
#import <AudioToolbox/AudioToolbox.h>

@interface TrackModel()
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

@implementation TrackModel

+(instancetype) sharedModel{
    static TrackModel
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
        
        // Paths to all of the sound files and connections to the URLs for the sound file IDs
        NSString *track0FilePath = [[NSBundle mainBundle]
                             pathForResource:@"Bar_K" ofType:@"wav"];
        
        NSString *track1FilePath = [[NSBundle mainBundle]
                                     pathForResource:@"Cap_Snr" ofType:@"wav"];
       
        NSString *track2FilePath = [[NSBundle mainBundle]
                                    pathForResource:@"Hi_Shk3" ofType:@"wav"];

        
        
        NSURL *track0URL = [NSURL fileURLWithPath:track0FilePath];
        NSURL *track1URL = [NSURL fileURLWithPath:track1FilePath];
        NSURL *track2URL = [NSURL fileURLWithPath:track2FilePath];
        
        
        
        
        AudioServicesCreateSystemSoundID( (__bridge CFURLRef)track0URL, &_track0Id);
        AudioServicesCreateSystemSoundID( (__bridge CFURLRef)track1URL, &_track1Id);
        AudioServicesCreateSystemSoundID( (__bridge CFURLRef)track2URL, &_track2Id);
    }
    return self;

}

#pragma mark - play tracks

// This method plays the samples according the track that is called
- (void) playTrackSample: (NSInteger) trackNumber{
    
    switch (trackNumber) {
        case 0: // track 0
            AudioServicesPlaySystemSound(self.track0Id);
            break;
        
        case 1: // track 1
            AudioServicesPlaySystemSound(self.track1Id);
            break;
        
        case 2: // track 2
            AudioServicesPlaySystemSound(self.track2Id);
            break;
            
        case 3: // track 3
            AudioServicesPlaySystemSound(self.track3Id);
            break;
        
        case 4: // track 4
            AudioServicesPlaySystemSound(self.track4Id);
            break;

        case 5: // track 5
            AudioServicesPlaySystemSound(self.track5Id);
            break;
            
        case 6: // track 6
            AudioServicesPlaySystemSound(self.track6Id);
            break;
        
        case 7: // track 7
            AudioServicesPlaySystemSound(self.track7Id);
            break;
        default:
            break;
    }
}

@end

