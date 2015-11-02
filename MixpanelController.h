//
//  MixpanelController.h
//  MixpanelController
//
//  Created by Ken M. Haggerty on 11/2/15.
//  Copyright © 2015 MCMDI. All rights reserved.
//

#pragma mark - // NOTES (Public) //

#pragma mark - // IMPORTS (Public) //

#import <Foundation/Foundation.h>

#pragma mark - // PROTOCOLS //

#pragma mark - // DEFINITIONS (Public) //

@interface MixpanelController : NSObject
+ (void)track:(NSString *)eventName properties:(NSDictionary *)properties;
+ (void)startEvent:(NSString *)eventName;
@end