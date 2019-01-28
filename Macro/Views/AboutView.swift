
import AppKit.NSView

public class AboutView: NSView {

	@IBOutlet private var applicationName: NSTextField!
	@IBOutlet private var versionInfo: NSTextField!
	@IBOutlet private var about: NSTextField!

	public struct Info {

		public struct Version: CustomStringConvertible {

			let major: UInt
			let minor: UInt
			let patch: UInt

			public var description: String {
				let dot = "."
				return "\(major)" + dot + "\(minor)" + dot + "\(patch)"
			}
		}

		public let version: Version
		public let build: UInt
		public let about: String
		public let applicationName: String
		public let authors: [String]
	}

	public func set(info: Info) {
		let space = " "
		let newLine = "\n"
		var authors = ""

		if info.authors.count > 0 {
			authors = "Created by " + info.authors.first!
		} else if info.authors.count > 1 {
			authors = "Created by " + info.authors.joined(separator: ", ")
		}

		versionInfo.stringValue =
			"Version" + space + info.version.description + space + 
			"(Build" + space + "\(info.build))" + space
		about.stringValue =
			authors + newLine + newLine +
			info.about + newLine + newLine
		applicationName.stringValue = info.applicationName
	}
}
