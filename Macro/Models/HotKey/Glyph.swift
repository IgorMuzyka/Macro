
public enum Glyph: UInt16, Codable {

	case eject = 0x23CF
	case clear = 0x2715
	case deleteLeft = 0x232B
	case deleteRight = 0x2326
	case leftArrow = 0x2190
	case rightArrow = 0x2192
	case upArrow = 0x2191
	case downArrow = 0x2193
	case escape = 0x238B
	case help = 0x003F
	case pageDown = 0x21DF
	case pageUp = 0x21DE
	case tabRight = 0x21E5
	case `return` = 0x2305
	case returnR2L = 0x21A9
	case padClear = 0x2327
	case northwestArrow = 0x2196
	case southeastArrow = 0x2198

	public var string: String {
		return keyCodeString(rawValue)
	}
}
