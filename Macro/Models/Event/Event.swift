
public struct Event: Codable, CustomStringConvertible {

	public let keyCode: KeyCode
    public let flags: Flags

	public init(keyCode: KeyCode, flags: Flags) {
		self.keyCode = keyCode
		self.flags = flags
	}

    public var description: String {
        return Modifiers(flags: flags).keyEquivalent + .whitespace + keyCode.keyEquivalent
    }
}
