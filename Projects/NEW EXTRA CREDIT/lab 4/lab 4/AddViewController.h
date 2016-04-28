//
//  AddViewController.h
//  lab 4
//
//  Created by LJ on 4/1/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^AddQuestionCompletionHandler)(NSString* textViewString, NSString* textFieldString);

@interface AddViewController : UIViewController

@property (nonatomic, copy) AddQuestionCompletionHandler completion;
@property (nonatomic, strong) NSString* labelString;
@property (strong, nonatomic) NSString* textFieldPlaceHolder;

@end
