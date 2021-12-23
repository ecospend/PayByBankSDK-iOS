//
//  PaylinkReactModule.m
//  PaylinkSDK
//
//  Created by Berk Akkerman on 23.12.2021.
//

#import "RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(PaylinkReactModule, NSObject)
RCT_EXTERN_METHOD(authenticate:(NSString *) name
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(beep)
RCT_EXTERN_METHOD(openNativeVC)
@end
