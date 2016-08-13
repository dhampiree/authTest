//
//  ViewController.h
//  DSAuthTest
//
//  Created by Anton on 12.08.16.
//  Copyright © 2016 DhampireeSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

- (IBAction)actionAuth:(UIButton *)sender;


@end

