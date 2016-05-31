#import "CENetworkTaskService.h"

@implementation CENetworkTaskService

- (RACSignal *)tasksForCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSDictionary *parameters = @{};
    
    return [[self.APIClient GET:@"" parameters:parameters] tryMap:^id(RACTuple *tuple, NSError *__autoreleasing *errorPtr) {
        return nil;
    }];
}

@end
