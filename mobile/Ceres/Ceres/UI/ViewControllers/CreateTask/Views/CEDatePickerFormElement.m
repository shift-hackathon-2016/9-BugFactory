#import "CEDatePickerFormElement.h"

@interface CEDatePickerFormElement ()

@property (strong, nonatomic, nonnull) UIDatePicker *datePicker;

@end

@implementation CEDatePickerFormElement

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
 
    [self loadSubviews];
    
    return self;
}

- (void)loadSubviews
{
    [self addSubview:self.datePicker];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.datePicker remakeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
        make.top.left.bottom.right.equalTo(self).insets(insets);
        make.height.equalTo(@100);
    }];
    
    [super updateConstraints];
}

- (RACSignal *)valueChanged
{
    @weakify(self);
    return [[self.datePicker rac_signalForControlEvents:UIControlEventValueChanged] map:^id(id value) {
        @strongify(self);
        return self.datePicker.date;
    }];
}

#pragma mark - Properties

- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [UIDatePicker new];
    }
    
    return _datePicker;
}

@end
