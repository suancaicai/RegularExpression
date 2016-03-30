//
//  MMReTextField.h
//  RegularExpression
//
//  Created by yumingming on 16/1/19.
//  Copyright © 2016年 MM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMRegularParser;

@interface MMReTextField : UITextField
{
    NSString *_lastAcceptedValue;
    MMRegularParser *_parser;
}

@property (strong, nonatomic) NSString *pattern;


@end
