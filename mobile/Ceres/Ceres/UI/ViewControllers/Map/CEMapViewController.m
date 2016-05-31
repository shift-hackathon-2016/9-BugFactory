#import "CEMapViewController.h"

@interface CEMapViewController ()

@property (strong, nonatomic, nonnull) MKMapView *mapView;

@end

@implementation CEMapViewController

- (instancetype)init
{
    self = [super init];
    
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadSubviews];
}

- (void)loadSubviews
{
    [self.view addSubview:self.mapView];
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

- (void)updateViewConstraints
{
    [self.mapView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - Properties

- (MKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [MKMapView new];
    }
    
    return _mapView;
}

@end
