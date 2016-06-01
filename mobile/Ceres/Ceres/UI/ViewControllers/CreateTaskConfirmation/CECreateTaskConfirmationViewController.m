#import "CECreateTaskConfirmationViewController.h"

#import "CETaskUseCase.h"

@interface CECreateTaskConfirmationViewController ()

@property (strong, nonatomic, nonnull) UIVisualEffectView *blurView;
@property (strong, nonatomic, nonnull) UIView *containerView;
@property (strong, nonatomic, nonnull) UIButton *confirmButton;
@property (strong, nonatomic, nonnull) UIButton *cancelButton;
@property (strong, nonatomic, nonnull) CETaskUseCase *taskUseCase;

@end

@implementation CECreateTaskConfirmationViewController

- (instancetype)initWithParams:(NSDictionary *)params
{
    self = [self init];
    
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadSubviews];
    [self startObserving];
}

- (void)loadSubviews
{
    [self.view addSubview:self.blurView];
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.confirmButton];
    [self.containerView addSubview:self.cancelButton];
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

- (void)updateViewConstraints
{
    [self.blurView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [self.containerView remakeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 50, 0, 50);
        make.centerY.equalTo(self.view);
        make.left.right.equalTo(self.view).with.insets(insets);
    }];
    
    [self.confirmButton remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.containerView);
        make.height.equalTo(@50);
    }];
    
    [self.cancelButton remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.confirmButton.bottom).with.offset(50.0);
        make.bottom.left.right.equalTo(self.containerView);
        make.height.equalTo(@50);
    }];
    
    [super updateViewConstraints];
}

- (void)startObserving
{
    @weakify(self);
    [[[self.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] flattenMap:^RACStream *(id value) {
        return [self.taskUseCase createTask];
    }] subscribeNext:^(id x) {
        @strongify(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thank you!" message:@"Task was posted successfully. You'll get notified when someone applies." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:^{
                [self.presentingViewController.navigationController popToRootViewControllerAnimated:YES];
            }];
        }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    } error:^(NSError *error) {
        
    }];
    
    [[self.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
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

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [UIView new];
    }
    
    return _containerView;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _confirmButton.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];
        [_confirmButton setTitle:@"Confirm" forState:UIControlStateNormal];
        _confirmButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
        _confirmButton.layer.cornerRadius = 5.0;
        _confirmButton.layer.masksToBounds = YES;
    }
    
    return _confirmButton;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        _cancelButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
        _cancelButton.layer.cornerRadius = 5.0;
        _cancelButton.layer.masksToBounds = YES;
    }
    
    return _cancelButton;
}

- (CETaskUseCase *)taskUseCase
{
    if (!_taskUseCase) {
        _taskUseCase = [CETaskUseCase new];
    }
    
    return _taskUseCase;
}

@end
