#import "CENetworkAuthenticationService.h"

#import "CEUser+CEJSONMappable.h"

@implementation CENetworkAuthenticationService

- (RACSignal *)authenticateWithEmail:(NSString *)email password:(NSString *)password
{
    NSDictionary *parameters = @{
                                 @"email":email,
                                 @"password":password
                                 };
    
    return [[self.APIClient POST:@"/auth/login" parameters:parameters] tryMap:^id(RACTuple *tuple, NSError *__autoreleasing *errorPtr) {
        NSDictionary *JSON = tuple.second;
        return [CEUser objectWithJSON:JSON error:errorPtr];
    }];
}

@end
