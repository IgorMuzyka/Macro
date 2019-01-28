
import Dispatch
import CoreGraphics.CGEvent

public struct CGKeyboard: KeyboardProtocol {

	public func simulate(macro: Macro, for application: RunningApplication) {
        let now: DispatchTime = .now()

        macro.events.enumerated()
            .map {
				return ((now + .milliseconds($0.offset)), cgEvent(for: $0.element))
            }
            .forEach { delay, event in
                DispatchQueue.main.asyncAfter(deadline: delay, execute: {
                    event.postToPid(application.processIdentifier)
                })
            }
	}

    private func cgEvent(for event: Event) -> CGEvent {
        let cgEvent = CGEvent(keyboardEventSource: nil, virtualKey: event.keyCode.rawValue, keyDown: true)!

        cgEvent.flags = CGEventFlags(rawValue: event.flags.rawValue)

        return cgEvent
    }
}
