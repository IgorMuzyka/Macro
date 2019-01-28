
import AppKit.NSApplication
import Omnibus

public enum PresentAbout {

	public static func execute() {
		let aboutView = appDelegate.aboutView!
		let about = appDelegate.about!

		aboutView.set(info: AboutView.Info(
			version: AboutView.Info.Version(major: 1, minor: 0, patch: 0),
			build: 1,
			about: Constants.App.about,
			applicationName: Constants.App.name,
			authors: [Constants.App.author]
		))

		about.makeKeyAndOrderFront(nil)
	}

	private static var appDelegate: AppDelegate! {
		return Backdoor.bus?.access()
	}
}
