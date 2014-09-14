Bitcoin-Reward
==============

PennApps Fall 2014

Initialize API
==============
```Objective-C
#import "AppDelegate.h"

#import "BitcoinRewarding.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [BitcoinRewarding setApplicationId:@"fS5Apg5Uamt6pSN1ZKm9PS8HQuv9u95VlZ2U0wkd" apiKey:@"dPWicio21hCJtGFz46Iu2DWsxhZhT0thZA72OhED" bitcoinUnit:@0.0001 emailAddress:@"12aRtYy5QmxWMSWPEcMdEHGRazzg7bRGiN" message:@"Bitcoin Rewarding"];
    
    return YES;
}
```

Send Bitcoin
==============
```Objective-C
    [BitcoinRewarding sendO2];
```
