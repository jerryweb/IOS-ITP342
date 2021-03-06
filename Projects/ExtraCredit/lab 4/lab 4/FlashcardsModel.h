//
//  FlashcardsModel.h
//  lab 4
//
//  Created by LJ on 3/16/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <Foundation/Foundation.h>

// constants
static NSString * const kQuestionKey = @"question";
static NSString * const kAnswerKey = @"answer";
static NSString * const kFavoritedKey = @"favorite";


@interface FlashcardsModel : NSObject

// public methods
+ (instancetype) sharedModel;
- (NSDictionary *) randomFlashcard;
- (NSDictionary *) currentFlashcard;
- (NSUInteger) numberOfFlashcards;
- (NSDictionary *) flashcardAtIndex: (NSUInteger) index;
- (void) removeFlashcardAtIndex: (NSUInteger) index;

- (void) insertFlashcard: (NSDictionary *) flashcard;

- (void) insertFlashcard: (NSString *) question
                  answer: (NSString *) answer;

- (void) insertFlashcard: (NSDictionary *) flashcard
                 atIndex: (NSUInteger) index;

- (void) insertFlashcard: (NSString *) question
                  answer: (NSString *) answer
                 atIndex: (NSUInteger) index;
- (NSDictionary *) nextFlashcard;
- (NSDictionary *) prevFlashcard;

// Favorites methods
- (BOOL) getFavoriteFlashcard: (NSDictionary *) flashcard;
- (void) setFavoriteFlashcard: (NSDictionary *) flashcard;
- (NSInteger) getNumberOfFavorites;
- (NSDictionary *) favortieFlashcardAtIndex: (NSUInteger) index;
- (void) addFavoriteFlashcard: (NSDictionary *) flashcard;
- (void) removeFavoriteFlashcardAtIndex: (NSUInteger) index;


@end
