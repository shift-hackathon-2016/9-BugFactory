#import "CENetworkNotificationService.h"

#import "CENotification+CEJSONMappable.h"

@implementation CENetworkNotificationService

- (RACSignal *)userNotifications
{
    return [[self.APIClient GET:@"notifications" parameters:nil] tryMap:^id(RACTuple *tuple, NSError *__autoreleasing *errorPtr) {
        NSArray *JSON = tuple.second;
        
        return [JSON map:^id(NSDictionary *notificationJSON) {
            return [CENotification objectWithJSON:notificationJSON error:errorPtr];
        }];
    }];
}

@end
