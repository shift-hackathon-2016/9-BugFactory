#import <Foundation/Foundation.h>

@interface CETask : NSObject

@property (strong, nonatomic, nonnull) NSNumber *categoryId;
@property (strong, nonatomic, nonnull) NSNumber *userId;
@property (strong, nonatomic, nonnull) NSNumber *locationId;
@property (strong, nonatomic, nonnull) NSString *descriptionObject;

@end
