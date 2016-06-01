#import "CEMapViewController.h"

#import "CETaskUseCase.h"

#import "CETaskMapPinPresentable.h"

@interface CEMapViewController () <GMSMapViewDelegate>

@property (strong, nonatomic, nonnull) GMSMapView *mapView;
@property (strong, nonatomic, nonnull) CETaskUseCase *taskUseCase;
@property (strong, nonatomic, nonnull) NSArray *taskPresentables;

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
    [self loadData];
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

- (void)loadData
{
    @weakify(self);
    [[self.taskUseCase presentNearbyTasks] subscribeNext:^(NSArray *taskPresentables) {
        @strongify(self);
        self.taskPresentables = taskPresentables;
        
        [self placeMarkers];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - GMSMapViewDelegate

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    CETaskMapPinPresentable *presentable = marker.userData;
    
    NSString *route = [NSString stringWithFormat:@"task/%@", presentable.taskId];
    [[CEContext defaultContext].navigationService openRoute:route params:@{} navigationType:CENavigationTypePush completion:nil];
    
    return YES;
}

#pragma mark - Private

- (void)placeMarkers
{
    [self.mapView clear];
    
    GMSMutablePath *path = [GMSMutablePath path];
    
    [self.taskPresentables each:^(CETaskMapPinPresentable *presentable) {
        GMSMarker *marker = [GMSMarker markerWithPosition:presentable.coordinate];
        marker.map = self.mapView;
        marker.userData = presentable;
        [path addCoordinate:presentable.coordinate];
    }];
    
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithPath:path];
    
    GMSCameraUpdate *update = [GMSCameraUpdate fitBounds:bounds withEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];

    [self.mapView animateWithCameraUpdate:update];
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

- (CETaskUseCase *)taskUseCase
{
    if (!_taskUseCase) {
        _taskUseCase = [CETaskUseCase new];
    }
    
    return _taskUseCase;
}
@end
