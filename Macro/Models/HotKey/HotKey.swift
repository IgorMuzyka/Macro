
import Carbon.HIToolbox.Events

public class HotKey {

	public typealias Handler = () -> Void

	public private(set) static var hotKeys = [UInt32: HotKey]()
    private static let signature: UInt32 = { "MaCR".utf16.reduce(FourCharCode(0), { ($0 << 8) + FourCharCode($1) }) }()
    private static var count: UInt32 = 0
	private static var eventHandler: EventHandlerRef!
	private static let tap = HotKey.Tap()

    public let shortcut: Shortcut
	public let handler: Handler

	private let id: EventHotKeyID
    private var hotKeyRef: EventHotKeyRef!

	public init(_ shortcut: Shortcut, handler: @escaping Handler) {
        self.shortcut = shortcut
		self.handler = handler
		self.id = EventHotKeyID(signature: HotKey.signature, id: HotKey.count)
		HotKey.count += 1
    }

	deinit {
		unregister()
	}

	@discardableResult
    public func register() -> OSStatus {
        var ref: EventHotKeyRef?
        let error = RegisterEventHotKey(
            shortcut.keyCode.carbon,
            shortcut.modifiers.carbon,
            id,
            GetEventDispatcherTarget(),
            OptionBits(0),
            &ref
        )

        guard error == noErr, let reference = ref else { return error }

        hotKeyRef = reference
		HotKey.hold(self)
		return noErr
    }

    public func unregister() {
		HotKey.dismiss(self)
        UnregisterEventHotKey(hotKeyRef)
    }

	public static func setup() {
		let eventSpec = [
//			EventTypeSpec(eventClass: OSType(kEventClassKeyboard), eventKind: UInt32(kEventHotKeyPressed)),
			EventTypeSpec(eventClass: OSType(kEventClassKeyboard), eventKind: UInt32(kEventHotKeyReleased))
		]
		let tap = UnsafeMutableRawPointer(Unmanaged.passUnretained(HotKey.tap).toOpaque())

		InstallEventHandler(GetEventDispatcherTarget(), { (_, event: EventRef?, userInfo: UnsafeMutableRawPointer?) -> OSStatus in
			guard
				let event = event,
				let pointer = userInfo
			else { return OSStatus(eventNotHandledErr) }

			let tap = Unmanaged<HotKey.Tap>.fromOpaque(pointer).takeUnretainedValue()

			return tap.handle(event: event)

		}, 2, eventSpec, tap, &eventHandler)
	}

	public static func teardown() {
		RemoveEventHandler(eventHandler)
	}

	public static func hold(_ hotKey: HotKey) {
		hotKeys[hotKey.id.id] = hotKey
	}

	public static func dismiss(_ hotKey: HotKey) {
		hotKeys.removeValue(forKey: hotKey.id.id)
	}

	public static func hotKey(for identifier: UInt32) -> HotKey? {
		return hotKeys[identifier]
	}
}

extension HotKey {

	private class Tap {

		public init() {}

		public func handle(event: EventRef) -> OSStatus {
			var id = EventHotKeyID()
			let error = GetEventParameter(
				event,
				UInt32(kEventParamDirectObject),
				UInt32(typeEventHotKeyID),
				nil,
				MemoryLayout<EventHotKeyID>.size,
				nil,
				&id
			)

			guard error == noErr else {
				return error
			}

			guard
				id.signature == HotKey.signature,
				let hotKey = HotKey.hotKey(for: id.id)
			else { return OSStatus(eventNotHandledErr) }

			switch GetEventKind(event) {
			case UInt32(kEventHotKeyPressed), UInt32(kEventHotKeyReleased):
				hotKey.handler()
				return noErr
			default:
				return OSStatus(eventNotHandledErr)
			}
		}
	}
}
