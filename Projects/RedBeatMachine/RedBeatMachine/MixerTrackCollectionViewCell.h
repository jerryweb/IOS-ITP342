//
//  MixerTrackCollectionViewCell.h
//  RedBeatMachine
//
//  Created by LJ on 5/4/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrackModel.h"


@interface MixerTrackCollectionViewCell : UICollectionViewCell


- (void) setupCell: (TrackModel *) track : (NSInteger) trackNumber;



@end
