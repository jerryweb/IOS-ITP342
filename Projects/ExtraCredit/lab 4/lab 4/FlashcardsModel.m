//
//  FlashcardsModel.m
//  lab 4
//
//  Created by Jerry Webb on 3/16/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import "FlashcardsModel.h"
static NSString *const kFlashcardsPList = @"Flashcards.list";

@interface FlashcardsModel()

@property (strong, nonatomic) NSMutableArray *flashcards;
@property (strong, nonatomic) NSMutableArray *favortiedFlashcards;
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic) NSInteger numberOfFavorites;
@property (strong, nonatomic) NSString *filePath;

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

        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        _filePath = [documentsDirectory stringByAppendingPathComponent:kFlashcardsPList];
        
        _flashcards = [NSMutableArray arrayWithContentsOfFile:_filePath];
        
        
        self.numberOfFavorites = 0;

        if(!self.flashcards){

        NSDictionary *flashcard1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"How many licks does it take to get to the center of a Tootsie Pop?", kQuestionKey, @"Have you ever actually tried it? Way too many!", kAnswerKey, @"NO", kFavoritedKey, nil];
        
        NSDictionary *flashcard2 = [[NSDictionary alloc] initWithObjectsAndKeys: @"What is Professor Gregory's favorite color?", kQuestionKey, @"BLUE YAY!!!!", kAnswerKey, @"YES", kFavoritedKey, nil];
        
        NSDictionary *flashcard3 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Which is easier: Android or iOS?", kQuestionKey, @"Android. Green. Do not argue.", kAnswerKey, @"NO", kFavoritedKey, nil];
        
        NSDictionary *flashcard4 = [[NSDictionary alloc] initWithObjectsAndKeys: @"What is the meaning of life?", kQuestionKey, @"42", kAnswerKey, @"NO", kFavoritedKey, nil];
        
        NSDictionary *flashcard5 = [[NSDictionary alloc] initWithObjectsAndKeys: @"Will the iPhone 7 have a headphone jack?", kQuestionKey, @"It better!", kAnswerKey, @"NO", kFavoritedKey, nil];
        
        _flashcards = [[NSMutableArray alloc] initWithObjects: flashcard1, flashcard2, flashcard3, flashcard4, flashcard5, nil];
            
        }
        else{
            NSInteger a = [self getNumberOfFavorites];
        }

    }
    return self;
}

-(NSUInteger) numberOfFlashcards{
//    NSLog(@"the num of cards direct is: %li", (long)[self.flashcards count]);
    return [self.flashcards count];
}

- (NSDictionary *) currentFlashcard{
    NSDictionary *flashcard = [self.flashcards objectAtIndex: self.currentIndex];
    return flashcard;
}

- (NSDictionary *) randomFlashcard {
    
    
    NSUInteger index = arc4random_uniform([self numberOfFlashcards] -1);
//rand() % [self numberOfFlashcards];
        if(index == self.currentIndex && self.numberOfFlashcards != 1){
        if(self.currentIndex < [self numberOfFlashcards]){
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

- (NSDictionary *) favortieFlashcardAtIndex: (NSUInteger) index {
    if(index >= self.favortiedFlashcards.count){
        index = 0;
    }
    return self.flashcards[index];
}




- (void) removeFlashcardAtIndex: (NSUInteger) index {
    // check index
    NSUInteger zero = 0;

    if(index >= self.flashcards.count || index < zero){
        return;
    }
    
    [self.favortiedFlashcards removeObject:self.flashcards[index]];
    [self.flashcards removeObjectAtIndex: index];
    [self save];
}


- (void) insertFlashcard:(NSDictionary *)flashcard {

    [self.flashcards addObject: flashcard];
    [self save];
}

- (void) insertFlashcard: (NSString *) question
                  answer: (NSString *) answer{
    
    NSDictionary *flashcardDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               question, kQuestionKey, answer, @"NO", kFavoritedKey, nil];
    [self insertFlashcard: flashcardDict ];
}
    
- (void) insertFlashcard: (NSDictionary *) flashcard
                atIndex: (NSUInteger) index{
    NSUInteger zero = 0;
    //if it is outside the index add it to the end
    if(index >= self.flashcards.count || index < zero){
        [self insertFlashcard: flashcard];
    }
    
    [self.flashcards insertObject: flashcard atIndex: index];
}

- (void) insertFlashcard: (NSString *) question answer: (NSString *) answer atIndex: (NSUInteger) index{
    
    NSDictionary *flashcardDict = [NSDictionary dictionaryWithObjectsAndKeys: question, kQuestionKey, answer, kAnswerKey, @"NO", kFavoritedKey, nil];

    
    [self insertFlashcard:flashcardDict atIndex: index];
    
}

- (NSDictionary *) nextFlashcard{
    if(self.currentIndex == ([self numberOfFlashcards] - 1)){
        self.currentIndex = 0;
        return self.flashcards[self.currentIndex];
    }
    else {
        self.currentIndex = self.currentIndex + 1;
        return self.flashcards[self.currentIndex];
    }
}

- (NSDictionary *) prevFlashcard{
    if(self.currentIndex == 0){
        self.currentIndex = [self numberOfFlashcards] - 1;
//        NSLog(@"the current index and num of cards is: %li", (long)self.currentIndex );
        return self.flashcards[self.currentIndex];
    }
    else{
        self.currentIndex = self.currentIndex - 1;
        return self.flashcards[self.currentIndex];
    }
}

- (void) save {
    [self.flashcards writeToFile:self.filePath atomically:YES];
}

- (void) setFavoriteFlashcard: (NSDictionary *) flashcard {
    if(![flashcard[kFavoritedKey] boolValue]){
                [self addFavoriteFlashcard:flashcard];
    }
    else {
        NSDictionary * newFlashcard = [NSDictionary dictionaryWithObjectsAndKeys: flashcard[kQuestionKey], kQuestionKey, flashcard[kAnswerKey], kAnswerKey, @"NO", kFavoritedKey, nil];
        if (self.numberOfFavorites != 0){
            self.numberOfFavorites--;
        }
        [self removeFlashcardAtIndex:self.currentIndex];
        [self insertFlashcard:newFlashcard atIndex:self.currentIndex];
        [self.favortiedFlashcards removeObject:flashcard];
    }
    
    
//    NSInteger index = self.currentIndex;
//    [self removeFlashcardAtIndex:index];
//    BOOL favoriteValue = [oldFlashcard[kFavoritedKey] boolValue];
//    //    favoriteValue = !favoriteValue;
//    NSDictionary * newFlashcard;
//    if (favoriteValue){
//        newFlashcard = [NSDictionary dictionaryWithObjectsAndKeys: oldFlashcard[kQuestionKey], kQuestionKey, oldFlashcard[kAnswerKey], kAnswerKey, @"NO", kFavoritedKey, nil];
//        if (self.numberOfFavorites != 0){
//            self.numberOfFavorites--;
//        }
//    }
//    else{
//        newFlashcard = [NSDictionary dictionaryWithObjectsAndKeys: oldFlashcard[kQuestionKey], kQuestionKey, oldFlashcard[kAnswerKey], kAnswerKey, @"YES", kFavoritedKey, nil];
//        self.numberOfFavorites++;
//    }
//    [self insertFlashcard:newFlashcard atIndex:index];
}

- (BOOL) getFavoriteFlashcard: (NSDictionary *) flashcard { //(NSInteger) index{
    return [flashcard[kFavoritedKey] boolValue];
}

- (NSInteger) getNumberOfFavorites {
//    self.numberOfFavorites = 0;
//    for (int i = 0; i < [self numberOfFlashcards]; i++){
//        if ([self.flashcards[i][kFavoritedKey] boolValue]){
//            self.numberOfFavorites++;
//            [self.favortiedFlashcards addObject:self.flashcards[i]];
//            NSLog(@"worked");
//        }
//    }
    return self.favortiedFlashcards.count;
    
}

- (void) addFavoriteFlashcard: (NSDictionary *) flashcard {
    NSDictionary * newFlashcard = [NSDictionary dictionaryWithObjectsAndKeys: flashcard[kQuestionKey], kQuestionKey, flashcard[kAnswerKey], kAnswerKey, @"YES", kFavoritedKey, nil];
            self.numberOfFavorites++;
    [self removeFlashcardAtIndex:self.currentIndex];
    [self insertFlashcard:newFlashcard atIndex:self.currentIndex];
    [self.favortiedFlashcards addObject:newFlashcard];
}

- (void) removeFavoriteFlashcardAtIndex: (NSUInteger) index {
    // check index
    NSUInteger zero = 0;
    
    if(index >= self.favortiedFlashcards.count || index < zero){
        return;
    }
    
    [self.favortiedFlashcards removeObjectAtIndex: index];
//    [self save];
}


@end
