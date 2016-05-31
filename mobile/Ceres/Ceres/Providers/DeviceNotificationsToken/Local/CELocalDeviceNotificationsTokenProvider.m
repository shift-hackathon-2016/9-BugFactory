#import "CELocalDeviceNotificationsTokenProvider.h"

static NSString * const CEDeviceNotificationsTokenKeychainStorageKey = @"CEDeviceNotificationsTokenKeychainStorageKey";

@interface CELocalDeviceNotificationsTokenProvider ()

@property (strong, nonatomic, nonnull) id <CEKeychainStorageService> keychainStorageService;

@end

@implementation CELocalDeviceNotificationsTokenProvider

- (NSString *)currentDeviceNotificationsToken
{
    return [self.keychainStorageService objectForKey:CEDeviceNotificationsTokenKeychainStorageKey error:nil];
}

#pragma mark - Properties

- (id<CEKeychainStorageService>)keychainStorageService
{
    return [CEContext defaultContext].keychainStorageService;
}

@end
