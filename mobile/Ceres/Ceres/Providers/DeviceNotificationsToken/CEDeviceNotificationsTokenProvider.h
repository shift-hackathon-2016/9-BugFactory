#import <Foundation/Foundation.h>

@protocol CEDeviceNotificationsTokenProvider <NSObject>

- (nullable NSString *)currentDeviceNotificationsToken;
- (void)storeNotificationsToken:(nonnull NSString *)notificationsToken;

@end
