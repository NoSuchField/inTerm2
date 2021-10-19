//
//  main.m
//  inTerm2
//
//  Created by Leon Li on 10/19/21.
//  Copyright © 2021 Leon Li. All rights reserved.
//

#import "Finder.h"
#import "iTerm2.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        FinderApplication* finder = [SBApplication applicationWithBundleIdentifier:@"com.apple.Finder"];
        
        iTerm2Application* terminal = [SBApplication applicationWithBundleIdentifier:@"com.googlecode.iterm2"];
                
        FinderItem *target = [(NSArray*)[[finder selection] get] firstObject];
        FinderFinderWindow* findWin = [[finder FinderWindows] objectAtLocation:@1];
        findWin = [[finder FinderWindows] objectWithID:[NSNumber numberWithInteger: findWin.id]];
        bool selected = true;
        if (target == nil){
            target = [[findWin target] get];
            selected = false;
        }
        
        if ([[target kind] isEqualToString:@"Alias"]){
            target = (FinderItem*)[(FinderAliasFile*)target originalItem];
        }
        
        NSString* fileUrl = [target URL];
        if(fileUrl != nil && ![fileUrl hasSuffix:@"/"] && selected){
            fileUrl = [fileUrl stringByDeletingLastPathComponent];
        }
        
        NSURL* url = [NSURL URLWithString:fileUrl];
        if (url != nil){
            NSString * command = [NSString stringWithFormat:@"%@%@%@", @" cd ", url.path, @" && clear\n"];
            [terminal createWindowWithDefaultProfileCommand:(nil)];
            iTerm2Window *newWin = [terminal currentWindow];
            [newWin.currentSession writeContentsOfFile:nil text:command newline:NO];
            [terminal activate];
         }
    }
}
