
import AppKit.NSApplication
import Omnibus

public enum TerminateApplication {

	public static func execute() {
		HotKey.teardown()
		Backdoor.uninstall(from: Backdoor.bus)
		NSApp.terminate(self)		
	}
}
