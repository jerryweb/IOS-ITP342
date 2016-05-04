//
//  DrumPadViewController.m
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import "DrumPadViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "TrackModel.h"
#import "SequencerModel.h"


@interface DrumPadViewController ()
@property (strong, nonatomic) TrackModel *trackModel;
@property (strong, nonatomic) SequencerModel *sequencerModel;

@property (weak, nonatomic) IBOutlet UISlider *masterVolumeSlider;
@property (weak, nonatomic) IBOutlet UILabel *masterVolumeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIStepper *bpmStepper;
@property (weak, nonatomic) IBOutlet UITextView *bmpTextView;


@end

@implementation DrumPadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.trackModel = [TrackModel sharedModel];
    self.sequencerModel = [SequencerModel sharedModel];
    [self setBpmTextView];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - Playback settings: This is settings such as volume and bpm modifier events are handled

- (void) modifyMasterVolume: (float) volume{
    NSString *percentSign = @"%";
    self.masterVolumeLabel.text = [NSString stringWithFormat:@"%.00f%@", volume*100, percentSign];
}
- (IBAction)sliderChangeMasterVolume:(id)sender {
    
    [self modifyMasterVolume: self.masterVolumeSlider.value];
    
}

- (void) setMasterVolume: (float) volume {
    self.masterVolumeSlider.value = volume/100;
    [self modifyMasterVolume: self.masterVolumeSlider.value];
}

- (IBAction)stepBpm:(id)sender {
    [self.sequencerModel setBpm:self.bpmStepper.value];
    [self setBpmTextView];
}

- (void) setBpmTextView{
    self.bmpTextView.text = [NSString stringWithFormat: @"%ld", (long)self.sequencerModel.bpm];
}



#pragma mark - transport button events these are the actions associated to the transport buttons (play, pause, stop, and record)

- (IBAction)togglePlayButton:(id)sender {
    if(!self.sequencerModel.play){
        [self.playButton setImage:[UIImage imageNamed:@"play_active.png"] forState:UIControlStateNormal];
        
    }
    else {
        [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    }
    self.sequencerModel.play = !self.sequencerModel.play;
}




#pragma mark - Triggering pad to play sounds

// When touched, the pad will play the sample attached to the respective track signleton. Example, pad 0 will play the sound set to track 0



- (IBAction)triggerPad0:(id)sender {
    [self.trackModel playTrackSample:0];
//    [self.pad0 setTitle:@"drum" forState:UIControlStateNormal];
}

- (IBAction)triggerPad1:(id)sender {
    [self.trackModel playTrackSample:1];
}

- (IBAction)triggerPad2:(id)sender {
    [self.trackModel playTrackSample:2];
}

- (IBAction)triggerPad3:(id)sender {
    [self.trackModel playTrackSample:3];

}

- (IBAction)triggerPad4:(id)sender {
    [self.trackModel playTrackSample:4];
}

- (IBAction)triggerPad5:(id)sender {
    [self.trackModel playTrackSample:5];
}

- (IBAction)triggerPad6:(id)sender {
    [self.trackModel playTrackSample:6];
}

- (IBAction)triggerPad7:(id)sender {
    [self.trackModel playTrackSample:7];
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
