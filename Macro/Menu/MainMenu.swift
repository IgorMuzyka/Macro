
import MenuBar

public enum MainMenu {

	public static func assemble(for state: State, with macro: Macro?) -> [Descriptor] {
		return [
			recordOrStop(for: state),
			play(for: state, with: macro),
			.separator,
			PreferencesMenu.assemble(),
			about,
			.separator,
			quit
		]
	}

	private static func recordOrStop(for state: State) -> Descriptor {
		let title = state == .idle ? Constants.MenuBar.record : Constants.MenuBar.stop

		return .item([
			.title(title + .doubleWhitespace + Shortcut.commandShiftTick.description),
			.enabled(state == .idle || state == .recording),
			.action(RecordOrStopMacro.execute)
		])
	}

	private static func play(for state: State, with macro: Macro?) -> Descriptor {
		return .item([
			.title(Constants.MenuBar.play + .doubleWhitespace + Shortcut.commandTick.description),
			.enabled(state == .idle && macro != nil && !(macro?.events.isEmpty ?? true)),
			.action(PlayMacro.execute)
		])
	}

	private static var about: Descriptor {
		return .item([
			.title(Constants.MenuBar.about),
			.action(PresentAbout.execute)
		])
	}

	private static var quit: Descriptor {
		return .item([
			.title(Constants.MenuBar.quit),
			.action(TerminateApplication.execute)
		])
	}
}
