//
//  MenuViewController.m
//  JS_Ios
//
//  Created by apple on 25.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

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
    [[self navigationController].navigationBar setHidden:YES];
//    self.navigationItem.title = @"Testing Cache"; 

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIButton *local = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    local.frame = CGRectMake(screenRect.size.width/2 - 100, screenRect.size.height/2 - 55, 200, 50);
    [local addTarget:self action:@selector(onLocalClick:) forControlEvents:UIControlEventTouchUpInside];
    [local setTitle:@"Resource Types Tests" forState:UIControlStateNormal];
    [self.view addSubview:local];
    
    UIButton *external = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    external.frame = CGRectMake(screenRect.size.width/2 - 100, screenRect.size.height/2 + 5, 200, 50);
    [external addTarget:self action:@selector(onExternalClick:) forControlEvents:UIControlEventTouchUpInside];
    [external setTitle:@"Comparative Tests" forState:UIControlStateNormal];
    [self.view addSubview:external];
    
//    UIButton *clear = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    clear.frame = CGRectMake(screenRect.size.width/2 - 100, screenRect.size.height - 100, 200, 50);
//    [clear addTarget:self action:@selector(onClearClick:) forControlEvents:UIControlEventTouchUpInside];
//    [clear setTitle:@"Clear Cache" forState:UIControlStateNormal];
//    [self.view addSubview:clear];

    
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

- (void) dealloc
{
    [super dealloc];
}

#pragma Custom

-(IBAction)onLocalClick:(id)sender
{
    MainViewController *controller = [[MainViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

-(IBAction)onExternalClick:(id)sender
{
    ExternalViewController *controller = [[ExternalViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

-(IBAction)onClearClick:(id)sender
{
    [(SDURLCache*)[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:[NSString stringWithString:@"Local Cache Cleared"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];

}

@end
