
public struct HotKeyService {

	public let recordOrStop: HotKey
	public let play: HotKey

	public init() {
		recordOrStop = HotKey(.commandShiftTick, handler: RecordOrStopMacro.execute)
		play = HotKey(.commandTick, handler: PlayMacro.execute)
	}

	public func setup() {
		register()
		HotKey.setup()
	}

	private func register() {
		recordOrStop.register()
		play.register()
	}
}
