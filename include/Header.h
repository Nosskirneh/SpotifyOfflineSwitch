#ifndef HEADER
#define HEADER

// Settings file
NSMutableDictionary *preferences;
NSString *const prefPath = @"/var/mobile/Library/Preferences/se.nosskirneh.sos.plist";

// Notification strings
NSString *const doEnableOfflineModeNotification = @"se.nosskirneh.sos/doEnableOfflineMode";
NSString *const doDisableOfflineModeNotification = @"se.nosskirneh.sos/doDisableOfflineMode";

// Lookup keys
NSString *const offlineKey = @"SpotifyOfflineMode";


@interface SPCore : NSObject
- (void)setForcedOffline:(BOOL)arg;
@end


@interface SPSession : NSObject
@property (nonatomic, assign, readwrite) BOOL isOffline;
@property (nonatomic, assign, readwrite) BOOL isOnline;
@end

@interface SPBarViewController : UIViewController
@end


@interface SettingsSection : NSObject
@end


@interface SettingsViewController : UIViewController
@property (weak, nonatomic) NSArray<SettingsSection *> *sections;
@end


@interface SPNavigationController : UIViewController
@end

#endif
