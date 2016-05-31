#import "CELocalPushNotificationService.h"

#import "AppDelegate.h"

@implementation CELocalPushNotificationService

- (RACSignal *)registerDeviceToPushNotifications
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    @weakify(self);
    
    RACSignal *didRegisterForRemoteNotificationsWithDeviceTokenSignal = [[appDelegate rac_signalForSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:) fromProtocol:@protocol(UIApplicationDelegate)] reduceEach:^id (UIApplication *application, NSData *deviceToken){
        @strongify(self);
        
        return [self encodeDeviceToken:deviceToken];
    }];
    
    [[appDelegate rac_signalForSelector:@selector(application:didRegisterUserNotificationSettings:) fromProtocol:@protocol(UIApplicationDelegate)] subscribeNext:^(id x) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[self notificationSettings]];
    
    return didRegisterForRemoteNotificationsWithDeviceTokenSignal;
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


@end
