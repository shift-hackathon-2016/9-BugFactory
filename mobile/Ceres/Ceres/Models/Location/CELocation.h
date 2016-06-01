#import <Foundation/Foundation.h>

@interface CELocation : NSObject

@property (strong, nonatomic, nonnull) NSNumber *latitude;
@property (strong, nonatomic, nonnull) NSNumber *longitude;

- (CLLocationCoordinate2D)coordinate;

@end
