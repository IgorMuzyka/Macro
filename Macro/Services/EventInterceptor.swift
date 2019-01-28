
import CoreGraphics.CGEvent
import CoreFoundation.CFRunLoop

public final class EventInterceptor: EventInterceptorProtocol {

	public var eventHandler: EventHandler?
	public let handledEventTypes: [CGEventType]

	public init(handledEventTypes: [CGEventType]) {
		self.handledEventTypes = handledEventTypes
	}

    public func enable() {
		let source = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0)!
		CFRunLoopAddSource(CFRunLoopGetCurrent(), source, .commonModes)
		CGEvent.tapEnable(tap: tap, enable: true)
	}

	public lazy var tap: CFMachPort! = {
		return CGEvent.tapCreate(
			tap: .cghidEventTap,
			place: .headInsertEventTap,
			options: .listenOnly,
			eventsOfInterest: mask,
			callback: { (proxy: OpaquePointer, type: CGEventType, event: CGEvent, userInfo: UnsafeMutableRawPointer?) -> Unmanaged<CGEvent>? in
				guard let pointer = userInfo else { return Unmanaged.passUnretained(event) }
				let interceptor = Unmanaged<EventInterceptor>.fromOpaque(pointer).takeUnretainedValue()
				return interceptor.handle(proxy: proxy, type: type, cgEvent: event)
		},
			userInfo: UnsafeMutableRawPointer(Unmanaged.passRetained(self).toOpaque())
		)
	}()

	private lazy var mask: CGEventMask = {
		return handledEventTypes
			.map { UInt64(1) << $0.rawValue }
			.reduce(UInt64(0), |)
	}()

	private func handle(proxy: OpaquePointer, type: CGEventType, cgEvent: CGEvent) -> Unmanaged<CGEvent>? {
        let event = Event(
            keyCode: KeyCode(UInt16(cgEvent.getIntegerValueField(.keyboardEventKeycode))),
            flags: Flags(cgEvent.flags.rawValue)
        )

		if handledEventTypes.contains(type) {
			eventHandler?(event)
		}
		return Unmanaged.passRetained(cgEvent)
	}
}
