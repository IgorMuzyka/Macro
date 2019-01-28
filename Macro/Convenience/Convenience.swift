
import Carbon.HIToolbox.Events

extension CharacterSet {

	internal static var keystrokeValid: CharacterSet {
		return CharacterSet().union(.alphanumerics).union(punctuationCharacters).union(.symbols)
	}

	internal func validate(string: String) -> Bool {
		let scalars = string.flatMap { $0.unicodeScalars }

		return scalars.count == scalars.filter(contains).count
	}
}

@inline(__always) internal func keyCodeString(_ keyCode: UInt16) -> String {
	return String(format: "%C", keyCode).uppercased()
}

@inline(__always) internal  func keyName(scanCode: UInt16) -> String? {
	let maxNameLength = 4
	var nameBuffer = [UniChar](repeating: 0, count: maxNameLength)
	var nameLength = 0

	let modifierKeys = UInt32(alphaLock >> 8) & 0xFF
	var deadKeys: UInt32 = 0
	let keyboardType = UInt32(LMGetKbdType())

	let source = TISCopyCurrentKeyboardLayoutInputSource().takeRetainedValue()
	guard let ptr = TISGetInputSourceProperty(source, kTISPropertyUnicodeKeyLayoutData) else {
		return nil
	}
	let layoutData = Unmanaged<CFData>.fromOpaque(ptr).takeUnretainedValue() as Data
	let osStatus = layoutData.withUnsafeBytes {
		UCKeyTranslate($0, scanCode, UInt16(kUCKeyActionDown),
					   modifierKeys, keyboardType, UInt32(kUCKeyTranslateNoDeadKeysMask),
					   &deadKeys, maxNameLength, &nameLength, &nameBuffer)
	}
	guard osStatus == noErr else {
		return nil
	}

	return String(utf16CodeUnits: nameBuffer, count: nameLength)
}
