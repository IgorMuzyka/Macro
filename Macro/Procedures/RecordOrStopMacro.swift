
import AppKit.NSApplication
import Omnibus

public enum RecordOrStopMacro {

	public static func execute() {
		DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
			if macroManager.coordinator.state == .recording {
				macroManager.coordinator.macro?.eraseLast()
				macroManager.stop()
			} else if macroManager.coordinator.state == .idle {
				macroManager.record()
			}
		})
	}

	private static var macroManager: MacroManager! {
		return Backdoor.bus?.access()
	}
}
