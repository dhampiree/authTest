//
//  DSAuthHandler.h
//  DSAuthTest
//
//  Created by Anton on 12.08.16.
//  Copyright © 2016 DhampireeSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DSAuthHandler : NSObject <NSURLSessionDelegate>

-(void) loginWithPhoneNumber:(NSString*) phoneNumber andNotificationID:(NSString*) notificationID;
-(void) confirmPhoneNumber:(NSString*) phoneNumber withVerticationCode:(NSString*) verticationCode;
-(void) confirmPhoneNumber:(NSString*) phoneNumber;

@end
