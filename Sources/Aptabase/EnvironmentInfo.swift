#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#elseif os(watchOS)
import WatchKit
#elseif os(tvOS)
import TVUIKit
#endif

public struct EnvironmentInfo {
    var isDebug = false
    var osName = ""
    var osVersion = ""
    var locale = ""
    var appVersion = ""
    var appBuildNumber = ""
    
    public static func get() -> EnvironmentInfo {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let appBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        return EnvironmentInfo(
            isDebug: isDebug,
            osName: osName,
            osVersion: osVersion,
            locale: Locale.current.languageCode ?? "",
            appVersion: appVersion ?? "",
            appBuildNumber: appBuildNumber ?? ""
        )
    }
    
    private static var isDebug: Bool {
        // We use this func instead of conditional compilation
        // because this package is pre-compiled for distribution
        return _isDebugAssertConfiguration()
    }
    
    private static var osName: String {
        #if os(macOS)
        "macOS"
#elseif os(iOS)
        if UIDevice.current.userInterfaceIdiom == .pad {
            return "iPadOS"
        }
        return "iOS"
        #elseif os(watchOS)
        "watchOS"
        #elseif os(tvOS)
        "tvOS"
        #else
        ""
        #endif
    }
    
    private static var osVersion: String {
        #if os(macOS)
        let os = ProcessInfo.processInfo.operatingSystemVersion
        return "\(os.majorVersion).\(os.minorVersion).\(os.patchVersion)"
        #elseif os(iOS)
        UIDevice.current.systemVersion
        #elseif os(watchOS)
        WKInterfaceDevice.current().systemVersion
        #elseif os(tvOS)
        UIDevice.current.systemVersion
        #else
        ""
        #endif
    }
}
