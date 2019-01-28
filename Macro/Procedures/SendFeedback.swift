
import AppKit.NSWorkspace

public enum SendFeedback {

	public static func execute() {
		NSWorkspace.shared.open(URL(string: Constants.App.mailtoLink)!)
	}
}
