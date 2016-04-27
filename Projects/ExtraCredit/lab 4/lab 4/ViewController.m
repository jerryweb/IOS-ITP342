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

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@property (readonly) SystemSoundID fadeInFileId;
@property (readonly) SystemSoundID taDaFileId;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//#if TARGET_IPHONE_SIMULATOR
//    NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
//#endif
//    
    
    
    self.model = [FlashcardsModel sharedModel];
    if([self.model numberOfFlashcards] == 0){
        self.questionLabel.text = @"Please create some flashcards!";
    }
    else{
        NSDictionary *flashcard = [self.model randomFlashcard];
        self.questionLabel.text = flashcard[kQuestionKey];
//        NSLog(boolValue ? @"Yes" : @"No");

        if([self.model getFavoriteFlashcard:flashcard]){
            [self.favoriteButton setImage:[UIImage imageNamed:@"starFilled.png"] forState:UIControlStateNormal];
    
        }
    }
    
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

// Change Favorite Button
- (void) updateFavoriteButton: (BOOL) favoriteValue {
    
    if(favoriteValue){
        [self.favoriteButton setImage:[UIImage imageNamed:@"starFilled.png"] forState:UIControlStateNormal];
    }
    else{
        [self.favoriteButton setImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)toggleFavorite:(id)sender {
     [self.model setFavoriteFlashcard];
     NSDictionary *flashcard = [self.model currentFlashcard];

     [self updateFavoriteButton:[flashcard[kFavoritedKey] boolValue]];

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
        
        // Play sound
        AudioServicesPlaySystemSound(self.fadeInFileId);
        
//        [self fadeInQuestion:flashcard[kQuestionKey]];
        if([self.model numberOfFlashcards] > 0){
            NSDictionary *flashcard = [self.model randomFlashcard];
            [self fadeInQuestion:flashcard[kQuestionKey]];
            [self updateFavoriteButton:[flashcard[kFavoritedKey] boolValue]];

        }
        else {
            [self fadeInQuestion:@"There are no more flashcards."];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) singleTapRecognized: (UITapGestureRecognizer *) recognizer{
//    self.questionLabel.text = flashcard[kQuestionKey];
    // Play sound
    AudioServicesPlaySystemSound(self.fadeInFileId);
//    [self fadeInQuestion:flashcard[kQuestionKey]];
    if([self.model numberOfFlashcards] > 0){
        NSDictionary *flashcard = [self.model randomFlashcard];
        [self fadeInQuestion:flashcard[kQuestionKey]];
        [self updateFavoriteButton:[flashcard[kFavoritedKey] boolValue]];

    }
    else {
        [self fadeInQuestion:@"There are no more flashcards."];
    }
}

- (void) swipeRightRecognized: (UISwipeGestureRecognizer *) recognizer{
    // Play sound
    AudioServicesPlaySystemSound(self.fadeInFileId);
//    [self fadeInQuestion:flashcard[kQuestionKey]];
    if([self.model numberOfFlashcards] > 0){
        NSDictionary *flashcard = [self.model prevFlashcard];
        [self fadeInQuestion:flashcard[kQuestionKey]];
        [self updateFavoriteButton:[flashcard[kFavoritedKey] boolValue]];

    }
    else {
        [self fadeInQuestion:@"There are no more flashcards."];
    }

}

- (void) swipeLeftRecognized: (UISwipeGestureRecognizer *) recognizer{
    // Play sound
    AudioServicesPlaySystemSound(self.fadeInFileId);
    if([self.model numberOfFlashcards] > 0){
        NSDictionary *flashcard = [self.model nextFlashcard];

        [self fadeInQuestion:flashcard[kQuestionKey]];
        [self updateFavoriteButton:[flashcard[kFavoritedKey] boolValue]];
    }
    else {
        [self fadeInQuestion:@"There are no more flashcards."];
    }
}

- (void) doubleTapRecognized: (UITapGestureRecognizer *) recognizer{
//    self.questionLabel.text = flashcard[kAnswerKey];
    
    self.questionLabel.alpha = 0;
    AudioServicesPlaySystemSound(self.taDaFileId);

    [UIView animateWithDuration:1.0 animations:^{
        self.questionLabel.alpha = 1;
        if([self.model numberOfFlashcards] > 0){
            NSDictionary *flashcard = [self.model currentFlashcard];
            [self animateFlashcard:flashcard[kAnswerKey]];
            [self updateFavoriteButton:[flashcard[kFavoritedKey] boolValue]];
        }
        else {
            [self animateFlashcard:@"Please add more flashcards."];
        }
        
    }];
}

@end
