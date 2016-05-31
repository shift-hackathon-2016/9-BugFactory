#import "CEHomeViewController.h"

#import "CEMapViewController.h"
#import "CENotificationsViewController.h"

@interface CEHomeViewController ()

@property (strong, nonatomic, nonnull) CEMapViewController *mapViewController;
@property (strong, nonatomic, nonnull) CENotificationsViewController *notificationsViewController;

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
    
    [self loadViewControllers];
}

#pragma mark - Private

- (void)loadViewControllers
{
    NSArray *viewControllers = @[
             [[UINavigationController alloc] initWithRootViewController:self.mapViewController],
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

@end
