
public class MacroManager {

	public let watcher = FrontmostApplicationWatcher()

    private lazy var keyboard: KeyboardProtocol = { return CGKeyboard() }()
    public lazy var coordinator = {
        Coordinator(
            eventInterceptor: EventInterceptor(handledEventTypes: [.keyDown]),
            keyboard: keyboard
        )
    }()

	public func setup() {
		coordinator.eventInterceptor.enable()
	}

	public func play() {
		guard let lastKnownFrontmostApplication = watcher.lastKnownFrontmostApplication else {
			return
		}

		try? coordinator.play(for: lastKnownFrontmostApplication)
	}

	public func stop() {
		try? coordinator.stop()
	}

	public func record() {
		try? coordinator.record()
	}

	public var isAbleToInitializeTap: Bool {
		return coordinator.eventInterceptor.tap != nil
	}
}
