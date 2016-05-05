//
//  StepSequencerViewController.h
//  RedBeatMachine
//
//  Created by LJ on 5/4/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepSequencerViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>{
    IBOutlet UICollectionView *trackNameAndSequenceCollectionView;
}

@end
