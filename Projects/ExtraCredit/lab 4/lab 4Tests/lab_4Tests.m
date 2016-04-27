//
//  lab_4Tests.m
//  lab 4Tests
//
//  Created by LJ on 3/14/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FlashcardsModel.h"

@interface lab_4Tests : XCTestCase
@property (strong, nonatomic) FlashcardsModel *testModel;

@end

@implementation lab_4Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.testModel = [[FlashcardsModel alloc] init];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) logArray {
    NSDictionary *flashcard;
    
    for (NSUInteger i=0; i < [self.testModel numberOfFlashcards]; i++) {
        flashcard = [self.testModel flashcardAtIndex:i];
        
        //        NSLog (@"Quote: %@ Author: %@", [quote objectForKey: kQuoteKey],
        //               [quote objectForKey: kAuthorKey]);
        
        NSLog(@"Question: %@ Answer: %@", flashcard[kQuestionKey],
              flashcard[kAnswerKey] );
    }
    NSLog(@" ");
}

- (void) testDataModel {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    // local variables
    NSUInteger num;
    NSDictionary *flashcard;
    NSDictionary *flashcard2;

    
    // test init
    num = 5; // I know that the init creates 5 quotes
    XCTAssertEqual(num, [self.testModel numberOfFlashcards]);
    NSLog(@"Initial array:");
    [self logArray];
    
    // test insertFlashcard
    flashcard =  [[NSDictionary alloc] initWithObjectsAndKeys:@"Is this a new question?", kQuestionKey, @"Yes", kAnswerKey, nil];
    [self.testModel insertFlashcard: flashcard];
    num = num +1;
    XCTAssertEqual(num, [self.testModel numberOfFlashcards]);
    NSLog(@"Insert new flashcard at end");
    [self logArray];
    
    // test insertFlashcard:answer
    [self.testModel insertFlashcard:@"Are we inserting a new flashcard?" answer:@"yes"];
    num = num +1;
    XCTAssertEqual(num, [self.testModel numberOfFlashcards]);
    NSLog(@"Insert new flashcard at end with Question: 'Are we inserting a new flashcard?' and Answer: 'yes'.");
    [self logArray];
    
    
    // test inserFlashcardAtIndex
    flashcard2 =  [[NSDictionary alloc] initWithObjectsAndKeys:@"Is this another new question?", kQuestionKey, @"Yes I hope so", kAnswerKey, nil];
    [self.testModel insertFlashcard:flashcard2 atIndex:3];
    num = num +1;
    XCTAssertEqual(num, [self.testModel numberOfFlashcards]);
    NSLog(@"Insert new flashcard at index 3");
    [self logArray];

    // test insertFlashcard: question answer: answer atIndex: index;
    [self.testModel insertFlashcard:@"Are you tired right now?" answer:@"Of course!!!!" atIndex:1];
    num = num +1;
    XCTAssertEqual(num, [self.testModel numberOfFlashcards]);
    NSLog(@"Insert new flashcard at index 1 with Question: 'Are you tired right now?' and Answer: 'Of course!!!!'.");
    [self logArray];
    
    // test removeFlashcardAtIndex
    [self.testModel removeFlashcardAtIndex:0];
    num = num - 1;
    XCTAssertEqual(num, [self.testModel numberOfFlashcards]);
    NSLog(@"Removed first flashcard");
    [self logArray];
    
}





- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
