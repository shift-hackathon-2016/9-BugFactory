#import <Foundation/Foundation.h>

@interface CEUser : NSObject

@property (strong, nonatomic, nonnull) NSString *identifier;
@property (strong, nonatomic, nonnull) NSString *email;
@property (strong, nonatomic, nonnull) NSString *firstName;
@property (strong, nonatomic, nonnull) NSString *lastName;

@end
