//
//  DSAuthHandler.m
//  DSAuthTest
//
//  Created by Anton on 12.08.16.
//  Copyright © 2016 DhampireeSoftware. All rights reserved.
//

#import "DSAuthHandler.h"
#import <AFNetworking/AFNetworking.h>


@interface DSAuthHandler ()

@property (nonatomic, strong) NSURL* URLServer;

@end

@implementation DSAuthHandler

NSString const *APILogin = @"/api/auth/login";

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.URLServer = [NSURL URLWithString:@"http://46.36.222.81:3000"];
    }
    return self;
}


-(void) loginWithPhoneNumber:(NSString*) phoneNumber andNotificationID:(NSString*) notificationID{
    NSLog(@"%@",NSStringFromSelector(_cmd));

    NSString* method = @"/api/auth/login";
    NSDictionary* parameters = @{@"mobile_number":phoneNumber, @"notification_id" : notificationID};
    [self authRequsetWithMethod:method andParameters:parameters];
    //[self authAFNWithMethod:method andParameters:parameters];
}


-(void) confirmPhoneNumber:(NSString*) phoneNumber withVerticationCode:(NSString*) verticationCode{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSString* method = @"/api/auth/confirm_vertication_code";
    NSDictionary* parameters = @{@"mobile_number":phoneNumber, @"vertication_code" : verticationCode};
    [self authRequsetWithMethod:method andParameters:parameters];
    //[self authAFNWithMethod:method andParameters:parameters];
}


-(void) confirmPhoneNumber:(NSString*) phoneNumber{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    NSString* method = @"/api/auth/confirm_phone_number";
    NSDictionary* parameters = @{@"mobile_number":phoneNumber};
    [self authRequsetWithMethod:method andParameters:parameters];
    //[self authAFNWithMethod:method andParameters:parameters];
}


-(void) authRequsetWithMethod:(NSString*) method andParameters:(NSDictionary*) parameters{
   
    NSURL* requestURL = [self.URLServer URLByAppendingPathComponent:method];
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:requestURL.absoluteString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:15.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        NSError *jsonError;
                                                        NSMutableDictionary* innerJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                                                        NSLog(@"DATA: %@ \n\n", innerJson);
                                                    }
                                          ];
    
    [postDataTask resume];
}



-(void) authAFNWithMethod:(NSString*)method andParameters:(NSDictionary*)parameters {
    NSURL* requestURL = [self.URLServer URLByAppendingPathComponent:method];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    [manager POST:requestURL.absoluteString
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSError *jsonError;
              NSMutableDictionary* innerJson = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&jsonError];
              NSLog(@"DATA: %@ \n\n", innerJson);
              
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              
              NSLog(@"ERROR: %@", [error localizedDescription]);
              
          }];
}





@end
