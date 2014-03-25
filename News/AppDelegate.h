//
//  AppDelegate.h
//  News
//
//  Created by lanou3g on 14-3-3.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
@class Singleton;
@class MyTabBarViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate, WeiboSDKDelegate, UITabBarControllerDelegate, UIAlertViewDelegate,WBHttpRequestDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSString *wbtoken;
@property (nonatomic, retain)MyTabBarViewController * myTabVC;
@property (nonatomic, retain)Singleton * sing;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
+ (NSInteger)OSVersion;
@end
