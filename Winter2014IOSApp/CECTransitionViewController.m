//
//  CECTransitionViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/23/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "CECTransitionViewController.h"

@interface CECTransitionViewController ()

@end

@implementation CECTransitionViewController

@synthesize webView, activity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [TestFlight passCheckpoint:@"CECTransition-info-viewed"];
    
    webView.delegate = self;
    
    NSString *httpSource = @"http://speedyreference.com/bicsiappcms/cectransition.html";
    NSURL *fullUrl = [NSURL URLWithString:httpSource];
    NSURLRequest *httpRequest = [NSURLRequest requestWithURL:fullUrl];
    [webView loadRequest:httpRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)WebView
{
    [activity startAnimating];
    
    
}

-(void)webViewDidFinishLoad:(UIWebView *)WebView
{
    [activity stopAnimating];
    activity.hidden = TRUE;
}

@end
