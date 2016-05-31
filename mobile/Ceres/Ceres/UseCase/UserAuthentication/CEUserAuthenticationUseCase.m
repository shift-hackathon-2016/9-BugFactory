#import "CEUserAuthenticationUseCase.h"

@interface CEUserAuthenticationUseCase ()

@property (strong, nonatomic, nonnull) id <CEAuthenticationService> authenticationService;

@end

@implementation CEUserAuthenticationUseCase

- (RACSignal *)authenticateWithEmail:(NSString *)email password:(NSString *)password
{
    return [[self.authenticationService authenticateWithEmail:email password:password] map:^id(id value) {
        return nil;
    }];
}

#pragma mark - Properties

- (id<CEAuthenticationService>)authenticationService
{
    return [CEContext defaultContext].authenticationService;
}

@end
