#import <Foundation/Foundation.h>

@protocol CEPushNotificationService <NSObject>

- (nonnull RACSignal *)registerDeviceToPushNotifications;

@end
