#import <Foundation/Foundation.h>

@interface CENotification : NSObject

@property (strong, nonatomic, nonnull) NSString *identifier;
@property (strong, nonatomic, nonnull) NSString *objectId;
@property (strong, nonatomic, nonnull) NSString *objectType;

@end
