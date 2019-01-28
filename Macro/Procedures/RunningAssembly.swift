
import Omnibus

public enum RunningAssembly {

	public static func execute() {
		guard let bus = Backdoor.bus else { fatalError("you must be dumb if this happened") }

		let menuBar = AppMenuBar()
		let hotKeys = HotKeyService()

		bus.install(ModuleWrap(menuBar))
		bus.install(ModuleWrap(hotKeys))


		menuBar.handle(state: .idle, macro: nil)
		macroManager.coordinator.stateUpdateHandler = menuBar.handle
		macroManager.setup()
		hotKeys.setup()
	}

	private static var macroManager: MacroManager! {
		return Backdoor.bus?.access()
	}
}
