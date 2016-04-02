//
//  ViewController.m
//  lab 4
//
//  Created by LJ on 3/14/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "FlashcardsModel.h"

@interface ViewController ()
@property (strong, nonatomic) FlashcardsModel *model;
//@property (strong, nonatomic) AVAudioPlayer *singleAudioPlayer, *doubleAudioPlayer;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (readonly) SystemSoundID fadeInFileId;
@property (readonly) SystemSoundID taDaFileId;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.model = [[FlashcardsModel alloc] init];
    NSDictionary *flashcard = [self.model randomFlashcard];
    self.questionLabel.text = flashcard[kQuestionKey];
    
    NSString *fadeInFilePath = [[NSBundle mainBundle]
                            pathForResource:@"fadein" ofType:@"wav"];
    
    NSString *taDaFilePath = [[NSBundle mainBundle]
                                pathForResource:@"TaDa" ofType:@"wav"];
    
    NSURL *fadeInURL = [NSURL fileURLWithPath:fadeInFilePath];
    NSURL *taDaURL = [NSURL fileURLWithPath:taDaFilePath];

    
    AudioServicesCreateSystemSoundID( (__bridge CFURLRef)fadeInURL, &_fadeInFileId);
    AudioServicesCreateSystemSoundID( (__bridge CFURLRef)taDaURL, &_taDaFileId);

    
    // Add tap gestures
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapRecognized:)];
    [self.view addGestureRecognizer:singleTap];
   
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapRecognized:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightRecognized:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftRecognized:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];

}

// Animations
- (void) fadeInQuestion: (NSString *) question {
    self.questionLabel.alpha = 0;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.questionLabel.alpha = 1;
        self.questionLabel.text = question;

    }];
}

- (void) displayFlashcard: (NSString *) question {
    [UIView animateWithDuration:1.0
                     animations:^{
        self.questionLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [self fadeInQuestion: question];
    }];
}

- (void) animateFlashcard:(NSString *) question {
    self.questionLabel.text = question;
    
    if(self.questionLabel.textColor == UIColor.whiteColor){
        self.questionLabel.textColor = UIColor.blackColor;
    }
    else {
        self.questionLabel.textColor = UIColor.whiteColor;
    }
    
    [UIView animateWithDuration:1.0 animations:^{
        self.questionLabel.alpha = 1;
    }];
}

- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (void) viewDidAppear:(BOOL) animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake){
        NSDictionary *flashcard = [self.model randomFlashcard];
        
        // Play sound
        AudioServicesPlaySystemSound(self.fadeInFileId);
        
        [self fadeInQuestion:flashcard[kQuestionKey]];
//        self.questionLabel.text = flashcard[kQuestionKey];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) singleTapRecognized: (UITapGestureRecognizer *) recognizer{
    NSDictionary *flashcard = [self.model randomFlashcard];
//    self.questionLabel.text = flashcard[kQuestionKey];
    // Play sound
    AudioServicesPlaySystemSound(self.fadeInFileId);
    [self fadeInQuestion:flashcard[kQuestionKey]];
}

- (void) swipeRightRecognized: (UISwipeGestureRecognizer *) recognizer{
    NSDictionary *flashcard = [self.model nextFlashcard];
    //    self.questionLabel.text = flashcard[kQuestionKey];    [self fadeInQuestion:flashcard[kQuestionKey]];
    // Play sound
    AudioServicesPlaySystemSound(self.fadeInFileId);
    [self fadeInQuestion:flashcard[kQuestionKey]];

}

- (void) swipeLeftRecognized: (UISwipeGestureRecognizer *) recognizer{
    NSDictionary *flashcard = [self.model prevFlashcard];
//    self.questionLabel.text = flashcard[kQuestionKey];
    // Play sound
    AudioServicesPlaySystemSound(self.fadeInFileId);
    [self fadeInQuestion:flashcard[kQuestionKey]];

}

- (void) doubleTapRecognized: (UITapGestureRecognizer *) recognizer{
    NSDictionary *flashcard = [self.model currentFlashcard];
//    self.questionLabel.text = flashcard[kAnswerKey];
    
    self.questionLabel.alpha = 0;
    AudioServicesPlaySystemSound(self.taDaFileId);

    [UIView animateWithDuration:1.0 animations:^{
        self.questionLabel.alpha = 1;
        [self animateFlashcard:flashcard[kAnswerKey]];
//        self.questionLabel.text = question;
        
    }];
}

@end
