//
//  StepSequencerViewController.m
//  RedBeatMachine
//
//  Created by LJ on 5/4/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import "StepSequencerViewController.h"
#import "TracksSingleton.h"
#import "SequencerModel.h"

@interface StepSequencerViewController ()
@property (strong, nonatomic) TracksSingleton *tracksSingleton;
@property (strong, nonatomic) SequencerModel *sequencerModel;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *pausButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *metronomeButton;
@property (weak, nonatomic) IBOutlet UITextView *bpmTextView;
@property (weak, nonatomic) IBOutlet UIStepper *bpmStepper;


@end

@implementation StepSequencerViewController

- (void)viewWillAppear:(BOOL)animated {
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    self.tracksSingleton = [TracksSingleton sharedModel];
    self.sequencerModel = [SequencerModel sharedModel];
    [self setBpmTextView];
    [self.bpmStepper setValue:[self.sequencerModel bpm]];

    if(!self.sequencerModel.play){
        [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    }
    else{
        [self.playButton setImage:[UIImage imageNamed:@"play_active.png"] forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - transport button events these are the actions associated to the transport buttons (play, pause, stop, and record)

- (IBAction)playButtonPressed:(id)sender {
    if(!self.sequencerModel.play){
        [self.playButton setImage:[UIImage imageNamed:@"play_active.png"] forState:UIControlStateNormal];
        
    }
    else {
        [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    }
    self.sequencerModel.play = !self.sequencerModel.play;

}

- (IBAction)pauseButtonPressed:(id)sender {
    [self stopPlaying];

}
- (IBAction)stopButtonPressed:(id)sender {
    [self stopPlaying];

}


- (IBAction)metronomeButtonPressed:(id)sender {
}

- (void) stopPlaying{
    self.sequencerModel.play = NO;
    [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
}



#pragma mark - Playback settings: This is settings such as volume and bpm modifier events are handled

- (IBAction)stepBpm:(id)sender {
    [self.sequencerModel setBpm:self.bpmStepper.value];
    [self setBpmTextView];
}

- (void) setBpmTextView{
    self.bpmTextView.text = [NSString stringWithFormat: @"%ld", (long)self.sequencerModel.bpm];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
