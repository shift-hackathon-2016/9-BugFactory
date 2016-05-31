#import "CEHomeViewController.h"

#import "CEMapViewController.h"

@interface CEHomeViewController ()

@property (strong, nonatomic, nonnull) CEMapViewController *mapViewController;

@end

@implementation CEHomeViewController

- (instancetype)init
{
    self = [super init];
    
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setViewControllers:@[[self tabBarViewControllers]] animated:NO];
}

#pragma mark - Private

- (NSArray *)tabBarViewControllers
{
    return @[
             self.mapViewController
             ];
}

#pragma mark - Properties

- (CEMapViewController *)mapViewController
{
    if (!_mapViewController) {
        _mapViewController = [CEMapViewController new];
    }
    
    return _mapViewController;
}



@end
