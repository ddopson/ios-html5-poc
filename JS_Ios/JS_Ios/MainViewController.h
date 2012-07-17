//
//  MainViewController.h
//  JS_Ios
//
//  Created by apple on 17.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface MainViewController : UIViewController <UIWebViewDelegate>
{
    BOOL _loading;
}

@property (nonatomic, retain) UIActivityIndicatorView *av;

@end
