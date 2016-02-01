//
//  ViewController.m
//  Lab2
//
//  Created by Jerry Webb on 1/27/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import "ViewController.h"
//this is the class extension
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) touchesBegan: (NSSet *) touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    
    if([self.nameTextField isFirstResponder] && [touch view] != self.nameTextField){
        [self.nameTextField resignFirstResponder];
    }
}

- (IBAction)dismissKeyboard:(id)sender {
    [sender resignFirstResponder];
}


- (IBAction)pirateButtonTouched:(id)sender {
    NSInteger nameLength = self.nameTextField.text.length;
    
    if (nameLength > 0) {
        [self.messageLabel setText:[@"Pirates are terrible... that's why there aren't any new Pirates of the Caribbean movies. Shame on you " stringByAppendingString:(self.nameTextField.text)]];
    }
    else{
        [self.messageLabel setText:@"Please enter a valid name"];
    }
    
    
}
- (IBAction)ninjaButtonTouched:(id)sender {
    NSInteger nameLength = self.nameTextField.text.length;

    if (nameLength > 0) {
        [self.messageLabel setText:[@"Ninjas are dope... just ask Naruto! Good job " stringByAppendingString:(self.nameTextField.text)]];
    }
    else{
        [self.messageLabel setText:@"Please enter a valid name"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
