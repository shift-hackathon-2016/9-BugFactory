#import <Foundation/Foundation.h>

@interface CETaskMapPinPresentable : NSObject

@property (strong, nonatomic, nonnull) NSString *taskId;    
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

+ (nonnull instancetype)presentableWithTask:(nonnull CETask *)task;

@end
