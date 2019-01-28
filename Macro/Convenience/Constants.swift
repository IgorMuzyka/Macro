
public enum Constants {

    public enum MenuBar {

        public static let record = "Record"
        public static let stop = "Stop"
        public static let play = "Play"
        public static let save = "Save"
        public static let about = "About"
        public static let quit = "Quit"
        public static let preferences = "Preferences"
        public static let enableRunAtStartup = "Enable Run at Startup"
        public static let runAtStartup = "Run at Startup"
        public static let sendFeedback = "Send Feedback"
    }

    public enum Launcher {

        public static let bundleIdentifier = "igormuzyka.Macro.Launcher"
		public static let path = "/Contents/Library/LoginItems/MacroLauncher.app"
    }

    public enum Utility {
        
        public static let openAppPath = "/usr/bin/open"
        public static let accessibilityPreferencePaneLink = "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"
    }

    public enum App {

        public static let mailtoLink = "mailto:igormuzyka42@gmail.com"

        public static let about = """
        Macro helps you perform text editing by recording the keyboard events you produce and reproducing them when you need by a shortcut.

        Special thanks to Sergi Callini for app and menu bar icons.
        """

        public static let name = "Macro"
        public static let author = "Igor Muzyka"
    }

    public enum Dialogue {

        public enum PreferencePanePrompt {

            public static let message = "Macro can not run without Accessibility access"
            public static let text = "Please come back to this dialog and press done when you done providing accessibility access to application"
            public static let confirmation = "Open System Preference Pane"
            public static let cancellation = "Quit"
        }

        public enum AccessibilityAccessPrompt {
            public static let message = "Macro can not run without Accessibility access"
            public static let text = "Please open prefernce pane and provide accessibility access to Macro app otherwise it would not be able to serve you"
            public static let confirmation = "Done"
            public static let cancellation = "Quit"
        }
    }
}

extension String {

    public static let whitespace: String = " "
    public static let doubleWhitespace: String = .whitespace + .whitespace
}
