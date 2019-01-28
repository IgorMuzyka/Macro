
import AppKit.NSAlert

public enum PromptUserToOpenPreferencePane {

	public static func execute() -> Bool {
		let alert = NSAlert()
		alert.messageText = Constants.Dialogue.PreferencePanePrompt.message
		alert.informativeText = Constants.Dialogue.PreferencePanePrompt.text
		alert.alertStyle = .critical
		alert.addButton(withTitle: Constants.Dialogue.PreferencePanePrompt.confirmation)
		alert.addButton(withTitle: Constants.Dialogue.PreferencePanePrompt.cancellation)

		return alert.runModal() == .alertFirstButtonReturn
	}
}
