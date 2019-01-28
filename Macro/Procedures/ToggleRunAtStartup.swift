
import AppKit.NSApplication
import Omnibus

public enum ToggleRunAtStartup {

	public static func execute() {
		let isLauncherEnabled = Launcher.isEnabled
		let action = isLauncherEnabled ? Launcher.disable : Launcher.enable

		action()

		if !isLauncherEnabled {
			NSWorkspace.shared.launchApplication(Bundle.main.bundlePath + Constants.Launcher.path)
		}

		menuBar.update()
	}

	private static var menuBar: AppMenuBar! {
		return Backdoor.bus?.access()
	}
}
