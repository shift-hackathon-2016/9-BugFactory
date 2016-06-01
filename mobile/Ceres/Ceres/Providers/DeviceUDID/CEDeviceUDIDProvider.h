#import <Foundation/Foundation.h>

@protocol CEDeviceUDIDProvider <NSObject>

- (nonnull NSUUID *)currentDeviceUDID;

@end
