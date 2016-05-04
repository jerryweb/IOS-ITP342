//
//  MixerViewController.m
//  RedBeatMachine
//
//  Created by LJ on 5/3/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import "MixerViewController.h"

@interface MixerViewController ()
@property (weak, nonatomic) IBOutlet UISlider *MasterVolumeSlider;

@end

@implementation MixerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Rotate the slider to have a verticle orientation
    CGAffineTransform trans = CGAffineTransformMakeRotation(-M_PI_2);
    self.MasterVolumeSlider.transform = trans;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
