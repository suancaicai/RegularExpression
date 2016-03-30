//
//  NSString+NSStringUtils.h
//  RegularExpression
//
//  Created by yumingming on 16/3/25.
//  Copyright © 2016年 MM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSStringUtils)
//字符串替换（如：[@"2013-05-01" replace:@"-" with@"/"];）
- (NSString *)replace:(NSString *)oldString with:(NSString *)newString;
- (NSString *)phoneNumberTrim;//过滤手机号中一些特殊字符
- (NSString *)format4n4;//账户反显格式化(目前为4-6-4)
- (NSString *)formatAccount;//账户格式化（eg：6225 8801 0034 1635）
- (NSString *)formatMonery;//金额格式化 (99,888,000.00)
- (NSString *)formatMoneryRe;//金额格式化只有两位小数不加逗号
- (NSString *)formatMonerySpecial;//特殊币种格式化不要小数点 (99,888,000)
- (NSString *)formatMoneryThreeDecimal;//金额币种格式化带小数点后3位
- (NSString *)formatMoneryFourDecimal;//金额币种格式化带小数点后4位
-(NSString *)formatAnyDecimal;//金额小数位不做控制

//更正用户输入
//例如：用户在金额输入.11实际是正常的，应该做一下更正
- (NSString *)correctUserInput;
- (NSString *)mobileFormat;
//去除字符串前后空格
- (NSString *)formatWhiteSpace;

//去除字符串前后空格以及后面的换行
- (NSString *)formatWhiteSpaceAndNewLineCharacterSet;

//返回小数点后一位（不带逗号）
- (NSString *)formatBalance;

//根据币种格式化金额
- (NSString *)formatMoneyWithCurrency:(NSString *)currency;

//金额小写转大写
- (NSString *)formatMoneyUpper;
@end
