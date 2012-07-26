//
//  ExternalViewController.h
//  JS_Ios
//
//  Created by apple on 25.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDURLCache.h"

@interface ExternalViewController : UIViewController <UIWebViewDelegate>
{
    BOOL _loading;
    NSTimer *_timer;
    float _count;
    NSString *_state;
}

@property (nonatomic, retain) UIActivityIndicatorView *av;

@end
