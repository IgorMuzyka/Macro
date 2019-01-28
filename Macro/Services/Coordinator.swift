
open class Coordinator: CoordinatorProtocol {

	public private(set) var state: State = .idle {
		didSet {
			issueStateUpdate()
		}
	}
	public private(set) var macro: Macro?
	public var stateUpdateHandler: StateUpdate?

	public private(set) var eventInterceptor: EventInterceptorProtocol
	private let keyboard: KeyboardProtocol

	public init(eventInterceptor: EventInterceptorProtocol, keyboard: KeyboardProtocol) {
		self.eventInterceptor = eventInterceptor
		self.keyboard = keyboard
	}

	public func record() throws {
		guard state == .idle else { throw CoordinatorError.recordingCanBeInvokedOnlyWhenIdle }

		reset()

		eventInterceptor.eventHandler = handle
		state = .recording
	}

	public func stop() throws {
		guard state == .recording else { throw CoordinatorError.stopCanBeInvokedOnlyWhenRecording }

		eventInterceptor.eventHandler = nil
		state = .idle
	}

	public func play(for application: RunningApplication) throws {
		guard state == .idle else { throw CoordinatorError.playbackCanBeInvokedOnlyWhenIdle }
		guard let macro = macro else { throw CoordinatorError.thereIsNoRecordedMacroToBePlayed }

		state = .playing

		keyboard.simulate(macro: macro, for: application)

		state = .idle
	}

    public func load(_ loadedMacro: Macro) {
        macro = loadedMacro
        state = .idle
    }

    private func issueStateUpdate() {
        stateUpdateHandler?(state, macro)
    }

	private func reset() {
		macro = Macro()
	}

	private func handle(event: Event) {
		guard state == .recording else { return }

        macro?.record(event: event)
	}
}

public enum CoordinatorError: Error {

	case recordingCanBeInvokedOnlyWhenIdle
	case stopCanBeInvokedOnlyWhenRecording
	case playbackCanBeInvokedOnlyWhenIdle
	case thereIsNoRecordedMacroToBePlayed
}
