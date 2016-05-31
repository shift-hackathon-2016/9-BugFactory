#import <Foundation/Foundation.h>

@interface CENotificationsUseCase : NSObject

- (nonnull RACSignal *)presentNotifications;

@end
