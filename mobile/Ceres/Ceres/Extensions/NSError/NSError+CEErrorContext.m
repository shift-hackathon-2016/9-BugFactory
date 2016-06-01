#import "NSError+CEErrorContext.h"

#import "CEResourceErrorContext.h"

static NSString *const kCEErrorContextKey = @"CEErrorContextKey";

@implementation NSError (CEErrorContext)

- (id<CEErrorContext>)context
{
    return self.userInfo[kCEErrorContextKey];
}

- (NSError *)setContext:(id<CEErrorContext>)errorContext
{
    NSMutableDictionary *userInfo = [self.userInfo mutableCopy];
    userInfo[kCEErrorContextKey] = errorContext;
    
    return [NSError errorWithDomain:self.domain code:self.code userInfo:userInfo];
}

@end
