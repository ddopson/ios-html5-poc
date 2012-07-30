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
    
    /*
    NSString *directory = [SDURLCache defaultCachePath];
    BOOL isDir;
    NSFileManager *fileManager= [NSFileManager defaultManager]; 
    if(![fileManager fileExistsAtPath:directory isDirectory:&isDir])
        if(![fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:NULL])
            NSLog(@"Error: Create folder failed %@", directory);
     */
    
    [CGlobals shared].substitutionPaths = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"foo", @"myserver.com",
                                           nil];
    
    [self copyResources];
    
    SDURLCache *urlCache = [[SDURLCache alloc] initWithMemoryCapacity:1024*1024   // 1MB mem cache
                                                        diskCapacity:1024*1024*5 // 5MB disk cache
                                                        diskPath:[SDURLCache defaultCachePath]];
    urlCache.minCacheInterval = 60 * 60;
    urlCache.ignoreMemoryOnlyStoragePolicy = YES;
    
    //[NSURLCache setSharedURLCache:urlCache];
//    [urlCache release];
    
    navcontroller = [[UINavigationController alloc] init];
    _window.rootViewController = navcontroller;
    
    MenuViewController *maincontroller = [[MenuViewController alloc] init];
    [navcontroller pushViewController:maincontroller animated:YES];
    [maincontroller release];
    
    [self.window makeKeyAndVisible];
    return YES;
}

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
    /*
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
     */
}

- (void)copyResources {
    
//    [self deleteFiles];
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *documentsDirectory = [paths objectAtIndex:0];
//    
//    [CGlobals shared].docDurectory = [NSString stringWithString:documentsDirectory];
//    
//    NSString *directory = [documentsDirectory stringByAppendingPathComponent:@"foo"];
//    BOOL isDir;
//    NSFileManager *fileManager= [NSFileManager defaultManager]; 
//    if(![fileManager fileExistsAtPath:directory isDirectory:&isDir])
//    {
//        if(![fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:NULL])
//        {
//            NSLog(@"Error: Create folder failed %@", directory);
//        }
//    }
//
//    
//    NSArray *files_to_transfer = [NSArray arrayWithObjects:@"test1.html", @"test2.html", @"test3.html", @"test4.html", @"img.png", @"img1.png", @"style.css", nil];
//
//    NSArray *subst_files_to_transfer = [NSArray arrayWithObjects:
//                                        @"wavii_cached/airbrake__io__javascripts__notifier__js",
//                                        @"wavii_cached/api__mixpanel__com__site_media__js__api__mixpanel__2__js",
//                                        @"wavii_cached/discover__partials__sidebar",
//                                        @"wavii_cached/fbcdn-profile-a__akamaihd__net__hprofile-ak-ash2__370444_710368646_306542019_q__jpg",
//                                        @"wavii_cached/fbcdn-profile-a__akamaihd__net__hprofile-ak-ash2__371682_100001415462474_523049223_q__jpg",
//                                        @"wavii_cached/fbcdn-profile-a__akamaihd__net__hprofile-ak-ash2__572164_100002570961683_1643047576_q__jpg",
//                                        @"wavii_cached/fbcdn-profile-a__akamaihd__net__hprofile-ak-snc4__186389_780440798_1681737189_q__jpg",
//                                        @"wavii_cached/fbcdn-profile-a__akamaihd__net__hprofile-ak-snc4__275571_3401897_3337722_q__jpg",
//                                        @"wavii_cached/fbcdn-profile-a__akamaihd__net__hprofile-ak-snc4__41672_701998_3924_n__jpg",
//                                        @"wavii_cached/fbcdn-profile-a__akamaihd__net__hprofile-ak-snc4__41672_701998_3924_q__jpg",
//                                        @"wavii_cached/fbcdn-profile-a__akamaihd__net__hprofile-ak-snc4__49225_560627797_6756_q__jpg",
//                                        @"wavii_cached/fbcdn-profile-a__akamaihd__net__hprofile-ak-snc4__49741_10733492_804955410_q__jpg",
//                                        @"wavii_cached/graph__facebook__com__100001415462474__picture",
//                                        @"wavii_cached/graph__facebook__com__100002570961683__picture",
//                                        @"wavii_cached/graph__facebook__com__10733492__picture",
//                                        @"wavii_cached/graph__facebook__com__3401897__picture",
//                                        @"wavii_cached/graph__facebook__com__4804650__picture",
//                                        @"wavii_cached/graph__facebook__com__560627797__picture",
//                                        @"wavii_cached/graph__facebook__com__651531071__picture",
//                                        @"wavii_cached/graph__facebook__com__701998__picture",
//                                        @"wavii_cached/graph__facebook__com__710368646__picture",
//                                        @"wavii_cached/graph__facebook__com__780440798__picture",
//                                        @"wavii_cached/graph__facebook__com__795720561__picture",
//                                        @"wavii_cached/index__html",
//                                        @"wavii_cached/partials__feed",
//                                        @"wavii_cached/partials__notifications",
//                                        @"wavii_cached/profile__dave-dopson__index__html",
//                                        @"wavii_cached/profile__dave-dopson__topic_follows",
//                                        @"wavii_cached/profile__dave-dopson__user_followers",
//                                        @"wavii_cached/settings",
//                                        @"wavii_cached/static__chartbeat__com__js__chartbeat__js",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__article__7SLM1__083cdae1313fd960093d07ce8bea573c__orig__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__article__j2fs9__627048de541fb6731b58474fde7f10f4__orig__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__article__j8VhE__634e62d079c153d2001b015ac9b095c2__w600__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__article__jDhmM__b9907afd94e7d5f11c8c9d24de11ad4b__w600__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__article__jE94w__1461fdd8eabed361518d04b7f14a7840__orig__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__article__nr6Bu__96aca90ed9150feaf9c04f3c472863eb__w400__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__article__ntNSJ__12f30f9b3ca996ea158cc7cde4854ba0__orig__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__topic__4Fdj__70532768ebcb69f9ddaf0f015c3adbdd__w200__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__topic__4XDP__7ee540a80b9eb49adec734093383fa6a__w200__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__topic__5Qgw__778674c09e78e0457e8df3c86e9ebc85__w200__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__topic__7gCW__1ea1715a3fde1bdbc44c34139604c00d__w200__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__topic__A6h6__4d9193c891fb32fcec5395a2ff8f5b61__w200__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__topic__AM29__5f7c86e50d698192f9cd1cba691703ee__w200__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__topic__BWel__7164526b36fad57a30cbb9f711e4f493__w200__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__topic__JmdR__d8d66a72df25f0d02cda7a05e2aa23aa__w200__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__topic__NdDV__810ef493cff6b42a80ff6f0eff75657d__orig__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__topic__W7tQ__f51ccd19b8a1b47113c39a9034896ecd__w200__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__topic__YuPE__b08bb2abbedc2bb3b99da004f639ef91__w200__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__topic__e9Uo__d7ec88789d3f531a77404cf846ceb5b7__orig__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__topic__j9AZ__bdd4c99b6ec3ae9a3fdaac21e23b18c1__w200__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__topic__kpp1__cff2213d95cc30db05388c560a543bcc__w200__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__topic__nM4A__0704e88f49f5165bcfaef8f921fbe54a__w200__jpg",
//                                        @"wavii_cached/wavii-images__s3__amazonaws__com__topic__xpnH__8174d38ff50b0045dc1d9f37dfcd0bb5__w200__jpg",
//                                        @"wavii_cached/wavii__s3__amazonaws__com__370e168bd471ee67f7fc1eeeb26a5e22ae518437__assets__base__js",
//                                        @"wavii_cached/wavii__s3__amazonaws__com__370e168bd471ee67f7fc1eeeb26a5e22ae518437__assets__desktop__css",
//                                        @"wavii_cached/wavii__s3__amazonaws__com__370e168bd471ee67f7fc1eeeb26a5e22ae518437__assets__favicon__png",
//                                        @"wavii_cached/wavii__s3__amazonaws__com__8e9c50ff982ccbd0ef1387e7568ed10103365862__assets__base__js",
//                                        @"wavii_cached/wavii__s3__amazonaws__com__8e9c50ff982ccbd0ef1387e7568ed10103365862__assets__desktop__css",
//                                        @"wavii_cached/wavii__s3__amazonaws__com__8e9c50ff982ccbd0ef1387e7568ed10103365862__assets__favicon__png",
//                                        @"wavii_cached/wavii__s3__amazonaws__com__d5a32bed03e989f186c5bfa40efd0d6dd1dbaf64__assets__base__js",
//                                        @"wavii_cached/wavii__s3__amazonaws__com__d5a32bed03e989f186c5bfa40efd0d6dd1dbaf64__assets__desktop__css",
//                                        @"wavii_cached/wavii__s3__amazonaws__com__d5a32bed03e989f186c5bfa40efd0d6dd1dbaf64__assets__favicon__png",
//                                        @"wavii_cached/www__google-analytics__com__ga__js",
//                                        nil
//                                        ];
//        
//    NSString *sourcePath = [[NSBundle mainBundle] resourcePath];
//    NSString *destPath = [NSString stringWithString:documentsDirectory];
//    
//    for (NSString* file in subst_files_to_transfer){
//        NSError* error;
//        NSLog(@"Copying '%@'", file);
//
//        NSString *src =  [sourcePath stringByAppendingPathComponent:file];
//        NSString *dest = [destPath stringByAppendingPathComponent:file];
//        
//        if (![[NSFileManager defaultManager] 
//              copyItemAtPath: src
//              toPath: dest
//              error:&error]) {
//            NSLog(@"Error: %@", error);
//        }
//        
//    }
}


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
