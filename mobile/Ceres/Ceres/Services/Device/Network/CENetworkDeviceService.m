#import "CENetworkDeviceService.h"

@implementation CENetworkDeviceService

- (RACSignal *)registerDevice
{
    NSDictionary *parameters = @{
                                 @"udid": [CEDevice currentDevice].UUID.UUIDString,
                                 @"name": [CEDevice currentDevice].name,
                                 @"notifications_token": [
                                 };
    
    return [[self.APIClient PATCH:@"device/register" parameters:parameters] tryMap:^id(RACTuple *tuple, NSError *__autoreleasing *errorPtr) {
        return tuple.second;
    }];
}

@end
