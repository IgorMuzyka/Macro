
public struct Shortcut: Codable {
	
	public let keyCode: KeyCode
	public let modifiers: Modifiers

	public init(keyCode: KeyCode, modifiers: Modifiers) {
		self.keyCode = keyCode
		self.modifiers = modifiers
	}
}

extension Shortcut {

	/// CMD + SHIFT + `
	public static var commandShiftTick: Shortcut {
		return Shortcut(keyCode: 50, modifiers: [.command, .shift])
	}

	/// CMD + `
	public static var commandTick: Shortcut {
		return Shortcut(keyCode: 50, modifiers: .command)
	}
}

extension Shortcut: CustomStringConvertible {

	public var description: String {
		return modifiers.keyEquivalent + " " + keyCode.keyEquivalent
	}
}
