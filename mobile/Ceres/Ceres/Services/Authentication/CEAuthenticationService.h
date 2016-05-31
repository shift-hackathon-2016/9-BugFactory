#import <Foundation/Foundation.h>

@protocol CEAuthenticationService <NSObject>

- (nonnull RACSignal *)authenticateWithEmail:(nonnull NSString *)email password:(nonnull NSString *)password;

@end
