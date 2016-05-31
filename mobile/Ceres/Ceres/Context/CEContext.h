#import <Foundation/Foundation.h>

#import "CEAuthenticationService.h"
#import "CEKeychainStorageService.h"
#import "CEPushNotificationService.h"
#import "CENotificationService.h"
#import "CEDeviceService.h"
#import "CENavigationService.h"

#import "CEDeviceUDIDProvider.h"
#import "CEDeviceNotificationsTokenProvider.h"
#import "CENavigationProvider.h"

@interface CEContext : NSObject

//services
@property (strong, nonatomic, nonnull) id <CEAuthenticationService> authenticationService;
@property (strong, nonatomic, nonnull) id <CEKeychainStorageService> keychainStorageService;
@property (strong, nonatomic, nonnull) id <CEPushNotificationService> pushNotificationService;
@property (strong, nonatomic, nonnull) id <CEDeviceService> deviceService;
@property (strong, nonatomic, nonnull) id <CENotificationService> notificationService;
@property (strong, nonatomic, nonnull) id <CENavigationService> navigationService;

//providers
@property (strong, nonatomic, nonnull) id <CEDeviceUDIDProvider> deviceUDIDProvider;
@property (strong, nonatomic, nonnull) id <CEDeviceNotificationsTokenProvider> deviceNotificationsTokenProvider;
@property (strong, nonatomic, nonnull) id <CENavigationProvider> navigationProvider;

+ (nonnull instancetype)defaultContext;

@end
