#import "AppDelegate.h"

#import "CERootViewController.h"

@interface AppDelegate ()

@property (strong, nonatomic, nonnull) __kindof UIViewController *rootViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self.window makeKeyAndVisible];
    
    id <CENavigationProvider> provider = [CEContext defaultContext].navigationProvider;
    provider.rootViewController = self.rootViewController;
    
    [GMSServices provideAPIKey:@"AIzaSyAL2p_LdOCKKbQNl9L6yv-NxqFxmFJdFn0"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Properties

- (UIWindow *)window
{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _window.rootViewController = self.rootViewController;
    }
    
    return _window;
}

- (UIViewController *)rootViewController
{
    if (!_rootViewController) {
        _rootViewController = [CERootViewController new];
    }
    
    return _rootViewController;
}

@end
