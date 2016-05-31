#import "CENotificationsViewController.h"

#import "CENotificationCell.h"

#import "CENotificationsUseCase.h"

@interface CENotificationsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic, nonnull) UITableView *tableView;

@property (strong, nonatomic, nonnull) NSArray *cellPresentables;

@property (strong, nonatomic, nonnull) CENotificationsUseCase *notificationsUseCase;

@end

@implementation CENotificationsViewController

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
    [self.view addSubview:self.tableView];
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

- (void)updateViewConstraints
{
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

#pragma mark - UITableViewDelegate

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CENotificationCell reuseIdentifier] forIndexPath:indexPath];
    
    
    
    return cell;
}

#pragma mark - UITableViewDataSource

#pragma mark - Properties

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CENotificationCell class] forCellReuseIdentifier:[CENotificationCell reuseIdentifier]];
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
