
import AppKit.NSApplication
import Omnibus

public enum PlayMacro {

	public static func execute() {
		DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
			macroManager.play()
		})
	}

	private static var macroManager: MacroManager! {
		return Backdoor.bus?.access()
	}
}
