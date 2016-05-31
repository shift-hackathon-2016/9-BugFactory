#import <Foundation/Foundation.h>

@protocol CEDeviceNotificationsTokenProvider <NSObject>

- (nullable NSString *)currentDeviceNotificationsToken;

@end
