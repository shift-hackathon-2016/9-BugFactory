#import <Foundation/Foundation.h>

@interface CETaskPresentable : NSObject

@property (strong, nonatomic, nonnull) NSString *descriptionObject;

+ (nonnull instancetype)presentableWithTask:(nonnull CETask *)task;

@end
