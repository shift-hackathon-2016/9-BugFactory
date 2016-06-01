#import <Foundation/Foundation.h>

typedef void (^CENetworkProgressBlock)(RACSignal *_Nonnull uploadProgress, RACSignal *_Nonnull downloadProgress);

@interface CEAPIClient : AFHTTPSessionManager

+ (nonnull instancetype)resourceClient;

- (nonnull RACSignal *)GET:(nonnull NSString *)path parameters:(nullable id)parameters;
- (nonnull RACSignal *)POST:(nonnull NSString *)path parameters:(nullable id)parameters;
- (nonnull RACSignal *)PUT:(nonnull NSString *)path parameters:(nullable id)parameters;
- (nonnull RACSignal *)PATCH:(nonnull NSString *)path parameters:(nullable id)parameters;
- (nonnull RACSignal *)DELETE:(nonnull NSString *)path parameters:(nullable id)parameters;
- (nonnull RACSignal *)HEAD:(nonnull NSString *)path parameters:(nullable id)parameters;

- (nonnull RACSignal *)GET:(nonnull NSString *)path parameters:(nullable id)parameters progress:(nullable CENetworkProgressBlock)progress;
- (nonnull RACSignal *)POST:(nonnull NSString *)path parameters:(nullable id)parameters progress:(nullable CENetworkProgressBlock)progress;
- (nonnull RACSignal *)PUT:(nonnull NSString *)path parameters:(nullable id)parameters progress:(nullable CENetworkProgressBlock)progress;
- (nonnull RACSignal *)PATCH:(nonnull NSString *)path parameters:(nullable id)parameters progress:(nullable CENetworkProgressBlock)progress;
- (nonnull RACSignal *)DELETE:(nonnull NSString *)path parameters:(nullable id)parameters progress:(nullable CENetworkProgressBlock)progress;
- (nonnull RACSignal *)HEAD:(nonnull NSString *)path parameters:(nullable id)parameters progress:(nullable CENetworkProgressBlock)progress;

@end
