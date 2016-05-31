#import "CENetworkDeviceService.h"

@interface CENetworkDeviceService ()

@property (strong, nonatomic, nonnull) id <CEDeviceNotificationsTokenProvider> deviceNotificationsTokenProvider;

@end

@implementation CENetworkDeviceService

- (RACSignal *)registerDevice
{
    NSString *notificationsToken = [self.deviceNotificationsTokenProvider currentDeviceNotificationsToken];
    NSDictionary *parameters = @{
                                 @"udid": [CEDevice currentDevice].UUID.UUIDString,
                                 @"name": [CEDevice currentDevice].name,
                                 @"notifications_token": notificationsToken ? notificationsToken : [NSNull null]
                                 };
    
    return [[self.APIClient PATCH:@"device/register" parameters:parameters] tryMap:^id(RACTuple *tuple, NSError *__autoreleasing *errorPtr) {
        return tuple.second;
    }];
}
                                                          
#pragma mark - Properties

- (id<CEDeviceNotificationsTokenProvider>)deviceNotificationsTokenProvider
{
    return [CEContext defaultContext].deviceNotificationsTokenProvider;
}

@end
