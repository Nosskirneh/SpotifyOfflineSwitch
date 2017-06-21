#import "include/Header.h"

static SPTNetworkConnectivityController *connectivityController;
static OfflineSettingsSection *offlineViewController;

void doEnableOfflineMode(notifactionArguments) {
    [connectivityController setForcedOffline:YES callback:nil];

    // Update UISwitch on external change
    if (offlineViewController) {
        [offlineViewController.offlineModeCell.switchControl setOn:YES animated:YES];
    }
}

void doDisableOfflineMode(notifactionArguments) {
    [connectivityController setForcedOffline:NO callback:nil];

    // Update UISwitch on external change
    if (offlineViewController) {
        [offlineViewController.offlineModeCell.switchControl setOn:NO animated:YES];
    }
}

/* Classes to hook */

%hook SPTNetworkConnectivityController

- (id)initWithConnectivityManager:(id)arg1 core:(id)arg2 reachability:(id)arg3 networkInfo:(id)arg4 {
    return connectivityController = %orig;
}

%end


%hook Adjust

- (void)setOfflineMode:(BOOL)arg {
    %orig;

    [preferences setObject:[NSNumber numberWithBool:arg] forKey:offlineKey];
    
    if (![preferences writeToFile:prefPath atomically:YES]) {
        HBLogError(@"Could not save preferences!");
    }
}

%end


%hook SettingsViewController

// Used to get the offline section so that the UISwitch can be updated
- (void)viewDidLoad {
    %orig;

    if (self.sections.count >= 1) {
        NSString *className = NSStringFromClass([self.sections[0] class]);

        if ([className isEqualToString:@"OfflineSettingsSection"]) {
            offlineViewController = (OfflineSettingsSection *)self.sections[0];
        }
    }
}

- (void)viewDidDisappear:(BOOL)arg {
    %orig;

    if (self.sections.count >= 1) {
        NSString *className = NSStringFromClass([self.sections[0] class]);

        if ([className isEqualToString:@"OfflineSettingsSection"]) {
            offlineViewController = nil;
        }
    }
}

%end


%ctor {
    // Init settings file
    preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:prefPath];
    if (!preferences) preferences = [[NSMutableDictionary alloc] init];

    // Add observers
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, &doEnableOfflineMode, CFStringRef(doEnableOfflineModeNotification), NULL, 0);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, &doDisableOfflineMode, CFStringRef(doDisableOfflineModeNotification), NULL, 0);
}
