//
//  DetailViewController.m
//  Lab 6
//
//  Created by LJ on 4/29/16.
//  Copyright © 2016 Jerry Webb. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityViewIndicator;
@property (weak, nonatomic) IBOutlet UINavigationItem *detaillNavItem;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *website = self.place[@"website"];
    NSURL *url = [[NSURL alloc] initWithString:website];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) webViewDidStartLoad: (UIWebView *) webView {
    [self.activityViewIndicator startAnimating];
}

- (void) webViewDidFinishLoad: (UIWebView *) webView {
    [self.activityViewIndicator stopAnimating];
}

- (void) webView: (UIWebView *) detailWebView didFailLoadWithError:(nullable NSError *)error {
    [self.activityViewIndicator stopAnimating];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
