//
//  ViewController.m
//  DSAuthTest
//
//  Created by Anton on 12.08.16.
//  Copyright © 2016 DhampireeSoftware. All rights reserved.
//

#import "ViewController.h"
#import "DSAuthHandler.h"
#import <AFNetworking/AFNetworking.h>


typedef enum {
    BUTTON_ACTION_LOGIN = 110001,
    BUTTON_ACTION_COFIRM = 110002,
    BUTTON_ACTION_VERIFICATE = 110003
}DSAuthButtonAction;

@interface ViewController ()

@property (nonatomic, strong) DSAuthHandler* authHandler;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.authHandler = [[DSAuthHandler alloc] init];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actionAuth:(UIButton *)sender {
    
    NSString* mobileNumber = self.mobileNumberTextField.text;
    NSString* code = self.codeTextField.text;
    
    switch (sender.tag) {
        case BUTTON_ACTION_LOGIN: {
            [self.authHandler loginWithPhoneNumber:mobileNumber andNotificationID:code];
            break;
        }
            
        case BUTTON_ACTION_COFIRM: {
            [self.authHandler confirmPhoneNumber:mobileNumber];
            break;
        }
            
        case BUTTON_ACTION_VERIFICATE: {
            [self.authHandler confirmPhoneNumber:mobileNumber withVerticationCode:code];
            break;
        }
            
        default:
            break;
    }
}
@end
