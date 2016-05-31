#import "CERootViewController.h"

#import "CEAuthenticationViewController.h"
@interface CERootViewController ()

@property (strong, nonatomic, nonnull) CEAuthenticationViewController *authenticationViewController;

@end

@implementation CERootViewController

- (instancetype)init
{
    self = [super init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self showAuthenticationViewController];
    
    return self;
}

- (void)showAuthenticationViewController
{
    [self addChildViewController:self.authenticationViewController];
    [self.view addSubview:self.authenticationViewController.view];
    [self.authenticationViewController didMoveToParentViewController:self];
}

- (void)showHomeViewController
{
    
}

#pragma mark - Properties

- (CEAuthenticationViewController *)authenticationViewController
{
    if (!_authenticationViewController) {
        _authenticationViewController = [CEAuthenticationViewController new];
    }
    
    return _authenticationViewController;
}
@end
