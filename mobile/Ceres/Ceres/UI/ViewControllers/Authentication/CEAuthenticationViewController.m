#import "CEAuthenticationViewController.h"

#import "CEUserAuthenticationUseCase.h"

@interface CEAuthenticationViewController ()

@property (strong, nonatomic, nonnull) FLAnimatedImageView *backgroundImageView;
@property (strong, nonatomic, nonnull) UIVisualEffectView *blurView;
@property (strong, nonatomic, nonnull) UIView *containerView;
@property (strong, nonatomic, nonnull) UIImageView *logoImageView;
@property (strong, nonatomic, nonnull) UITextField *emailTextField;
@property (strong, nonatomic, nonnull) UITextField *passwordTextField;
@property (strong, nonatomic, nonnull) UIButton *loginButton;

//use cases
@property (strong, nonatomic, nonnull) CEUserAuthenticationUseCase *userAuthenticationUseCase;

@end

@implementation CEAuthenticationViewController

- (instancetype)init
{
    self = [super init];
    
    self.view.backgroundColor = [UIColor whiteColor];

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
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.blurView];
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.emailTextField];
    [self.containerView addSubview:self.passwordTextField];
    [self.containerView addSubview:self.loginButton];
    
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
    
    [self.logoImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(120.0);
    }];
    
    [self.containerView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView.bottom).with.offset(20);
        make.left.right.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 20, 0, 20));
    }];
   
    [self.emailTextField remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.containerView);
        make.height.equalTo(@40);
    }];
    
    [self.passwordTextField remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailTextField.bottom).with.insets(UIEdgeInsetsMake(10, 0, 0, 0));
        make.left.right.equalTo(self.containerView);
        make.height.equalTo(@40);
    }];
    
    [self.loginButton remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.bottom).with.offset(10.0);
        make.left.bottom.right.equalTo(self.containerView);
        make.height.equalTo(@40);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - Reactive

- (void)startObserving
{
    @weakify(self);
    [[[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] flattenMap:^RACStream *(id value) {
        @strongify(self);
        
        return [self login];
    }] subscribeNext:^(NSString *token) {
        
    }];
}

#pragma mark - Private

- (RACSignal *)login
{
    return [self.userAuthenticationUseCase authenticateWithEmail:self.emailTextField.text password:self.passwordTextField.text];
}

#pragma mark - Properties

- (FLAnimatedImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"login" ofType:@"gif"];
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
        _blurView.alpha = 0.8;
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

- (UITextField *)emailTextField
{
    if (!_emailTextField) {
        _emailTextField = [UITextField new];
        _emailTextField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _emailTextField.text = @"aron@trikoder.net";
        _emailTextField.layer.cornerRadius = 5.0;
        _emailTextField.layer.masksToBounds = YES;
        _emailTextField.textAlignment = NSTextAlignmentCenter;
        _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    }
    
    return _emailTextField;
}

- (UITextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [UITextField new];
        _passwordTextField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _passwordTextField.text = @"test123";
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.layer.cornerRadius = 5.0;
        _passwordTextField.layer.masksToBounds = YES;
        _passwordTextField.textAlignment = NSTextAlignmentCenter;
    }
    
    return _passwordTextField;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_loginButton setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
        _loginButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _loginButton.tintColor = [UIColor blackColor];
        _loginButton.layer.cornerRadius = 5.0;
        _loginButton.layer.masksToBounds = YES;
    }
    
    return _loginButton;
}

- (CEUserAuthenticationUseCase *)userAuthenticationUseCase
{
    if (!_userAuthenticationUseCase) {
        _userAuthenticationUseCase = [CEUserAuthenticationUseCase new];
    }
    
    return _userAuthenticationUseCase;
}

- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [UIImageView new];
        _logoImageView.image = [UIImage imageNamed:@"logo"];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _logoImageView;
}

@end
