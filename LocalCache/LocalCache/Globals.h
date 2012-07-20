//
//  Globals.h
//  LocalCache
//
//  Created by apple on 20.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globals : NSObject

@property (retain, nonatomic) NSMutableArray *substitutionPaths;

+ (Globals *) shared;

@end
