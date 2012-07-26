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
@property (retain, nonatomic) NSMutableDictionary *substitutionPaths;
@property (retain, nonatomic) NSString *docDurectory;

+ (CGlobals *) shared;

@end
