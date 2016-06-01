#import <Foundation/Foundation.h>

@protocol CENotificationService <NSObject>

- (nonnull RACSignal *)userNotifications;

@end
