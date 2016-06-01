#import "CETaskViewController.h"

#import "CETaskUseCase.h"

#import "CETaskPresentable.h"

@interface CETaskViewController ()

@property (strong, nonatomic, nonnull) UIVisualEffectView *blurView;
@property (strong, nonatomic, nonnull) UILabel *descriptionLabel;
@property (strong, nonatomic, nonnull) UIButton *closeButton;
@property (strong, nonatomic, nonnull) UIButton *applyButton;

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

- (void)loadSubviews
{
    [self.view addSubview:self.blurView];
    [self.view addSubview:self.descriptionLabel];
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.applyButton];
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

- (void)updateViewConstraints
{
    [self.blurView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.left.equalTo(self.view);
    }];
    
    [self.descriptionLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).with.insets(UIEdgeInsetsMake(40, 40, 0, 40));
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

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel new];
        _descriptionLabel.numberOfLines = 0;
    }
    
    return _descriptionLabel;
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
        _closeButton.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
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

@end
