#import <Foundation/Foundation.h>

@interface CEUserAuthenticationUseCase : NSObject

- (nonnull RACSignal *)authenticateWithEmail:(nonnull NSString *)email password:(nonnull NSString *)password;

@end
