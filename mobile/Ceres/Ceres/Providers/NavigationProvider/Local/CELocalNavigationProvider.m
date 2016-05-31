#import "CELocalNavigationProvider.h"

@implementation CELocalNavigationProvider

@synthesize rootViewController = _rootViewController;
@synthesize currentViewController = _currentViewController;

- (void)setRootViewController:(UIViewController *)rootViewController
{
    _rootViewController = rootViewController;
    self.currentViewController = rootViewController;
}

@end
