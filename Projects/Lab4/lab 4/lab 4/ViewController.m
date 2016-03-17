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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.model = [[FlashcardsModel alloc] init];
    NSDictionary *flashcard = [self.model randomFlashcard];
    self.questionLabel.text = flashcard[kQuestionKey];
    
    
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
        self.questionLabel.text = flashcard[kQuestionKey];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) singleTapRecognized: (UITapGestureRecognizer *) recognizer{
    NSDictionary *flashcard = [self.model randomFlashcard];
    self.questionLabel.text = flashcard[kQuestionKey];
}

- (void) swipeRightRecognized: (UISwipeGestureRecognizer *) recognizer{
    NSDictionary *flashcard = [self.model nextFlashcard];
    self.questionLabel.text = flashcard[kQuestionKey];
}

- (void) swipeLeftRecognized: (UISwipeGestureRecognizer *) recognizer{
    NSDictionary *flashcard = [self.model prevFlashcard];
    self.questionLabel.text = flashcard[kQuestionKey];
}

- (void) doubleTapRecognized: (UITapGestureRecognizer *) recognizer{
    NSDictionary *flashcard = [self.model currentFlashcard];
    self.questionLabel.text = flashcard[kAnswerKey];
}

@end
