//
//  ExternalViewController.m
//  JS_Ios
//
//  Created by apple on 25.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExternalViewController.h"

@interface ExternalViewController ()

@end

static int TAG_WEB_VIEW = 10;
static int TAG_AIND = 11;
static int TAG_BOTTOM = 12;

@implementation ExternalViewController

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
    
    [[self navigationController].navigationBar setHidden:NO];
    self.navigationItem.title = @"Caching Demo"; 
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem =
	[[UIBarButtonItem alloc] initWithTitle:@"Back"
									 style:UIBarButtonItemStyleBordered
									target:self
									action:@selector(handleBack:)];

    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float tabheight = self.navigationController.navigationBar.frame.size.height;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height - 50 - tabheight)];
    //    webView.scalesPageToFit = YES;
    webView.tag = TAG_WEB_VIEW;
	webView.delegate = self;
    [self.view addSubview:webView];
    
    UISegmentedControl *bottomMenu = [[UISegmentedControl alloc] initWithItems:
									  [NSArray arrayWithObjects:@"URL", @"Local", @"Pre-Defined", @"Clear", nil]
									  ];
	[bottomMenu addTarget:self action:@selector(menuClicked:) forControlEvents:UIControlEventValueChanged];
	bottomMenu.momentary = YES;
    bottomMenu.tag = TAG_BOTTOM;
	bottomMenu.segmentedControlStyle = UISegmentedControlStyleBar;
	bottomMenu.frame = CGRectMake(0, screenRect.size.height - 70.0f - tabheight, screenRect.size.width, 50.0f);
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

-(void)resetWebView
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float tabheight = self.navigationController.navigationBar.frame.size.height;
    
    UIWebView *wv = (UIWebView*)[self.view viewWithTag:TAG_WEB_VIEW];
    {
        if (wv != nil) {
            [wv removeFromSuperview];
        }
    }
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height - 50 - tabheight)];
    //    webView.scalesPageToFit = YES;
    webView.tag = TAG_WEB_VIEW;
	webView.delegate = self;
    
    [self.view addSubview:webView];

    UISegmentedControl *bottomMenu = (UISegmentedControl *)[self.view viewWithTag:TAG_BOTTOM];
    [self.view bringSubviewToFront:bottomMenu];
}

-(IBAction)handleBack:(id)sender
{
    [[self navigationController].navigationBar setHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)menuClicked:(id)sender
{
    if (_loading==YES) {
        return;
    }
    
    //    [[NSURLCache sharedURLCache] removeAllCachedResponses];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self resetWebView];
    UISegmentedControl *sc = (UISegmentedControl *)sender;
    UIWebView *webView = (UIWebView *)[self.view viewWithTag:TAG_WEB_VIEW];
    [webView setHidden:NO];
    
    NSString *url = @"http://flashtest.oscdev.com/testimg/";
    
	if (sc.selectedSegmentIndex==0) {
        _state = STATE_EXT;
        url = [url stringByAppendingString:@"test2.html"];
//        url = [@"http://wavii.com/" stringByAppendingString:@""];
    }
    else if (sc.selectedSegmentIndex==1) {
        
        _state = STATE_LOCAL;
//        url = [url stringByAppendingString:URL_CSS];
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString *path = [documentsDirectory stringByAppendingPathComponent:URL_CSS];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:[URL_CSS stringByDeletingPathExtension]
                                                         ofType:[URL_CSS pathExtension]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path] cachePolicy: NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
        [webView loadRequest:request];
        return;
    }
    else if (sc.selectedSegmentIndex==2) {
        UIWebView *webView = (UIWebView *)[self.view viewWithTag:TAG_WEB_VIEW];
        _state = STATE_PREDEFINED;
        url = [@"http://myserver.com/" stringByAppendingString:@"index.html"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy: NSURLRequestReturnCacheDataDontLoad timeoutInterval:60];
        [webView loadRequest:request];
        return;
    }
    else if (sc.selectedSegmentIndex==3) {
        [(SDURLCache*)[NSURLCache sharedURLCache] removeAllCachedResponses];

        self.view.backgroundColor = [UIColor blackColor];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Local Cache Cleared" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        [self resetWebView];
        UIWebView *webView = (UIWebView *)[self.view viewWithTag:TAG_WEB_VIEW];
        [webView setHidden:YES];

        return;
    }
    
    if (![url isEqualToString:@""]) {
        
        UIWebView *webView = (UIWebView *)[self.view viewWithTag:TAG_WEB_VIEW];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy: NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
        [webView loadRequest:request];
    }
    
}

-(void) startTimer
{
    _count = 0.0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.0001 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
}

-(void)onTick:(NSTimer *)timer {
    _count += 0.0001;
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
    
    NSLog(@"load time=%.4f", _count);
    
	UIActivityIndicatorView *tmpimg = (UIActivityIndicatorView *)[webView viewWithTag:TAG_AIND];
	[tmpimg removeFromSuperview];
    
    NSString *used = [CGlobals shared].useCache ? @"YES" : @"NO";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Web loading" message:[NSString stringWithFormat:@"%@.\nLoading time: %.4f\nUse SDURLCache data: %@", _state, _count, used] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    _state = @"";
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error = %@", [error description]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Error: %@", [error description]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    _state = @"";
}

- (void)dealloc {
    [super dealloc];
}


@end
