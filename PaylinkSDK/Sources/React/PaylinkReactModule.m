//
//  PaylinkReactModule.m
//  PaylinkSDK
//
//  Created by Berk Akkerman on 23.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

#import "RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(PaylinkReactModule, NSObject)
RCT_EXTERN_METHOD(configure:(NSString *) clientId
                  clientSecret:(NSString *) clientSecret)
RCT_EXTERN_METHOD(initiate:(NSDictionary *)request
                  errorCallback: (RCTResponseSenderBlock *)errorCallback)
RCT_EXTERN_METHOD(open:(NSString *) uid
                  errorCallback: (RCTResponseSenderBlock *)errorCallback)
@end
