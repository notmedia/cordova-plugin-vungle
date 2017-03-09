# cordova-plugin-vungle
Vungle ads for Apache Cordova

WARNING: This plugin available only for iOS.

# Install plugin

```
$ cordova plugin add cordova-plugin-vungle
```

The plugin.xml doesn't have ablity to put embedded frameworks to your project automaticly (or I didn't find the solution), so find VungleSDK.embeddedFramework in sources (src/ios) and drag & drop it to the directory into Xcode under Frameworks.

IMPORTANT: The VungleSDK.embeddedframework folder should be added as a group (yellow folder) and not as a reference (blue folder).

![add framework to the iOS project](https://support.vungle.com/hc/en-us/article_attachments/202186160/addFrameworkFolder.gif)

# Methods

##### Vungle.setup(success_callback, error_callback, debugMode, appID)
Initial method wich connect to Vungle.
(boolean) debugMode - if set to true you could see debug output from Vungle SDK.
(string) appID - the appID of your app in Vungle Dashboard.

##### Vungle.requestAd(success_callback, error_callback)
When success callback was emitted you can show ad.

##### Vungle.showAdWithOptions(success_callback, error_callback, options)
Calling this method will show an ad.
Succes callback returns info about view.
Options is an object of Vungle options, defined [here](https://support.vungle.com/hc/en-us/articles/204463080-Advanced-Settings-for-Vungle-iOS-SDK) in "Customized Ad Experience" section.

# Example

```
let appID = 'VungleAppID';
let options = {
  VunglePlayAdOptionKeyPlacement: 'default',
  VunglePlayAdOptionKeyIncentivized : true,
  VunglePlayAdOptionKeyIncentivizedAlertBodyText : "Are you sure?",
  VunglePlayAdOptionKeyIncentivizedAlertCloseButtonText : "Yes",
  VunglePlayAdOptionKeyIncentivizedAlertContinueButtonText : "No, I want to get reward.",
  VunglePlayAdOptionKeyIncentivizedAlertTitleText : "Attention!"  
}

Vungle.setup(() => {
  Vungle.requestAd(() => {
    Vungle.showAdWithOptions((info) => {
      console.log(info);
    }, (error) => {
      console.log(error);
    }, options);
  }, () => {
    console.log('Vungle request ad failed.');
  })
}, () => {
   console.log('Vungle setup failed.');
}, true, appID)

```