#import "CEUserAuthenticationUseCase.h"

@interface CEUserAuthenticationUseCase ()

@property (strong, nonatomic, nonnull) id <CEAuthenticationService> authenticationService;
@property (strong, nonatomic, nonnull) id <CEPushNotificationService> pushNotificationService;
@property (strong, nonatomic, nonnull) id <CEDeviceService> deviceService;
@property (strong, nonatomic, nonnull) id <CENavigationService> navigationService;

@end

@implementation CEUserAuthenticationUseCase

- (RACSignal *)authenticateWithEmail:(NSString *)email password:(NSString *)password
{
    return [[[self.authenticationService authenticateWithEmail:email password:password] map:^id(id value) {
        return nil;
    }] doNext:^(id x) {
        [self.navigationService openRoute:@"home" params:nil navigationType:CENavigationTypeModal completion:^(UIViewController * _Nullable viewController, NSError * _Nullable error) {
            
        }];
    }];
}

- (RACSignal *)registerDeviceToPushNotifications
{
    @weakify(self);
    return [[[self.pushNotificationService registerDeviceToPushNotifications] flattenMap:^RACStream *(id value) {
        @strongify(self);
        return [self.deviceService registerDevice];
    }] map:^id(id value) {
        return nil;
    }];
}

#pragma mark - Properties

- (id<CEAuthenticationService>)authenticationService
{
    return [CEContext defaultContext].authenticationService;
}

- (id<CEPushNotificationService>)pushNotificationService
{
    return [CEContext defaultContext].pushNotificationService;
}

- (id<CEDeviceService>)deviceService
{
    return [CEContext defaultContext].deviceService;
}

- (id<CENavigationService>)navigationService
{
    return [CEContext defaultContext].navigationService;
}
@end
