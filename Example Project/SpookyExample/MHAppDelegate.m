#import "MHAppDelegate.h"
#import "Spooky.h"

@implementation MHAppDelegate
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [self.window spook];
    return YES;
}
@end
