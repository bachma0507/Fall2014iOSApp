//
//  ExamsViewController.m
//  Fall2013IOSApp
//
//  Created by Barry on 6/27/13.
//  Copyright (c) 2013 BICSI. All rights reserved.
//

#import "ExamsViewController.h"

@interface ExamsViewController ()

@end

@implementation ExamsViewController
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
	// Do any additional setup after loading the view.
    
    [TestFlight passCheckpoint:@"TrainingAndExams-info-viewed"];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    webView.delegate = self;
    
//    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"trainingExams.html" ofType:nil]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [webView loadRequest:request];
    
    NSString *httpSource = @"http://speedyreference.com/bicsiappcms/exams.html";
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
