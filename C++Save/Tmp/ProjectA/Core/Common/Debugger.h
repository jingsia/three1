#ifndef Foundation_Debugger_INCLUDED
#define Foundation_Debugger_INCLUDED


#include "Platform.h"



class Debugger
	/// The Debugger class provides an interface to the debugger.
	/// The presence of a debugger can be checked for,
	/// messages can be written to the debugger's log window
	/// and a break into the debugger can be enforced.
	/// The methods only work if the program is compiled
	/// in debug mode (the macro _DEBUG is defined).
{
public:
	static bool isAvailable();
		/// Returns true if a debugger is available, false otherwise.
		/// On Windows, this function uses the IsDebuggerPresent()
		/// function.
		/// On Unix, this function returns true if the environment
		/// variable _ENABLE_DEBUGGER is set.
		/// On OpenVMS, this function always returns true in debug,
		/// mode, false otherwise.

	static void message(const std::string& msg);
		/// Writes a message to the debugger log, if available, otherwise to
		/// standard error output.

	static void message(const std::string& msg, const char* file, int line);
		/// Writes a message to the debugger log, if available, otherwise to
		/// standard error output.

	static void enter();
		/// Breaks into the debugger, if it is available.
		/// On Windows, this is done using the DebugBreak() function.
		/// On Unix, the SIGINT signal is raised.
		/// On OpenVMS, the SS$_DEBUG signal is raised.

	static void enter(const std::string& msg);
		/// Writes a debug message to the debugger log and breaks into it.

	static void enter(const std::string& msg, const char* file, int line);
		/// Writes a debug message to the debugger log and breaks into it.

	static void enter(const char* file, int line);
		/// Writes a debug message to the debugger log and breaks into it.
};


#endif // Foundation_Debugger_INCLUDED
