#import "CENotificationsViewController.h"

#import "CENotificationCell.h"

#import "CENotificationsUseCase.h"

@interface CENotificationsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic, nonnull) FLAnimatedImageView *backgroundImageView;
@property (strong, nonatomic, nonnull) UIVisualEffectView *blurView;
@property (strong, nonatomic, nonnull) UITableView *tableView;

@property (strong, nonatomic, nonnull) NSArray *cellPresentables;

@property (strong, nonatomic, nonnull) CENotificationsUseCase *notificationsUseCase;

@end

@implementation CENotificationsViewController

- (instancetype)init
{
    self = [super init];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    imageView.image = [UIImage imageNamed:@"logo"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = imageView;

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)loadSubviews
{
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.blurView];
    [self.view addSubview:self.tableView];
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

- (void)updateViewConstraints
{
    [self.backgroundImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
    [self.blurView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

- (void)loadData
{
    @weakify(self);
    [[self.notificationsUseCase presentNotifications] subscribeNext:^(NSArray *presentables) {
        @strongify(self);
        self.cellPresentables = presentables;
        
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellPresentables.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CENotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:[CENotificationCell reuseIdentifier] forIndexPath:indexPath];
    
    CENotificationCellPresentable *presentable = self.cellPresentables[indexPath.row];
    
    [cell configureWithPresentable:presentable];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CENotificationCellPresentable *presentable = self.cellPresentables[indexPath.row];

    NSString *route = [NSString stringWithFormat:@"task/%@", presentable.objectId];
    
    [[CEContext defaultContext].navigationService openRoute:route params:nil navigationType:CENavigationTypeModal completion:nil];
}

#pragma mark - Properties

- (FLAnimatedImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"notifications" ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
        _backgroundImageView = [FLAnimatedImageView new];
        _backgroundImageView.animatedImage = image;
    }
    
    return _backgroundImageView;
}

- (UIVisualEffectView *)blurView
{
    if (!_blurView) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
//        _blurView.alpha = 0.9;
    }
    
    return _blurView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 50.0;
        [_tableView registerClass:[CENotificationCell class] forCellReuseIdentifier:[CENotificationCell reuseIdentifier]];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

- (CENotificationsUseCase *)notificationsUseCase
{
    if (!_notificationsUseCase) {
        _notificationsUseCase = [CENotificationsUseCase new];
    }
    
    return _notificationsUseCase;
}

@end
