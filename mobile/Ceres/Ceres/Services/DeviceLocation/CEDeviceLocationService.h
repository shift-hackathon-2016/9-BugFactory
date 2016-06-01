#import <Foundation/Foundation.h>

@protocol CEDeviceLocationService <NSObject>

- (nonnull RACSignal *)currentDeviceLocation;

@end
