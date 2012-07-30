//
//  AppDelegate.m
//  JS_Ios
//
//  Created by apple on 17.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navcontroller;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

- (void)dealloc
{
    [_window release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [CGlobals shared].substitutionPaths = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"foo", @"myserver.com",
                                           nil];
    
//    [self copyResources];
    
    SDURLCache *urlCache = [[SDURLCache alloc] initWithMemoryCapacity:1024*1024   // 1MB mem cache
                                                        diskCapacity:1024*1024*5 // 5MB disk cache
                                                        diskPath:[SDURLCache defaultCachePath]];
    urlCache.minCacheInterval = 60 * 60;
    urlCache.ignoreMemoryOnlyStoragePolicy = YES;
    
    [NSURLCache setSharedURLCache:urlCache];
//    [urlCache release];
    
    navcontroller = [[UINavigationController alloc] init];
    _window.rootViewController = navcontroller;
    
    MenuViewController *maincontroller = [[MenuViewController alloc] init];
    [navcontroller pushViewController:maincontroller animated:YES];
    [maincontroller release];
    
    [self.window makeKeyAndVisible];
    return YES;
}

/*
- (void)deleteFiles
{
    NSFileManager *fileMgr = [[[NSFileManager alloc] init] autorelease];
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *directoryContents = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (error == nil) {
        for (NSString *path in directoryContents) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:path];
            BOOL removeSuccess = [fileMgr removeItemAtPath:fullPath error:&error];
            if (!removeSuccess) {
                // Error handling
            }
        }
    } else {
        // Error handling
    }    
    
    NSArray *fooContents = [fileMgr contentsOfDirectoryAtPath:[documentsDirectory stringByAppendingPathComponent:@"foo"] error:&error];
    if (error == nil) {
        for (NSString *path in fooContents) {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:path];
            BOOL removeSuccess = [fileMgr removeItemAtPath:fullPath error:&error];
            if (!removeSuccess) {
                // Error handling
            }
        }
    } else {
        // Error handling
    } 
     
}

- (void)copyResources {
    
    [self deleteFiles];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    
    [CGlobals shared].docDurectory = [NSString stringWithString:documentsDirectory];
    
    NSString *directory = [documentsDirectory stringByAppendingPathComponent:@"foo"];
    BOOL isDir;
    NSFileManager *fileManager= [NSFileManager defaultManager]; 
    if(![fileManager fileExistsAtPath:directory isDirectory:&isDir])
    {
        if(![fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:NULL])
        {
            NSLog(@"Error: Create folder failed %@", directory);
        }
    }

    
    NSArray *files_to_transfer = [NSArray arrayWithObjects:@"test1.html", @"test2.html", @"test3.html", @"test4.html", @"img.png", @"img1.png", @"style.css", nil];

    NSArray *subst_files_to_transfer = [NSArray arrayWithObjects:@"index.html", @"img1.png", @"style.css", nil];
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *sourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *destPath = [NSString stringWithString:documentsDirectory];//[documentsDirectory stringByAppendingPathComponent:@"includes"];
    
    NSArray* resContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sourcePath error:NULL];
    
    for (NSString* obj in resContents){
        NSError* error;
//        NSLog(@"name=%@", obj);
        
        if ([files_to_transfer containsObject:obj]) {
            
            NSString *deffile = [destPath stringByAppendingPathComponent:obj];
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:deffile];	
            if (!fileExists) {
                if (![[NSFileManager defaultManager] copyItemAtPath:[sourcePath stringByAppendingPathComponent:obj] toPath:[destPath stringByAppendingPathComponent:obj]
                                                              error:&error])
                    NSLog(@"Error: %@", error);
            }
        }
    }
    
    destPath = [NSString stringWithString:[documentsDirectory stringByAppendingPathComponent:@"foo"]];//[documentsDirectory 
    NSArray* subResContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sourcePath error:NULL];
    for (NSString* obj in subResContents){
        NSError* error;
        //        NSLog(@"name=%@", obj);
        
        if ([subst_files_to_transfer containsObject:obj]) {
            
            NSString *deffile = [destPath stringByAppendingPathComponent:obj];
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:deffile];	
            if (!fileExists) {
                if (![[NSFileManager defaultManager] copyItemAtPath:[sourcePath stringByAppendingPathComponent:obj] toPath:[destPath stringByAppendingPathComponent:obj]
                                                              error:&error])
                    NSLog(@"Error: %@", error);
            }
        }
    }

    
}
 
 */


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"JS_Ios" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"JS_Ios.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
