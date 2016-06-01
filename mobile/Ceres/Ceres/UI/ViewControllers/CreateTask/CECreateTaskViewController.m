#import "CECreateTaskViewController.h"

#import "CECreateTaskFormElementCell.h"

#import "CETaskUseCase.h"

@interface CECreateTaskViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic, nonnull) FLAnimatedImageView *backgroundImageView;
@property (strong, nonatomic, nonnull) UIVisualEffectView *blurView;
@property (strong, nonatomic, nonnull) UITableView *tableView;
@property (strong, nonatomic, nonnull) NSArray *presentables;

@property (strong, nonatomic, nonnull) UIBarButtonItem *nextButton;

@property (strong, nonatomic, nonnull) CETaskUseCase *taskUseCase;

@end

@implementation CECreateTaskViewController

- (instancetype)init
{
    self = [super init];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
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
    [self.navigationItem setRightBarButtonItem:self.nextButton animated:YES];
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.blurView];
    [self.view addSubview:self.tableView];

    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

- (void)updateViewConstraints
{
    [self.backgroundImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.blurView remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

- (void)loadData
{
    @weakify(self);
    [[self.taskUseCase presentFormElements] subscribeNext:^(NSArray *presentables) {
        @strongify(self);
        
        self.presentables = presentables;
        
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

#pragma mark - Private

- (void)nextScreen
{
    CETask *task = [self.taskUseCase submitableTask];
    
    CECreateTaskFormElementCellPresentable *descPresentable = [self.presentables find:^BOOL(CECreateTaskFormElementCellPresentable *presentable) {
        return presentable.formElementType == CEFormElementTypeDescription;
    }];
    
    CECreateTaskFormElementCellPresentable *startPresentable = [self.presentables find:^BOOL(CECreateTaskFormElementCellPresentable *presentable) {
        return presentable.formElementType == CEFormElementTypeStartDate;
    }];
    
    task.descriptionObject = descPresentable.formValue;
    task.startsAt = startPresentable.formValue;
    
    [[CEContext defaultContext].navigationService openRoute:@"task/create/map" params:nil navigationType:CENavigationTypePush completion:nil];
}

#pragma mark - Properties

- (UIVisualEffectView *)blurView
{
    if (!_blurView) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    }
    
    return _blurView;
}

- (FLAnimatedImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"task" ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
        _backgroundImageView = [FLAnimatedImageView new];
        _backgroundImageView.animatedImage = image;
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _backgroundImageView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[CECreateTaskFormElementCell class] forCellReuseIdentifier:[CECreateTaskFormElementCell reuseIdentifier]];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 50.0;
        _tableView.allowsSelection = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

- (UIBarButtonItem *)nextButton
{
    if (!_nextButton) {
        _nextButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", nil) style:UIBarButtonItemStylePlain target:self action:@selector(nextScreen)];
    }
    
    return _nextButton;
}

@end
