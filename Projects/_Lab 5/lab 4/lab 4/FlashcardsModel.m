//
//  FlashcardsModel.m
//  lab 4
//
//  Created by Jerry Webb on 3/16/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import "FlashcardsModel.h"

@interface FlashcardsModel()

@property (strong, nonatomic) NSMutableArray *flashcards;
@property (nonatomic) NSInteger currentIndex;

@end

@implementation FlashcardsModel

+(instancetype) sharedModel{
    static FlashcardsModel *_sharedModel = nil;

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
        NSDictionary *flashcard1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"How many licks does it take to get to the center of a Tootsie Pop?", kQuestionKey, @"Have you ever actually tried it? Way too many!", kAnswerKey, nil];
        
        NSDictionary *flashcard2 = [[NSDictionary alloc] initWithObjectsAndKeys: @"What is Professor Gregory's favorite color?", kQuestionKey, @"BLUE YAY!!!!", kAnswerKey, nil];
        
        NSDictionary *flashcard3 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Which is easier: Android or iOS?", kQuestionKey, @"Android. Green. Do not argue.", kAnswerKey, nil];
        
        NSDictionary *flashcard4 = [[NSDictionary alloc] initWithObjectsAndKeys: @"What is the meaning of life?", kQuestionKey, @"42", kAnswerKey, nil];
        
        NSDictionary *flashcard5 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Will the iPhone 7 have a headphone jack?", kQuestionKey, @"It better!", kAnswerKey, nil];
        
        _flashcards = [[NSMutableArray alloc] initWithObjects: flashcard1, flashcard2, flashcard3, flashcard4, flashcard5, nil];
        
    }
    return self;
}

-(NSUInteger) numberOfFlashcards{

    return _flashcards.count;
}

- (NSDictionary *) currentFlashcard{
    NSDictionary *flashcard = [self.flashcards objectAtIndex: self.currentIndex];
    return flashcard;
}

- (NSDictionary *) randomFlashcard {
    
    NSUInteger index = arc4random_uniform([self numberOfFlashcards] -1);
//rand() % [self numberOfFlashcards];
    
//    NSLog(@"index is %lu", (unsigned long)rand());
    if(index == self.currentIndex){
        if(self.currentIndex < self.numberOfFlashcards){
            index = self.currentIndex +1;
        }
        else {
            index = 0;
        }

    }

    NSDictionary *flashcard = [self.flashcards objectAtIndex: index];
    self.currentIndex = index;
    
    return flashcard;
}

- (NSDictionary *) flashcardAtIndex: (NSUInteger) index {
    if(index >= self.flashcards.count){
        index = 0;
    }
    return self.flashcards[index];
}

- (void) removeFlashcardAtIndex: (NSUInteger) index {
    // check index
    if(index >= self.flashcards.count || index < 0){
        return;
    }
    
    [self.flashcards removeObjectAtIndex: index];
}


- (void) insertFlashcard:(NSDictionary *)flashcard {

    [self.flashcards addObject: flashcard];
}

- (void) insertFlashcard: (NSString *) question
                  answer: (NSString *) answer{
    
    NSDictionary *flashcardDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               question, kQuestionKey, answer, kAnswerKey, nil];
    [self insertFlashcard: flashcardDict ];
}
    
- (void) insertFlashcard: (NSDictionary *) flashcard
                atIndex: (NSUInteger) index{
    
    //if it is outside the index add it to the end
    if(index >= self.flashcards.count || index < 0){
        [self insertFlashcard: flashcard];
    }
    
    [self.flashcards insertObject: flashcard atIndex: index];
}

- (void) insertFlashcard: (NSString *) question answer: (NSString *) answer atIndex: (NSUInteger) index{
    
    NSDictionary *flashcardDict = [NSDictionary dictionaryWithObjectsAndKeys: question, kQuestionKey, answer, kAnswerKey, nil];

    
    [self insertFlashcard:flashcardDict atIndex: index];
    
}

- (NSDictionary *) nextFlashcard{
    if(self.currentIndex == self.numberOfFlashcards - 1){
        return self.flashcards[0];
    }
    else {
        return self.flashcards[self.currentIndex + 1];
    }
}

- (NSDictionary *) prevFlashcard{
    if(self.currentIndex == 0){
        return self.flashcards[self.numberOfFlashcards - 1];
    }
    else{
        return self.flashcards[self.currentIndex - 1];
    }
}

@end
