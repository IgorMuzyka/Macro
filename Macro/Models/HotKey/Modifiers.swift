
import Carbon.HIToolbox.Events
import AppKit.NSEvent
import Foundation

public struct Modifiers: OptionSet, Hashable, Equatable, Codable, ExpressibleByIntegerLiteral {

	public static var capsLock: Modifiers { return Modifiers(rawValue: 1 << 16 )}
	public static var shift: Modifiers { return Modifiers(rawValue: 1 << 17 )}
	public static var control: Modifiers { return Modifiers(rawValue: 1 << 18 )}
	public static var option: Modifiers { return Modifiers(rawValue: 1 << 19 )}
	public static var command: Modifiers { return Modifiers(rawValue: 1 << 20 )}
	public static var numericPad: Modifiers { return Modifiers(rawValue: 1 << 21 )}
	public static var help: Modifiers { return Modifiers(rawValue: 1 << 22 )}
	public static var function: Modifiers { return Modifiers(rawValue: 1 << 23 )}

	public let rawValue: UInt64

	public init(rawValue: UInt64) {
		self.rawValue = rawValue
	}

	public init(flags: Flags) {
		self.init(rawValue: flags.rawValue)
	}

	public init(integerLiteral value: UInt64) {
		self.init(rawValue: value)
	}

	// might be incorrect - check this https://github.com/soffes/HotKey/blob/master/Sources/HotKey/NSEventModifierFlags%2BHotKey.swift
    public var carbon: UInt32 {
		return Modifiers.carbonOptions
			.compactMap { modifier, code in contains(modifier) ? code : nil }
			.map(UInt32.init)
			.reduce(0, |)
    }

	public var string: String {
		return String(
			list
				.compactMap { Modifiers.carbonOptions[$0] }
				.map(UInt32.init)
				.compactMap(Unicode.Scalar.init)
				.map(Character.init)
		)
	}

    public var keyEquivalent: String {
		return list
			.compactMap { Modifiers.glyphs[$0] }
			.joined(separator: " ")
    }

	private static var orderedModifiers: [Modifiers] {
		return [.control, .option, .shift, .command]
	}

    public var list: [Modifiers] {
        return Modifiers.orderedModifiers.filter(contains)
    }

    private static var glyphs: [Modifiers: String] {
        return [
            .control: "⌃",
            .option: "⌥",
            .shift: "⇧",
            .command: "⌘"
        ]
    }

	private static var carbonOptions: [Modifiers: Int] {
		return [
			.control: controlKey,
			.option: optionKey,
			.shift: shiftKey,
			.command: cmdKey
		]
	}
}
