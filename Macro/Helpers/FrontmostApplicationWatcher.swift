
import AppKit.NSRunningApplication
import AppKit.NSWorkspace

public class FrontmostApplicationWatcher {

	public private(set) var lastKnownFrontmostApplication: NSRunningApplication!
    private let ownBundleIdentifier = Bundle.main.bundleIdentifier!

	public init() {
		subscribeForNotifications()
	}

	deinit {
		unsubscribeFromNotifications()
	}

	@objc private func handle(_ notification: Notification) {
		guard
            let frontmostApplication = NSWorkspace.shared.frontmostApplication,
            let bundleIdentifier = frontmostApplication.bundleIdentifier,
            bundleIdentifier != ownBundleIdentifier
        else {
			return
		}

		lastKnownFrontmostApplication = frontmostApplication
	}

	private func unsubscribeFromNotifications() {
		NSWorkspace.shared.notificationCenter.removeObserver(self)
	}

	private func subscribeForNotifications() {
		for notification in FrontmostApplicationWatcher.workspaceNotification {
			NSWorkspace.shared.notificationCenter.addObserver(
				self,
				selector: #selector(handle),
				name: notification,
				object: nil
			)
		}
	}

	private static let workspaceNotification = [
		NSWorkspace.willLaunchApplicationNotification,
		NSWorkspace.didLaunchApplicationNotification,
		NSWorkspace.didTerminateApplicationNotification,
		NSWorkspace.didHideApplicationNotification,
		NSWorkspace.didUnhideApplicationNotification,
		NSWorkspace.didActivateApplicationNotification,
		NSWorkspace.didDeactivateApplicationNotification
	]
}
