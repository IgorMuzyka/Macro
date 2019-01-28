
import MenuBar
import StoreKit

public enum PreferencesMenu {

	public static func assemble() -> Descriptor {
		return .menu([.title(Constants.MenuBar.preferences)], [
			runAtStartup,
			sendFeedback
		])
	}

	private static var runAtStartup: Descriptor {
		let isLauncherEnabled = Launcher.isEnabled

		return .item([
			.title(!isLauncherEnabled ? Constants.MenuBar.enableRunAtStartup : Constants.MenuBar.runAtStartup),
			.action(ToggleRunAtStartup.execute),
			.state(isLauncherEnabled ? .on : .off)
		])
	}

	private static var sendFeedback: Descriptor {
		return .item([
			.title(Constants.MenuBar.sendFeedback),
			.action(SendFeedback.execute)
		])
	}
}
