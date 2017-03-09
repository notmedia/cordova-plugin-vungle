#import "VunglePlugin.h"

@implementation VunglePlugin

@synthesize Vungle;
@synthesize callbackId;
@synthesize adPlayable;

- (void) setup:(CDVInvokedUrlCommand *)command {
    adPlayable = false;
    Vungle = [VungleSDK sharedSDK];
    [[VungleSDK sharedSDK] setDelegate:self];    
    [Vungle setLoggingEnabled: [[command.arguments objectAtIndex:0] boolValue]];
    [Vungle startWithAppId: [command.arguments objectAtIndex:1]];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString: @"Vungle: Setup complete."];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) requestAd:(CDVInvokedUrlCommand *)command {
    if (adPlayable){
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                          messageAsString: @"Vungle: Ad playable."];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                          messageAsString: @"Vungle: Ad can not be played."];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void) showAdWithOptions:(CDVInvokedUrlCommand *)command {
    callbackId = command.callbackId;
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    NSError *error;
    for (id key in [command.arguments objectAtIndex:0]){
        [options setObject:[[command.arguments objectAtIndex:0] objectForKey:key] forKey: [self getValidKeyFor:key]];
    }
    [Vungle playAd:self.viewController withOptions:options error: &error];
    if (error){
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                          messageAsString: [error description]];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (id) getValidKeyFor:(NSString*) key{
    if ([key isEqualToString:@"VunglePlayAdOptionKeyIncentivized"]){
        return VunglePlayAdOptionKeyIncentivized;
    }
    else if ([key isEqualToString:@"VunglePlayAdOptionKeyIncentivizedAlertTitleText"]){
        return VunglePlayAdOptionKeyIncentivizedAlertTitleText;
    }
    else if ([key isEqualToString:@"VunglePlayAdOptionKeyIncentivizedAlertBodyText"]){
        return VunglePlayAdOptionKeyIncentivizedAlertBodyText;
    }
    else if ([key isEqualToString:@"VunglePlayAdOptionKeyIncentivizedAlertCloseButtonText"]){
        return VunglePlayAdOptionKeyIncentivizedAlertCloseButtonText;
    }
    else if ([key isEqualToString:@"VunglePlayAdOptionKeyIncentivizedAlertContinueButtonText"]){
        return VunglePlayAdOptionKeyIncentivizedAlertContinueButtonText;
    }
    else if ([key isEqualToString:@"VunglePlayAdOptionKeyOrientations"]){
        return VunglePlayAdOptionKeyOrientations;
    }
    else if ([key isEqualToString:@"VunglePlayAdOptionKeyUser"]){
        return VunglePlayAdOptionKeyUser;
    }
    else if ([key isEqualToString:@"VunglePlayAdOptionKeyPlacement"]){
        return VunglePlayAdOptionKeyPlacement;
    }
    else{
        return nil;
    }
};


- (void)vungleSDKAdPlayableChanged:(BOOL)isAdPlayable {
    if (isAdPlayable) {
        adPlayable = true;
    } else {
        adPlayable = false;
    }
}

- (void)vungleSDKwillShowAd {
    //NSLog(@"An ad is about to be played!");
    //Use this delegate method to pause animations, sound, etc.
}

- (void)vungleSDKwillCloseAdWithViewInfo:(NSDictionary *)viewInfo willPresentProductSheet:(BOOL)willPresentProductSheet {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                  messageAsDictionary:viewInfo];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)vungleSDKwillCloseProductSheet:(id)productSheet {
    //NSLog(@"The user has downloaded an advertised application and is now returning to the main app");
    //This method can be used to resume animations, sound, etc. if a user was presented a product sheet earlier
}

@end
