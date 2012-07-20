//
//  MainViewController.h
//  LocalCache
//
//  Created by apple on 20.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIWebPageRequest.h"
#import "ASIDownloadCache.h"

@interface MainViewController : UIViewController <UIWebViewDelegate>
{
    BOOL _loading;
    NSTimer *_timer;
    float _count;
    NSString *_state;
}

@property (nonatomic, retain) UIActivityIndicatorView *av;
@property (nonatomic, retain) ASIHTTPRequest *request;

@end
