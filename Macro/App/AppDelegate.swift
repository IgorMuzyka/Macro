
import AppKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	
    @IBOutlet internal weak var about: NSWindow!
	@IBOutlet internal weak var aboutView: AboutView!

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		InitialAssembly.execute()
	}
}
