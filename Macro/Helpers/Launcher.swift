
import AppKit.NSWorkspace
import ServiceManagement

public enum Launcher {

    public static func enable() {
        SMLoginItemSetEnabled(Constants.Launcher.bundleIdentifier as CFString, true)
    }

    public static func disable() {
        SMLoginItemSetEnabled(Constants.Launcher.bundleIdentifier as CFString, false)
    }

	public static var isEnabled: Bool {
		return NSWorkspace.shared.runningApplications.contains { $0.bundleIdentifier == Constants.Launcher.bundleIdentifier }
	}
}
