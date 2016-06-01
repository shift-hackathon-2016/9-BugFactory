#import "CEHomeViewController.h"

#import "CEMapViewController.h"
#import "CENotificationsViewController.h"
#import "CECreateTaskViewController.h"

@interface CEHomeViewController () <UITabBarControllerDelegate>

@property (strong, nonatomic, nonnull) CEMapViewController *mapViewController;
@property (strong, nonatomic, nonnull) CENotificationsViewController *notificationsViewController;
@property (strong, nonatomic, nonnull) CECreateTaskViewController *createTaskViewController;

@end

@implementation CEHomeViewController

- (instancetype)initWithParams:(NSDictionary *)params
{
    self = [self init];
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
   
    [self loadViewControllers];
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    [[CEContext defaultContext].navigationProvider setCurrentViewController:viewController];
    
    return YES;
}

#pragma mark - Private

- (void)loadViewControllers
{
    NSArray *viewControllers = @[
             [[UINavigationController alloc] initWithRootViewController:self.mapViewController],
             [[UINavigationController alloc] initWithRootViewController:self.notificationsViewController],
             [[UINavigationController alloc] initWithRootViewController:self.createTaskViewController]
             ];
    
    [viewControllers each:^(__kindof UIViewController *viewController) {
        [self addChildViewController:viewController];
    }];
    
    [self setViewControllers:viewControllers animated:NO];
}

#pragma mark - Properties

- (CEMapViewController *)mapViewController
{
    if (!_mapViewController) {
        _mapViewController = [CEMapViewController new];
    }
    
    return _mapViewController;
}

- (CENotificationsViewController *)notificationsViewController
{
    if (!_notificationsViewController) {
        _notificationsViewController = [CENotificationsViewController new];
        
    }
    
    return _notificationsViewController;
}

- (CECreateTaskViewController *)createTaskViewController
{
    if (!_createTaskViewController) {
        _createTaskViewController = [CECreateTaskViewController new];
    }
    
    return _createTaskViewController;
}

@end