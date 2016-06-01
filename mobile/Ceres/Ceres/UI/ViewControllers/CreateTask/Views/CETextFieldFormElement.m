#import "CETextFieldFormElement.h"

@interface CETextFieldFormElement ()

@property (strong, nonatomic, nonnull) UITextView *textView;

@end

@implementation CETextFieldFormElement

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self loadSubviews];
    
    return self;
}

- (void)loadSubviews
{
    [self addSubview:self.textView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.textView remakeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
        make.top.left.bottom.right.equalTo(self).insets(insets);
        make.height.equalTo(@100);
    }];
    
    [super updateConstraints];
}

- (RACSignal *)valueChanged
{
    return [self.textView rac_textSignal];
}

#pragma mark - Properties

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [UITextView new];
    }
    
    return _textView;
}

@end
