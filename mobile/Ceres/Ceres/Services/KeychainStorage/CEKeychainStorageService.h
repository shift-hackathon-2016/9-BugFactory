#import <Foundation/Foundation.h>

@protocol CEKeychainStorageService <NSObject>

- (nullable id)objectForKey:(nonnull NSString *)key error:(NSError *__autoreleasing  _Nullable * _Nullable)error;
- (void)storeObject:(nonnull id)object forKey:(nonnull NSString *)key inService:(nullable NSString *)service error:(NSError * _Nullable __autoreleasing * _Nullable)error;
- (void)deleteObjectForKey:(nonnull NSString *)key error:(NSError * _Nullable __autoreleasing * _Nullable)error;
- (void)deleteAllObjects:(NSError * _Nullable __autoreleasing * _Nullable)error;

@end
