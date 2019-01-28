
public protocol CoordinatorProtocol {

	typealias StateUpdate = (State, Macro?) -> Void

	var state: State { get }
	var macro: Macro? { get }

	var stateUpdateHandler: StateUpdate? { get set }

	func record() throws
	func stop() throws
	func play(for application: RunningApplication) throws
}
