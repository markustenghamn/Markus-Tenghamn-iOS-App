//
//  Networking.m
//  Changr
//
//  Created by Markus Tenghamn on 07/08/14.
//  Copyright (c) 2014 Markus Tenghamn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Networking.h"

@implementation Networking


NSString *url = @"http://markustenghamn.com/rss";


- (id)init {
    return self;
}

//- (NSDictionary *)uploadProfileImage:(UIImage *)image userid:(NSString *)userid {
//    __block NSString *string = nil;
//    //UIImage *image2 = [UIImageJPEGRepresentation(image, 1.0) ];
//    //CGDataProviderRef provider = CGImageGetDataProvider(image.CGImage);
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSDictionary *params;
//    params = @{@"profile" : @1,
//            @"adid" : self.advertisingIdentifier,
//            @"userid" : userid};
//    [manager POST:url parameters:params constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:imageData name:@"profile" fileName:@"image.jpg" mimeType:@"image/jpeg"];
//
//    }     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"Success: %@", string);
//    }     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//    SBJsonParser *jsonParser = [SBJsonParser new];
//    NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:string error:nil];
//    NSLog(@"%@", jsonData);
//    return jsonData;
//}

@end