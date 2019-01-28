
import CoreFoundation.CFMachPort

public protocol EventInterceptorProtocol {

	typealias EventHandler = (Event) -> Void

	var eventHandler: EventHandler? { get set }
	var tap: CFMachPort! { get }

	func enable()
}
