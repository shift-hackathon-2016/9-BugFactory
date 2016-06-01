#import <Foundation/Foundation.h>

#import "CELocation.h"

@interface CETask : NSObject

@property (strong, nonatomic, nonnull) NSString *identifier;
@property (strong, nonatomic, nonnull) NSNumber *categoryId;
@property (strong, nonatomic, nonnull) NSNumber *userId;
@property (strong, nonatomic, nonnull) NSNumber *locationId;
@property (strong, nonatomic, nonnull) NSString *descriptionObject;
@property (strong, nonatomic, nonnull) NSDate *startsAt;
@property (strong, nonatomic, nonnull) NSDate *endsAt;
@property (strong, nonatomic, nonnull) NSDate *finishedAt;
@property (strong, nonatomic, nonnull) CELocation *location;

@end
