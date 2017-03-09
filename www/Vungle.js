var Vungle = {
	setup: function(success_cb, error_cb, debugMode, appId) {
		cordova.exec(success_cb, error_cb, 'VunglePlugin', 'setup', [debugMode, appId]);
	},	
	requestAd: function(success_cb, error_cb){
		cordova.exec(success_cb, error_cb, 'VunglePlugin', 'requestAd', []);
	},
	showAdWithOptions: function(success_cb, error_cb, options){
		cordova.exec(success_cb, error_cb, 'VunglePlugin', 'showAdWithOptions', [options]);
	}
};

module.exports = Vungle;