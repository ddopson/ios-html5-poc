//
//  MainViewController.m
//  JS_Ios
//
//  Created by apple on 17.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

static int TAG_WEB_VIEW = 10;
static int TAG_AIND = 11;

@implementation MainViewController

@synthesize av;

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
    
    _loading = NO;
    
	[[self navigationController].navigationBar setHidden:YES];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height - 50)];
//    webView.scalesPageToFit = YES;
    webView.tag = TAG_WEB_VIEW;
	webView.delegate = self;
    [self.view addSubview:webView];

    UISegmentedControl *bottomMenu = [[UISegmentedControl alloc] initWithItems:
									  [NSArray arrayWithObjects:@"Img", @"CSS", @"Img-64", @"CSS-64", nil]
									  ];
	[bottomMenu addTarget:self action:@selector(menuClicked:) forControlEvents:UIControlEventValueChanged];
	bottomMenu.momentary = YES;
	bottomMenu.frame = CGRectMake(0, screenRect.size.height - 70.0f, screenRect.size.width, 50.0f);
	[self.view addSubview:bottomMenu];

    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma Custom functions

-(IBAction)menuClicked:(id)sender
{
    if (_loading==YES) {
        return;
    }

    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    UISegmentedControl *sc = (UISegmentedControl *)sender;
    UIWebView *webView = (UIWebView *)[self.view viewWithTag:TAG_WEB_VIEW];
    
	if (sc.selectedSegmentIndex==0) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL_IMG] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
        [webView loadRequest:request];
    }
    else if (sc.selectedSegmentIndex==1) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL_CSS] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
        [webView loadRequest:request];
    }
    else if (sc.selectedSegmentIndex==2) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL_IMG64] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
        [webView loadRequest:request];
    }
    else if (sc.selectedSegmentIndex==3) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL_CSS64] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
        [webView loadRequest:request];
    }

}

-(void) startTimer
{
    _count = 0.0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
}

-(void)onTick:(NSTimer *)timer {
    _count += 0.01;
//    NSLog(@"%.2f", _count);
}

#pragma UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	NSLog(@" started");
    
    _loading=YES;
    
    [self startTimer];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
	av = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle
          :UIActivityIndicatorViewStyleWhiteLarge];
	av.frame=CGRectMake(screenRect.size.width/2-25, screenRect.size.height/2-25, 50, 50);
	av.tag  = TAG_AIND;
	[webView addSubview:av];
	[av startAnimating];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	NSLog(@"Finish Launching");

    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }

    _loading = NO;
    
    NSLog(@"load time=%.2f", _count);

	UIActivityIndicatorView *tmpimg = (UIActivityIndicatorView *)[webView viewWithTag:TAG_AIND];
	[tmpimg removeFromSuperview];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
}

- (void)dealloc {
    [super dealloc];
}


@end
