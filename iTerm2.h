/*
 * iTerm2.h
 */

#import <AppKit/AppKit.h>
#import <ScriptingBridge/ScriptingBridge.h>

@class iTerm2Application, iTerm2Window, iTerm2Session;

@protocol iTerm2GenericMethods
- (void) writeContentsOfFile:(NSURL *)contentsOfFile text:(NSString *)text newline:(BOOL)newline;  // Send text as though it was typed.
@end

/*
 * Standard Suite
 */

// The application's top-level scripting object.
@interface iTerm2Application : SBApplication
@property (copy) iTerm2Window *currentWindow;  // The frontmost window
- (iTerm2Window *) createWindowWithDefaultProfileCommand:(NSString *)command;  // Create a new window with the default profile
@end

// A window.
@interface iTerm2Window : SBObject <iTerm2GenericMethods>
@property (copy) iTerm2Session *currentSession;  // The current session in a window
@end

/*
 * iTerm2 Suite
 */

// A terminal tab
@interface iTerm2Tab : SBObject <iTerm2GenericMethods>
@property (copy) iTerm2Session *currentSession;  // The current session in a tab
@end

// A terminal session
@interface iTerm2Session : SBObject <iTerm2GenericMethods>
@end

