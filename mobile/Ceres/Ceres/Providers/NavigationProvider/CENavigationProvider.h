#import <Foundation/Foundation.h>

@protocol CENavigationProvider <NSObject>

@property (strong, nonatomic, nonnull) UIViewController *rootViewController;
@property (strong, nonatomic, nonnull) UIViewController *currentViewController;

@end
