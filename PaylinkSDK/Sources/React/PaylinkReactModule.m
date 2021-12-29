//
//  PaylinkReactModule.m
//  PaylinkSDK
//
//  Created by Berk Akkerman on 23.12.2021.
//

#import "RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(PaylinkReactModule, NSObject)
RCT_EXTERN_METHOD(configure:(NSString *) clientId
                  clientSecret:(NSString *) clientSecret)
RCT_EXTERN_METHOD(initiate:(NSDictionary *)request
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(open:(NSString *) uid
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
@end
