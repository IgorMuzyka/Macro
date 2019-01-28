
public struct NegotiateAccessibilityAccess {

	private let success: () -> Void
	private let failure: () -> Void

	public init(success: @escaping () -> Void, failure: @escaping () -> Void) {
		self.success = success
		self.failure = failure
	}

	public func execute() {
		if PromptUserToOpenPreferencePane.execute() {
			OpenAccessibilityPreferencePane.execute()

			if PromptUserToConfirmAccessibilityAccess.execute() {
				success()
			} else {
				failure()
			}
		} else {
			failure()
		}
	}
}
