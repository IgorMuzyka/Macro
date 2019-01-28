
import AppKit.NSAlert

public enum PromptUserToConfirmAccessibilityAccess {

	public static func execute() -> Bool {
		let alert = NSAlert()
		alert.messageText = Constants.Dialogue.AccessibilityAccessPrompt.message
		alert.informativeText = Constants.Dialogue.AccessibilityAccessPrompt.text
		alert.alertStyle = .critical
		alert.addButton(withTitle: Constants.Dialogue.AccessibilityAccessPrompt.confirmation)
		alert.addButton(withTitle: Constants.Dialogue.AccessibilityAccessPrompt.cancellation)

		return alert.runModal() == .alertFirstButtonReturn
	}
}
