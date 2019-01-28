
import MenuBar

public final class AppMenuBar: MenuBar {

	public init() {
		super.init(descriptors: [])
	}

	public func handle(state: State, macro: Macro?) {
		image = icon(for: state)
		descriptors = MainMenu.assemble(for: state, with: macro)
	}

	private func icon(for state: State) -> NSImage {
		let icon = NSImage(named: state.rawValue)!
		icon.isTemplate = true
		return icon
	}
}

