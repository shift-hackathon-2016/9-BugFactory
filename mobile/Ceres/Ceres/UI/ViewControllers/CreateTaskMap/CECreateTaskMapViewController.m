#import "CECreateTaskMapViewController.h"

#import "CETaskUseCase.h"

@interface CECreateTaskMapViewController () <GMSMapViewDelegate>

@property (strong, nonatomic, nonnull) GMSMapView *mapView;
@property (strong, nonatomic, nonnull) UIBarButtonItem *nextButton;
@property (strong, nonatomic, nonnull) GMSMarker *marker;
@property (strong, nonatomic, nonnull) CETaskUseCase *taskUseCase;

@end

@implementation CECreateTaskMapViewController

- (instancetype)initWithParams:(NSDictionary *)params
{
    self = [self init];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadSubviews];
}

- (void)loadSubviews
{
    [self.navigationItem setRightBarButtonItem:self.nextButton animated:YES];
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

#pragma mark - GMSMapViewDelegate

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    [self.mapView clear];
    
    self.marker = [GMSMarker markerWithPosition:coordinate];
    self.marker.map = self.mapView;
    self.marker.draggable = YES;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:coordinate.latitude longitude:coordinate.longitude zoom:17.0];
    [self.mapView animateToCameraPosition:camera];
}

#pragma mark - Private

- (void)nextScreen
{
    CETask *task = [self.taskUseCase submitableTask];
    
    CELocation *location = [CELocation new];
    location.latitude = @(self.marker.position.latitude);
    location.longitude = @(self.marker.position.longitude);
    
    task.location = location;
    
    [[CEContext defaultContext].navigationService openRoute:@"task/create/confirm" params:nil navigationType:CENavigationTypeModal completion:nil];
}

#pragma mark - Properties

- (GMSMapView *)mapView
{
    if (!_mapView) {
        _mapView = [GMSMapView new];
        _mapView.delegate = self;
    }
    
    return _mapView;
}

- (UIBarButtonItem *)nextButton
{
    if (!_nextButton) {
        _nextButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", nil) style:UIBarButtonItemStylePlain target:self action:@selector(nextScreen)];
    }
    
    return _nextButton;
}

- (CETaskUseCase *)taskUseCase
{
    if (!_taskUseCase) {
        _taskUseCase = [CETaskUseCase new];
    }
    
    return _taskUseCase;
}

@end
