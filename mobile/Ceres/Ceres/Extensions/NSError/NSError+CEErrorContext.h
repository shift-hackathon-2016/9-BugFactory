#import <Foundation/Foundation.h>

#import "CEErrorContext.h"

@interface NSError (CEErrorContext)

@property (strong, nonatomic, readonly, nullable) id <CEErrorContext> context;

- (nonnull NSError *)setContext:(nonnull id <CEErrorContext>)errorContext;

@end
