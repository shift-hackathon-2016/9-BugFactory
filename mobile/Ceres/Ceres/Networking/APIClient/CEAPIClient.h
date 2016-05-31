#import <Foundation/Foundation.h>

@interface CEAPIClient : NSObject

+ (nonnull instancetype)resourceClient;

- (nonnull RACSignal *)GET:(nonnull NSString *)path parameters:(nullable id)parameters;
- (nonnull RACSignal *)POST:(nonnull NSString *)path parameters:(nullable id)parameters;
- (nonnull RACSignal *)PUT:(nonnull NSString *)path parameters:(nullable id)parameters;
- (nonnull RACSignal *)PATCH:(nonnull NSString *)path parameters:(nullable id)parameters;
- (nonnull RACSignal *)DELETE:(nonnull NSString *)path parameters:(nullable id)parameters;
- (nonnull RACSignal *)HEAD:(nonnull NSString *)path parameters:(nullable id)parameters;

@end
