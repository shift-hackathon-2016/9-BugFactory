#import "CETaskViewController.h"

#import "CETaskUseCase.h"

#import "CETaskPresentable.h"

@interface CETaskViewController ()

@property (strong, nonatomic, nonnull) FLAnimatedImageView *backgroundImageView;
@property (strong, nonatomic, nonnull) UIVisualEffectView *blurView;
@property (strong, nonatomic, nonnull) UIView *containerView;
@property (strong, nonatomic, nonnull) UILabel *descriptionLabel;
@property (strong, nonatomic, nonnull) UIButton *closeButton;
@property (strong, nonatomic, nonnull) UIButton *applyButton;
@property (strong, nonatomic, nonnull) UIImageView *iconImageView;
@property (strong, nonatomic, nonnull) UITextView *descriptionTextView;

@property (strong, nonatomic, nonnull) CETaskUseCase *taskUseCase;

@property (strong, nonatomic, nonnull) NSString *taskId;

@end

@implementation CETaskViewController

- (instancetype)initWithParams:(NSDictionary *)params
{
    self = [self init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = YES;
    
    self.taskId = params[@"id"];
    
    [self loadSubviews];
    [self loadData];
    [self startObserving];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)loadSubviews
{
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.blurView];
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.iconImageView];
    [self.containerView addSubview:self.descriptionLabel];
    [self.containerView addSubview:self.descriptionTextView];
    [self.containerView addSubview:self.closeButton];
    [self.containerView addSubview:self.applyButton];
    
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
    
    [self.containerView remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.iconImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).with.insets(UIEdgeInsetsMake(40, 20, 0, 40));
        make.width.height.equalTo(@60);
    }];
    
    [self.descriptionLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.insets(UIEdgeInsetsMake(40, 40, 0, 40));
        make.left.equalTo(self.iconImageView.right).with.offset(10.0);
        make.centerY.equalTo(self.iconImageView);
    }];
    
    [self.descriptionTextView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.closeButton.top);
    }];
    
    [self.closeButton remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    
    [self.applyButton remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.closeButton.top);
        make.height.equalTo(@50);
    }];
    
    [super updateViewConstraints];
}

- (void)loadData
{
    [[self.taskUseCase presentTaskWithTaskId:self.taskId] subscribeNext:^(CETaskPresentable *presentable) {
        self.descriptionLabel.text = presentable.descriptionObject;
    }];
}

- (void)startObserving
{
    @weakify(self);
    [[self.closeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    [[[self.applyButton rac_signalForControlEvents:UIControlEventTouchUpInside] flattenMap:^RACStream *(id value) {
        @strongify(self);
        return [self.taskUseCase applyToTaskWithTaskId:self.taskId];
    }] subscribeNext:^(id x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - Private

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

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [UIView new];
    }
    
    return _containerView;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel new];
        _descriptionLabel.numberOfLines = 0;
    }
    
    return _descriptionLabel;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.backgroundColor = [UIColor darkGrayColor];
        _iconImageView.layer.cornerRadius = 30.0;
        _iconImageView.layer.masksToBounds = YES;
    }
    
    return _iconImageView;
}

- (CETaskUseCase *)taskUseCase
{
    if (!_taskUseCase) {
        _taskUseCase = [CETaskUseCase new];
    }
    
    return _taskUseCase;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_closeButton setTitle:NSLocalizedString(@"CLOSE", nil) forState:UIControlStateNormal];
        _closeButton.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
        _closeButton.tintColor = [UIColor whiteColor];
    }
    
    return _closeButton;
}

- (UIButton *)applyButton
{
    if (!_applyButton) {
        _applyButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_applyButton setTitle:NSLocalizedString(@"APPLY", nil) forState:UIControlStateNormal];
        _applyButton.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.4];
        _applyButton.tintColor = [UIColor whiteColor];
    }
    
    return _applyButton;
}

- (UITextView *)descriptionTextView
{
    if (!_descriptionTextView) {
        _descriptionTextView = [UITextView new];
        _descriptionTextView.backgroundColor = [UIColor clearColor];
    }
    
    return _descriptionTextView;
}

@end
