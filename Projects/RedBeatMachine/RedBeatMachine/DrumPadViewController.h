//
//  DrumPadViewController.h
//  RedBeatMachine
//
//  Created by LJ on 5/2/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrumPadViewController : UIViewController

// First row of beat pads 0 - 3
@property (weak, nonatomic) IBOutlet UIButton *pad0;
@property (weak, nonatomic) IBOutlet UIButton *pad1;
@property (weak, nonatomic) IBOutlet UIButton *pad2;
@property (weak, nonatomic) IBOutlet UIButton *pad3;

// Second row of beat pads 4 - 7
@property (weak, nonatomic) IBOutlet UIButton *pad4;
@property (weak, nonatomic) IBOutlet UIButton *pad5;
@property (weak, nonatomic) IBOutlet UIButton *pad6;
@property (weak, nonatomic) IBOutlet UIButton *pad7;

@end
