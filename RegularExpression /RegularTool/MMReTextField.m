//
//  MMReTextField.m
//  RegularExpression
//
//  Created by yumingming on 16/1/19.
//  Copyright © 2016年 MM. All rights reserved.
//

#import "MMReTextField.h"
#import "MMRegularParser.h"

@implementation MMReTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _lastAcceptedValue = nil;
        _parser = nil;
        [self addTarget:self action:@selector(formatInput:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _lastAcceptedValue = nil;
        _parser = nil;
        [self addTarget:self action:@selector(formatInput:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)dealloc
{
    _lastAcceptedValue = nil;
    _parser = nil;
    [self removeTarget:self action:@selector(formatInput:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setPattern:(NSString *)pattern
{
    if (pattern == nil || [pattern isEqualToString:@""])
        _parser = nil;
    else
        _parser = [[MMRegularParser alloc] initWithPattern:pattern];
}

- (NSString*)pattern
{
    return _parser.pattern;
}

- (void)formatInput:(UITextField *)textField
{
    if (_parser == nil) return;

    __block MMRegularParser *localParser = _parser;

    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *formatted = [localParser reformatString:textField.text];
        if (formatted == nil)
            formatted = _lastAcceptedValue;
        else
            _lastAcceptedValue = formatted;
        NSString *newText = formatted;
        if (![textField.text isEqualToString:newText]) {
            textField.text = formatted;
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    });
}

@end
