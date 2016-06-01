#import <Foundation/Foundation.h>

@protocol CEDeviceService <NSObject>

- (nonnull RACSignal *)registerDevice;

@end
