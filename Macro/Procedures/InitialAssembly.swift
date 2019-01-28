
import Omnibus

public enum InitialAssembly {

	public static func execute() {
		let macroManager = MacroManager()
		let appDelegate = NSApplication.shared.delegate as! AppDelegate
		let bus = Bus.new { bus in
			bus.install(ModuleWrap(macroManager))
			bus.install(ModuleWrap(appDelegate))
		}
		
		Backdoor.install(on: bus)

		if !macroManager.isAbleToInitializeTap {
			NegotiateAccessibilityAccess(
				success: RelaunchApplication.execute,
				failure: TerminateApplication.execute
			).execute()
		} else {
			RunningAssembly.execute()
		}
	}
}
