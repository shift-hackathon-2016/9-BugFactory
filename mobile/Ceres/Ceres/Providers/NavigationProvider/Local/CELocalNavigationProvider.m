#import "CELocalNavigationProvider.h"

#import "UIViewController+CurrentViewController.h"

@implementation CELocalNavigationProvider

@synthesize rootViewController = _rootViewController;
@synthesize currentViewController = _currentViewController;

- (void)setCurrentViewController:(UIViewController *)currentViewController
{
    if ([currentViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nc = (UINavigationController *)currentViewController;
        _currentViewController = nc.viewControllers[0];
    } else {
        _currentViewController = currentViewController;
    }
}

- (void)setRootViewController:(UIViewController *)rootViewController
{
    _rootViewController = rootViewController;
    self.currentViewController = rootViewController;
}

- (UIViewController *)currentViewController
{
    return [UIViewController currentViewController];
}

@end
