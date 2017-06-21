#ifndef HEADER
#define HEADER

#define notifactionArguments CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo

// Settings file
NSMutableDictionary *preferences;
NSString *const prefPath = @"/var/mobile/Library/Preferences/se.nosskirneh.sos.plist";

// Notification strings
NSString *const doEnableOfflineModeNotification = @"se.nosskirneh.sos/doEnableOfflineMode";
NSString *const doDisableOfflineModeNotification = @"se.nosskirneh.sos/doDisableOfflineMode";

// Lookup keys
NSString *const offlineKey = @"SpotifyOfflineMode";


@interface SPTNetworkConnectivityController : NSObject
@property (nonatomic, readwrite, assign) BOOL forcedOffline;
- (void)setForcedOffline:(BOOL)arg1 callback:(id)arg2;
@end


@interface SettingsSection : NSObject
@end

@interface SettingsSwtichTableViewCell : UITableViewCell
@property (nonatomic, readwrite, assign) UISwitch *switchControl;
@end

@interface OfflineSettingsSection : SettingsSection
@property (nonatomic, readwrite, assign) SettingsSwtichTableViewCell *offlineModeCell;
@end

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) NSArray<SettingsSection *> *sections;
@property (nonatomic, readwrite, assign) UITableView *tableView;
@end


#endif
