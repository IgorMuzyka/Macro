
import Foundation.NSURL

public enum RelaunchApplication{

	public static func execute() {
		let url = URL(fileURLWithPath: Bundle.main.resourcePath!)
		let path = url.deletingLastPathComponent().deletingLastPathComponent().absoluteString
		let task = Process()

		task.launchPath = Constants.Utility.openAppPath
		task.arguments = [path]
		task.launch()

		TerminateApplication.execute()
	}
}
