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
        NSDictionary *flashcard1 = [[NSMutableArray alloc] initWithObjects:@"How many licks does it take to get to the center of a Tootsie Pop?", kQuestionKey, @"Have you ever actually tried it? Way too many!", kAnswerKey, nil];
        
        NSDictionary *flashcard2 = [[NSMutableArray alloc] initWithObjects: @"What is Professor Gregory's favorite color?", kQuestionKey, @"BLUE YAY!!!!", kAnswerKey, nil];
        
        NSDictionary *flashcard3 = [[NSMutableArray alloc] initWithObjects: @"Which is easier: Android or IOS?", kQuestionKey, @"Android. Green. Do not argue.", kAnswerKey, nil];
        
        NSDictionary *flashcard4 = [[NSMutableArray alloc] initWithObjects: @"What is the meaning of life?", kQuestionKey, @"42", kAnswerKey, nil];
        
        NSDictionary *flashcard5 = [[NSMutableArray alloc] initWithObjects: @"Will the iPhone 7 have a headphone jack?", kQuestionKey, @"It better!", kAnswerKey, nil];
        
        _flashcards = [[NSMutableArray alloc] initWithObjects: flashcard1, flashcard2, flashcard3, flashcard4, flashcard5, nil];
        
    }
    return self;
}

-(NSUInteger) numberOfFlashcards{
    return _flashcards.count;
}

- (NSDictionary *) randomFlashcard {
    
    NSUInteger index = random() % [self numberOfFlashcards];
    
    NSDictionary *flashcard = [self.flashcards objectAtIndex: index];
    
    return flashcard;
}

- (NSDictionary *) flashcardAtIndex: (NSUInteger) index {
    return self.flashcards[index];
}

- (void) removeFlashcardAtIndex: (NSUInteger) index {
    // check index
    
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
    
    [self.flashcards insertObject: flashcard atIndex: index];
}

- (void) insertFlashcard: (NSString *) question answer: (NSString *) answer atIndex: (NSUInteger) index{
    
    NSDictionary *flashcardDict = [NSDictionary dictionaryWithObjectsAndKeys: question, kQuestionKey, answer, kAnswerKey, nil];
    
    [self insertFlashcard:flashcardDict atIndex: index];
    
}

- (NSDictionary *) nextFlashcard{
    return self.flashcards[1];
}

- (NSDictionary *) prevFlashcard{
    return self.flashcards[0];
}

@end
