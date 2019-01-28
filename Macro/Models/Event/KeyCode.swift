
import Carbon.HIToolbox.Events

public struct KeyCode: Equatable, Hashable, Codable, ExpressibleByIntegerLiteral {

	public let rawValue: UInt16

	public init(_ rawValue: UInt16) {
		self.rawValue = rawValue
	}

	public init(integerLiteral value: UInt16) {
		self.init(value)
	}

    public var carbon: UInt32 {
        return rawValue == NSNotFound ? 0 : UInt32(rawValue)
    }

	public var string: String {
		let value: String
		switch Int(rawValue) {
		case kVK_F1: value = keyCodeString(0xF704)
		case kVK_F2: value = keyCodeString(0xF705)
		case kVK_F3: value = keyCodeString(0xF706)
		case kVK_F4: value = keyCodeString(0xF707)
		case kVK_F5: value = keyCodeString(0xF708)
		case kVK_F6: value = keyCodeString(0xF709)
		case kVK_F7: value = keyCodeString(0xF70a)
		case kVK_F8: value = keyCodeString(0xF70b)
		case kVK_F9: value = keyCodeString(0xF70c)
		case kVK_F10: value = keyCodeString(0xF70d)
		case kVK_F11: value = keyCodeString(0xF70e)
		case kVK_F12: value = keyCodeString(0xF70f)
		case kVK_F13: value = keyCodeString(0xF710)
		case kVK_F14: value = keyCodeString(0xF711)
		case kVK_F15: value = keyCodeString(0xF712)
		case kVK_F16: value = keyCodeString(0xF713)
		case kVK_F17: value = keyCodeString(0xF714)
		case kVK_F18: value = keyCodeString(0xF715)
		case kVK_F19: value = keyCodeString(0xF716)
		case kVK_Space: value = keyCodeString(0x20)
		default: value = ""
		}
		return value.lowercased()
	}

	public var keyEquivalent: String {
		var value: String = ""

		switch Int(rawValue) {
		case NSNotFound: value = ""
		case kVK_F1: value = "F1"
		case kVK_F2: value = "F2"
		case kVK_F3: value = "F3"
		case kVK_F4: value = "F4"
		case kVK_F5: value = "F5"
		case kVK_F6: value = "F6"
		case kVK_F7: value = "F7"
		case kVK_F8: value = "F8"
		case kVK_F9: value = "F9"
		case kVK_F10: value = "F10"
		case kVK_F11: value = "F11"
		case kVK_F12: value = "F12"
		case kVK_F13: value = "F13"
		case kVK_F14: value = "F14"
		case kVK_F15: value = "F15"
		case kVK_F16: value = "F16"
		case kVK_F17: value = "F17"
		case kVK_F18: value = "F18"
		case kVK_F19: value = "F19"
		case kVK_Space: value = "Space"
		case kVK_Escape: value = Glyph.escape.string
		case kVK_Delete: value = Glyph.deleteLeft.string
		case kVK_ForwardDelete: value = Glyph.deleteRight.string
		case kVK_LeftArrow: value = Glyph.leftArrow.string
		case kVK_RightArrow: value = Glyph.rightArrow.string
		case kVK_UpArrow: value = Glyph.upArrow.string
		case kVK_DownArrow: value = Glyph.downArrow.string
		case kVK_Help: value = Glyph.help.string
		case kVK_PageUp: value = Glyph.pageUp.string
		case kVK_PageDown: value = Glyph.pageDown.string
		case kVK_Tab: value = Glyph.tabRight.string
		case kVK_Return: value = Glyph.returnR2L.string

		// Keypad
		case kVK_ANSI_Keypad0: value = "0"
		case kVK_ANSI_Keypad1: value = "1"
		case kVK_ANSI_Keypad2: value = "2"
		case kVK_ANSI_Keypad3: value = "3"
		case kVK_ANSI_Keypad4: value = "4"
		case kVK_ANSI_Keypad5: value = "5"
		case kVK_ANSI_Keypad6: value = "6"
		case kVK_ANSI_Keypad7: value = "7"
		case kVK_ANSI_Keypad8: value = "8"
		case kVK_ANSI_Keypad9: value = "9"
		case kVK_ANSI_KeypadDecimal: value = "."
		case kVK_ANSI_KeypadMultiply: value = "*"
		case kVK_ANSI_KeypadPlus: value = "+"
		case kVK_ANSI_KeypadClear: value = Glyph.padClear.string
		case kVK_ANSI_KeypadDivide: value = "/"
		case kVK_ANSI_KeypadEnter: value = Glyph.return.string
		case kVK_ANSI_KeypadMinus: value = "-"
		case kVK_ANSI_KeypadEquals: value = "="

		// Hardcode
		case 119: value = Glyph.southeastArrow.string
		case 115: value = Glyph.northwestArrow.string

		default: break
		}

		if !value.isEmpty {
			return value.uppercased()
		}

		guard
			let keystroke = keyName(scanCode: rawValue),
			CharacterSet.keystrokeValid.validate(string: keystroke)
		else {
			return value.uppercased()
		}

		return keystroke.uppercased()
	}
}
