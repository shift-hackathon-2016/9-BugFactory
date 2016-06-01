#import <Foundation/Foundation.h>

#import "CEObjectProperty.h"

@interface NSObject (PropertyEnumerator)

@property (strong, nonatomic, readonly, nonnull) NSArray <CEObjectProperty *> *objectProperties;

@end
