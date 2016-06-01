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
             [[UINavigationController alloc] initWithRootViewController:self.createTaskViewController],
             [[UINavigationController alloc] initWithRootViewController:self.notificationsViewController]
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
        UIImage *image = [[UIImage imageNamed:@"wagon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Find job" image:image selectedImage:image];
        _mapViewController.tabBarItem = item;
    }
    
    return _mapViewController;
}

- (CENotificationsViewController *)notificationsViewController
{
    if (!_notificationsViewController) {
        _notificationsViewController = [CENotificationsViewController new];
        UIImage *image = [[UIImage imageNamed:@"notifications"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Notifications" image:image selectedImage:image];
        _notificationsViewController.tabBarItem = item;

    }
    
    return _notificationsViewController;
}

- (CECreateTaskViewController *)createTaskViewController
{
    if (!_createTaskViewController) {
        _createTaskViewController = [CECreateTaskViewController new];
        UIImage *image = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Create" image:image selectedImage:image];
        _createTaskViewController.tabBarItem = item;

    }
    
    return _createTaskViewController;
}

@end
