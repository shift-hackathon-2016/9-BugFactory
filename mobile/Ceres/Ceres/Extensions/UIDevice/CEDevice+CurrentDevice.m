#import "CEDevice+CurrentDevice.h"

@implementation CEDevice (CurrentDevice)

+ (instancetype)currentDevice
{
    CEDevice *device = [CEDevice new];
    
    device.name = [UIDevice currentDevice].name;
    device.UUID = [[CEContext defaultContext].deviceUDIDProvider currentDeviceUDID];
    
    return device;
}

@end
