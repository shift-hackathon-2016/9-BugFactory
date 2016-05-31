#import "CERootViewController.h"

#import "CEAuthenticationViewController.h"
#import "CEHomeViewController.h"

@interface CERootViewController ()

@property (strong, nonatomic, nonnull) CEAuthenticationViewController *authenticationViewController;
@property (strong, nonatomic, nonnull) CEHomeViewController *homeViewController;

@end

@implementation CERootViewController

- (instancetype)init
{
    self = [super init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self showAuthenticationViewController];
//    [self showHomeViewController];
    
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
    [self addChildViewController:self.homeViewController];
    [self.view addSubview:self.homeViewController.view];
    [self.homeViewController didMoveToParentViewController:self];
}

#pragma mark - Properties

- (CEAuthenticationViewController *)authenticationViewController
{
    if (!_authenticationViewController) {
        _authenticationViewController = [CEAuthenticationViewController new];
    }
    
    return _authenticationViewController;
}

- (CEHomeViewController *)homeViewController
{
    if (!_homeViewController) {
        _homeViewController = [CEHomeViewController new];
    }
    
    return _homeViewController;
}

@end
