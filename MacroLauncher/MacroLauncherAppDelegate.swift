
import AppKit.NSApplication

@NSApplicationMain
class MacroLauncherAppDelegate: NSObject, NSApplicationDelegate {

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		enableMainApplication()
	}

	private func enableMainApplication() {
		if !isRunning {
			var path = Bundle.main.bundlePath as NSString

			for _ in 1...4 {
				path = path.deletingLastPathComponent as NSString
			}

			NSWorkspace.shared.launchApplication(path as String)
		}
	}

	private var isRunning: Bool {
		let applications = NSWorkspace.shared.runningApplications
		return applications.contains { $0.bundleIdentifier == bundleIdentifier }
	}

	let bundleIdentifier = "igormuzyka.Macro.Macro"
}
