//
//  CGlobals.h
//  JS_Ios
//
//  Created by apple on 25.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGlobals : NSObject
{
    
}

@property BOOL useCache;

+ (CGlobals *) shared;

@end
