#import "CECreateTaskViewController.h"

#import "CECreateTaskFormElementCell.h"

#import "CETaskUseCase.h"

@interface CECreateTaskViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic, nonnull) UITableView *tableView;
@property (strong, nonatomic, nonnull) NSArray *presentables;

@property (strong, nonatomic, nonnull) CETaskUseCase *taskUseCase;

@end

@implementation CECreateTaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadSubviews];
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.presentables.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CECreateTaskFormElementCell *cell = [tableView dequeueReusableCellWithIdentifier:[CECreateTaskFormElementCell reuseIdentifier] forIndexPath:indexPath];
    
    CECreateTaskFormElementCellPresentable *presentable = self.presentables[indexPath.row];

    [cell configureWithPresentable:presentable];
    
    return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - Properties

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[CECreateTaskFormElementCell class] forCellReuseIdentifier:[CECreateTaskFormElementCell reuseIdentifier]];
    }
    
    return _tableView;
}

- (CETaskUseCase *)taskUseCase
{
    if (!_taskUseCase) {
        _taskUseCase = [CETaskUseCase new];
    }
    
    return _taskUseCase;
}

@end
