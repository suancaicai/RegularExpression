//
//  ViewController.h
//  RegularExpression
//
//  Created by yumingming on 16/1/19.
//  Copyright © 2016年 MM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MMReTextField;

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet MMReTextField *cardNumber;
@property (strong, nonatomic) IBOutlet MMReTextField *cardholder;
@property (strong, nonatomic) IBOutlet MMReTextField *validUntil;
@property (strong, nonatomic) IBOutlet MMReTextField *cvv;
@property (strong, nonatomic) IBOutlet MMReTextField *date;
@property (strong, nonatomic) IBOutlet MMReTextField *time;


@property (weak, nonatomic) IBOutlet MMReTextField *moneyTextView;
@property (weak, nonatomic) IBOutlet UILabel *kilobitLabel;
@property (weak, nonatomic) IBOutlet UILabel *upperCaseLabel;





@end

