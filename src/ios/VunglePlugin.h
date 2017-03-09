#import <Cordova/CDV.h>
#import <VungleSDK/VungleSDK.h>

@interface VunglePlugin : CDVPlugin <VungleSDKDelegate>

@property VungleSDK *Vungle;
@property NSString *callbackId;
@property BOOL adPlayable;

- (void) setup:(CDVInvokedUrlCommand*) command;
- (void) requestAd:(CDVInvokedUrlCommand*) command;
- (void) showAdWithOptions:(CDVInvokedUrlCommand*) command;
@end
