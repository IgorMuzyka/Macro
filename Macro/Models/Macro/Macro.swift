
public class Macro: Codable, CustomStringConvertible {

    public private(set) var events = [Event]()

	public init() {}

    public func record(event: Event) {
        events.append(event)
    }

	public func eraseLast() {
        guard !events.isEmpty else { return }
		events.removeLast()
	}

    public var description: String {
        return events.map { $0.description }.joined(separator: ", ")
    }
}
