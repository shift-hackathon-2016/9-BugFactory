#import <Foundation/Foundation.h>

@protocol CEJSONMappable <NSObject>

+ (nullable id)objectWithJSON:(nonnull NSDictionary *)JSON error:(NSError * _Nullable __autoreleasing * _Nullable)error;

@optional
+ (BOOL)validateJSONObject:(nonnull NSDictionary *)JSON;
- (nullable id)HTTPRequestJSONPresentation;

@end
