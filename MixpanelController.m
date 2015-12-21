//
//  MixpanelController.m
//  MixpanelController
//
//  Created by Ken M. Haggerty on 11/2/15.
//  Copyright © 2015 MCMDI. All rights reserved.
//

#pragma mark - // NOTES (Private) //

#pragma mark - // IMPORTS (Private) //

#import "MixpanelController.h"
#import "AKDebugger.h"
#import "AKGenerics.h"
#import "Mixpanel.h"
#import "PrivateInfo.h"

#pragma mark - // DEFINITIONS (Private) //

@interface MixpanelController ()
@property (nonatomic) id sharedInstance;

// GENERAL //

+ (id)sharedController;
- (void)setup;
- (void)teardown;

// CONVENIENCE //

+ (id)sharedInstance;

@end

@implementation MixpanelController

#pragma mark - // SETTERS AND GETTERS //

@synthesize sharedInstance = _sharedInstance;

- (id)sharedInstance
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:nil message:nil];
    
    if (_sharedInstance) return _sharedInstance;
    
    _sharedInstance = [Mixpanel sharedInstance];
    if (_sharedInstance) return _sharedInstance;
    
    _sharedInstance = [Mixpanel sharedInstanceWithToken:[PrivateInfo mixpanelToken]];
    return _sharedInstance;
}

#pragma mark - // INITS AND LOADS //

- (id)init
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetup tags:nil message:nil];
    
    self = [super init];
    if (!self)
    {
        [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeCritical methodType:AKMethodTypeSetup tags:nil message:[NSString stringWithFormat:@"%@ is nil", stringFromVariable(self)]];
        return nil;
    }
    
    [self setup];
    return self;
}

- (void)awakeFromNib
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetup tags:nil message:nil];
    
    [super awakeFromNib];
    [self setup];
}

- (void)dealloc
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetup tags:nil message:nil];
    
    [self teardown];
}

#pragma mark - // PUBLIC METHODS //

+ (void)track:(NSString *)eventName properties:(NSDictionary *)properties
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_ANALYTICS] message:nil];
    
    [[MixpanelController sharedInstance] track:eventName properties:properties];
}

+ (void)startEvent:(NSString *)eventName
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeUnspecified tags:@[AKD_ANALYTICS] message:nil];
    
    [[MixpanelController sharedInstance] timeEvent:eventName];
}

#pragma mark - // CATEGORY METHODS //

#pragma mark - // DELEGATED METHODS //

#pragma mark - // OVERWRITTEN METHODS //

#pragma mark - // PRIVATE METHODS (General) //

+ (id)sharedController
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:nil message:nil];
    
    static dispatch_once_t once;
    static MixpanelController *sharedController;
    dispatch_once(&once, ^{
        sharedController = [[MixpanelController alloc] init];
    });
    return sharedController;
}

- (void)setup
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetup tags:nil message:nil];
}

- (void)teardown
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeSetup tags:nil message:nil];
}

#pragma mark - // PRIVATE METHODS (Convenience) //

+ (id)sharedInstance
{
    [AKDebugger logMethod:METHOD_NAME logType:AKLogTypeMethodName methodType:AKMethodTypeGetter tags:nil message:nil];
    
    return [[MixpanelController sharedController] sharedInstance];
}

@end