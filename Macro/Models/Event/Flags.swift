
public struct Flags: Codable, ExpressibleByIntegerLiteral {

	public let rawValue: UInt64

	public init(_ rawValue: UInt64) {
		self.rawValue = rawValue
	}

	public init(integerLiteral value: UInt64) {
		self.init(value)
	}
}
