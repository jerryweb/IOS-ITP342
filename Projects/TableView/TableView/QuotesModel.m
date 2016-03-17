//
//  QuotesModel.m
//  Quotes
//
//  Created by Trina Gregory on 9/28/15.
//  Copyright (c) 2015 Trina Gregory. All rights reserved.
//

#import "QuotesModel.h"

// class extension
@interface QuotesModel ()

// private properties
@property (strong, nonatomic) NSMutableArray *quotes;

@end

@implementation QuotesModel

+ (instancetype) sharedModel {
    static QuotesModel *_sharedModel = nil;
    
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
        // initialize our properties
        NSDictionary *quote1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Live as if you were to die tomorrow.\nLearn as if you were to live forever.", kQuoteKey,
                                  @"Mahatma Gandhi", kAuthorKey, nil];
        NSDictionary *quote2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Anyone who has never made a mistake has never tried anything new.", kQuoteKey,
                                @"Albert Einstein", kAuthorKey, nil];
        NSDictionary *quote3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"It isn't what we say or think that defines us, but what we do.", kQuoteKey,
                                @"Jane Austen", kAuthorKey, nil];
        NSDictionary *quote4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"The ones who are crazy enough to think that they can change the world, are the ones who do.", kQuoteKey,
                                @"Steve Jobs", kAuthorKey, nil];
        NSDictionary *quote5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Success is a lousy teacher. It seduces smart people into thinking they can't lose.", kQuoteKey,
                                @"Bill Gates", kAuthorKey, nil];
        NSDictionary *quote6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"No one can make you feel inferior without your consent.", kQuoteKey,
                                @"Eleanor Roosevelt", kAuthorKey, nil];
        NSDictionary *quote7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Hate, it has caused a lot of problems in the world, but has not solved one yet.", kQuoteKey,
                                @"Maya Angelou", kAuthorKey, nil];
        NSDictionary *quote8 = [[NSDictionary alloc] initWithObjectsAndKeys:@"It takes a great deal of bravery to stand up to our enemies, but just as much to stand up to our friends.", kQuoteKey,
                                @"J. K. Rowling", kAuthorKey, nil];
        _quotes = [[NSMutableArray alloc] initWithObjects:
                   quote1, quote2, quote3, quote4, quote5, quote6, quote7, quote8, nil];
    }
    return self;
}

- (NSUInteger) numberOfQuotes {
    return [self.quotes count];
}

- (NSDictionary *) randomQuote {
    
    NSUInteger index = random() % [self numberOfQuotes];
    
    NSDictionary *quote = [self.quotes objectAtIndex: index];
//    NSDictionary *quote = self.quotes[index];

    return quote;
}

- (NSDictionary *) quoteAtIndex: (NSUInteger) index {
    // check index
    if(index < self.quotes.count){
        return self.quotes[index];
    }
    else{
        return 0;
    }
}

- (void) removeQuoteAtIndex: (NSUInteger) index {
    // check index
    if(index < self.quotes.count){
        [self.quotes removeObjectAtIndex: index];
    }
}

- (void) insertQuote: (NSDictionary *) quote {
    
    [self.quotes addObject: quote];
}

- (void) insertQuote: (NSString *) quote
              author: (NSString *) author {
    
    NSDictionary *quoteDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               quote, kQuoteKey, author, kAuthorKey, nil];
    
    [self insertQuote: quoteDict ];
    
//    [self.quotes addObject:quoteDict];
}

- (void) insertQuote: (NSDictionary *) quote
             atIndex: (NSUInteger) index {
    
    [self.quotes insertObject: quote atIndex: index];
}

- (void) insertQuote: (NSString *) quote
              author: (NSString *) author
             atIndex: (NSUInteger) index {
    
    NSDictionary *quoteDict = [NSDictionary dictionaryWithObjectsAndKeys:
                           quote, kQuoteKey, author, kAuthorKey, nil];
    
    [self insertQuote:quoteDict atIndex:index];
    
//    [self.quotes insertObject:quoteDict atIndex: index];
}

@end
