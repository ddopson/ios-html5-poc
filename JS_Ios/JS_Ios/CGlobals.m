//
//  CGlobals.m
//  JS_Ios
//
//  Created by apple on 25.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CGlobals.h"

static CGlobals *__instance = nil;

@implementation CGlobals

@synthesize useCache, substitutionPaths, docDurectory;

+ (CGlobals *) shared
{
    @synchronized(self) {
		if (nil == __instance) {
			__instance  = [[self alloc] init];
            
		}
	}
	// return the instance of this class
	return __instance;
    
}

+ (id)allocWithZone:(NSZone *)zone
{
	@synchronized(self) {
		
		if (__instance == nil) {
			
			__instance = [super allocWithZone:zone];
			return __instance;  // assignment and return on first allocation
		}
	}
	
	return nil; //on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

- (id)retain
{
	return self;
}

- (NSUInteger)retainCount
{
	return NSUIntegerMax;  //denotes an object that cannot be released
}

- (id)autorelease
{
	return self;
}

@end
