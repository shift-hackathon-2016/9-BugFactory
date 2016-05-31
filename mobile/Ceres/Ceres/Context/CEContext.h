#import <Foundation/Foundation.h>

#import "CEAuthenticationService.h"
#import "CEKeychainStorageService.h"

#import "CEDeviceUDIDProvider.h"
#import "CEDeviceNotificationsTokenProvider.h"

@interface CEContext : NSObject

//services
@property (strong, nonatomic, nonnull) id <CEAuthenticationService> authenticationService;
@property (strong, nonatomic, nonnull) id <CEKeychainStorageService> keychainStorageService;

//providers
@property (strong, nonatomic, nonnull) id <CEDeviceUDIDProvider> deviceUDIDProvider;
@property (strong, nonatomic, nonnull) id <CEDeviceNotificationsTokenProvider> deviceNotificationsTokenProvider;

+ (nonnull instancetype)defaultContext;

@end
