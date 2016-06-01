#import "CELocalPushNotificationService.h"

#import "AppDelegate.h"

@interface CELocalPushNotificationService ()

@property (strong, nonatomic, nonnull) id <CEDeviceNotificationsTokenProvider> deviceNotificationsTokenProvider;

@end

@implementation CELocalPushNotificationService

- (RACSignal *)registerDeviceToPushNotifications
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    @weakify(self);
    
    RACSignal *didRegisterForRemoteNotificationsWithDeviceTokenSignal = [[appDelegate rac_signalForSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:) fromProtocol:@protocol(UIApplicationDelegate)] reduceEach:^id (UIApplication *application, NSData *deviceToken){
        @strongify(self);
        
        NSString *deviceTokenString = [self encodeDeviceToken:deviceToken];
        
        [self.deviceNotificationsTokenProvider storeNotificationsToken:deviceTokenString];
        
        return nil;
    }];
    
    RACSignal *didFailToRegisterForRemoteNotifications = [appDelegate rac_signalForSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:) fromProtocol:@protocol(UIApplicationDelegate)];
    
    [[appDelegate rac_signalForSelector:@selector(application:didRegisterUserNotificationSettings:) fromProtocol:@protocol(UIApplicationDelegate)] subscribeNext:^(id x) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[self notificationSettings]];
    
    return [[RACSignal merge:@[didRegisterForRemoteNotificationsWithDeviceTokenSignal, didFailToRegisterForRemoteNotifications]] map:^id(id value) {
        return nil;
    }];
}

#pragma mark - Private

- (NSString *)encodeDeviceToken:(NSData *)deviceToken
{
    NSString *tokenString = [[[NSString stringWithFormat:@"%@", deviceToken] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return tokenString;
}

- (UIUserNotificationSettings *)notificationSettings
{
    UIUserNotificationType types = (UIUserNotificationTypeAlert|
                                    UIUserNotificationTypeSound|
                                    UIUserNotificationTypeBadge);
    
    return [UIUserNotificationSettings settingsForTypes:types
                                             categories:nil];
}

#pragma mark - Properties

- (id<CEDeviceNotificationsTokenProvider>)deviceNotificationsTokenProvider
{
    return [CEContext defaultContext].deviceNotificationsTokenProvider;
}


@end
