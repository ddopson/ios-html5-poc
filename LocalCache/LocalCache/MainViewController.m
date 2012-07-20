//
//  MainViewController.m
//  LocalCache
//
//  Created by apple on 20.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

static int TAG_WEB_VIEW = 10;
static int TAG_AIND = 11;

@implementation MainViewController

@synthesize av, request;

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

- (void)dealloc {
    [super dealloc];
}

#pragma Custom functions

-(IBAction)menuClicked:(id)sender
{
    if (_loading==YES) {
        return;
    }
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    UISegmentedControl *sc = (UISegmentedControl *)sender;
    
    [self startTimer];
    
	if (sc.selectedSegmentIndex==0) {
        _state = STATE_IMG;
        NSURL *url = [NSURL URLWithString:URL_IMG];
        [self loadURL:url];
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL_IMG] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
//        [webView loadRequest:request];
    }
    else if (sc.selectedSegmentIndex==1) {
        _state = STATE_CSS;
        NSURL *url = [NSURL URLWithString:URL_CSS];
        [self loadURL:url];
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL_CSS] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
//        [webView loadRequest:request];
    }
    else if (sc.selectedSegmentIndex==2) {
        _state = STATE_IMG64;
        NSURL *url = [NSURL URLWithString:URL_IMG64];
        [self loadURL:url];
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL_IMG64] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
//        [webView loadRequest:request];
    }
    else if (sc.selectedSegmentIndex==3) {
        _state = STATE_CSS64;
        NSURL *url = [NSURL URLWithString:URL_CSS64];
        [self loadURL:url];
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL_CSS64] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
//        [webView loadRequest:request];
    }
    
}

-(void) startTimer
{
    _count = 0.0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
}

-(void)onTick:(NSTimer *)timer {
    _count += 0.001;
    //    NSLog(@"%.2f", _count);
}

#pragma ASIHTTPRequest

- (IBAction)loadURL:(NSURL *)url
{
    // Again, make sure we cancel any in-progress page load first
    [[self request] setDelegate:nil];
    [[self request] cancel];
    
    [self setRequest:[ASIWebPageRequest requestWithURL:url]];
    [[self request] setDelegate:self];
    [[self request] setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [[self request] setDidFailSelector:@selector(webPageFetchFailed:)];
    [[self request] setDidFinishSelector:@selector(webPageFetchSucceeded:)];
    
    // Tell the request to replace urls in this page with local urls
    [[self request] setUrlReplacementMode:ASIReplaceExternalResourcesWithLocalURLs];
    
    // As before, tell the request to use our download cache
    [[self request] setDownloadCache:[ASIDownloadCache sharedCache]];
    [[self request] setDownloadDestinationPath:
     [[ASIDownloadCache sharedCache] pathToStoreCachedResponseDataForRequest:[self request]]];
    
    [[self request] startAsynchronous];
}

- (void)webPageFetchFailed:(ASIHTTPRequest *)theRequest
{
    // Make sure you handle this error properly...
    NSLog(@"%@",[theRequest error]);
}

- (void)webPageFetchSucceeded:(ASIHTTPRequest *)theRequest
{
    // The page has been downloaded with all external resources. Now, we'll load it into our UIWebView.
    // This time, we're telling our web view to load the file on disk directly.
    UIWebView *webView = (UIWebView *)[self.view viewWithTag:TAG_WEB_VIEW];
    [webView loadRequest:
     [NSURLRequest requestWithURL:[NSURL fileURLWithPath:[theRequest downloadDestinationPath]]]];
    
}

// We've set our controller to be the delegate of our web view
// When a user clicks on a link, we'll handle loading with ASIWebPageRequest
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)theRequest 
 navigationType:(UIWebViewNavigationType)navigationType
{
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		[self loadURL:[theRequest URL]];
		return NO;
	}
	return YES;
}

#pragma UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	NSLog(@" started");
    
    _loading=YES;
    
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
    
    NSLog(@"load time=%.3f", _count);
    
    //    NSString *script = @"var n = document.images.length; var names = [];"
    //    "for (var i = 0; i < n; i++) {"
    //    "     names.push(document.images[i].src);"
    //    "} String(names);";
    //    NSString *imgUrls = [webView stringByEvaluatingJavaScriptFromString:script];
    //    
    //    NSLog(@"%@", imgUrls);
    
	UIActivityIndicatorView *tmpimg = (UIActivityIndicatorView *)[webView viewWithTag:TAG_AIND];
	[tmpimg removeFromSuperview];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Web loading" message:[NSString stringWithFormat:@"%@.\nLoading time: %.3f", _state, _count] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    _state = @"";
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
}


@end
