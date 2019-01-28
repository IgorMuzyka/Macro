
import AppKit.NSWorkspace

public enum OpenAccessibilityPreferencePane {

	public static func execute() {
		NSWorkspace.shared.open(URL(string: Constants.Utility.accessibilityPreferencePaneLink)!)
	}
}
