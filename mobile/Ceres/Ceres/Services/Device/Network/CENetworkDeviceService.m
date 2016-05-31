#import "CENetworkDeviceService.h"

@interface CENetworkDeviceService ()

@property (strong, nonatomic, nonnull) id <CEDeviceNotificationsTokenProvider> deviceNotificationsTokenProvider;

@end

@implementation CENetworkDeviceService

- (RACSignal *)registerDevice
{
    NSString *notificationsToken = [self.deviceNotificationsTokenProvider currentDeviceNotificationsToken];
    
    CEDevice *currentDevice = [CEDevice currentDevice];
    
    NSDictionary *parameters = @{
                                 @"udid": currentDevice.UUID.UUIDString,
                                 @"name": currentDevice.name,
                                 @"notifications_token": notificationsToken ? notificationsToken : [NSNull null]
                                 };
    
    return [[self.APIClient POST:@"devices/create" parameters:parameters] tryMap:^id(RACTuple *tuple, NSError *__autoreleasing *errorPtr) {
        return tuple.second;
    }];
}
                                                          
#pragma mark - Properties

- (id<CEDeviceNotificationsTokenProvider>)deviceNotificationsTokenProvider
{
    return [CEContext defaultContext].deviceNotificationsTokenProvider;
}

@end
