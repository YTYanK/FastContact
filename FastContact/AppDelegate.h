//
//  AppDelegate.h
//  FastContact
//
//  Created by YTYanK on 17/1/9.
//  Copyright © 2017年 YTYanK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong, nonatomic) AMapLocationManager *locationManager;

- (void)saveContext;


@end

