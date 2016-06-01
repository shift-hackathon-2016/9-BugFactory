#import <Foundation/Foundation.h>

@interface CEDevice : NSObject

@property (strong, nonatomic, nonnull) NSString *identifier;
@property (strong, nonatomic, nonnull) NSString *name;
@property (strong, nonatomic, nonnull) NSUUID *UUID;

@end
