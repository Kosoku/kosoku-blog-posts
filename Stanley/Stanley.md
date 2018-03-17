# Stanley

This is the first in a series of posts covering the variety of open source frameworks available on [Kosoku's GitHub](https://github.com/Kosoku).

First up is [Stanley](https://github.com/Kosoku/Stanley), a framework which mainly extends the `Foundation` framework and is available on iOS, tvOS, watchOS, and macOS. This post will highlight various facilities available in the framework.

## Macros

*KSTScopeMacros.h* provides a few useful macros to avoid typing out key paths and avoid those tricky retain cycles when dealing with blocks. For example:

```
NSString *nameKeyPath = @kstKeypath(self,name); // this will throw a compiler error if name isn't defined on self

// assume block is a property defined on self
kstWeakify(self);
self.block = ^{
	kstStrongify(self);
	// you can refer to self normally without creating a retain cycle
	self.name = @"John Wick";
};
```

## Functions

*KSTGeometryFunctions.h* provides functions to manipulate `CGRect` and `NSRect` structures. For example:

```
CGRect rect1 = ...; // assume this exists
CGRect rect2 = ...; // assume this exists
CGRect centerRect = KSTCGRectCenterInRect(rect1, rect2); // center rect1 within rect2
```

## Categories

The *NSData+KSTExtensions.h* category provides methods to easily get the cyrptographic hash of the receiver's bytes. Methods are provided for **MD5**, **SHA1**, **SHA256**, and **SHA512** string hashes. For example:

```
NSData *data = ...; // assume this exists
NSString *MD5Hash = data.KST_MD5String;

// do something with your hashed string
```

The *NSFileManager+KSTExtensions.h* category provides methods to get directory URLs for commonly accessed locations, like Application Support, Caches, and Documents. For example:

```
NSURL *directoryURL = NSFileManager.defaultManager.KST_applicationSupportDirectoryURL;

// do something with the directory URL
```

The *NSHTTPURLResponse+KSTExtensions.h* category provides constants for all the HTTP response codes which you can use to check against response codes and errors returned by network requests. For example:

```
NSHTTPURLResponse *response = ...; // assume this exists

if (response.statusCode == KSTHTTPStatusCodeCreated) {
	// something was created, act accordingly
}
```

## Classes

*KSTDirectoryWatcher.h* provides a wrapper around the `FSEvents` framework on macOS. You provide it an array of directory URLs, some options, and a block. It will invoke that block whenever anything happens within any of the directories you provided upon initialization. For example:

```
NSArray<NSURL *> *URLs = ...; // assume this exists
KSTDirectoryWatcher *watcher = [[KSTDirectoryWatcher alloc] initWithURLs:URLs flags:KSTDirectoryWatcherEventFlagsItemCreated block:^(KSTDirectoryWatcher *directoryWatcher, KSTDirectoryWatcherEventID eventID, KSTDirectoryWatcherEventFlags flags, NSURL *URL){
	// a file was created, scan the directory
}];

// this tells `FSEvents` to start monitoring the directory URLs
[watcher startWatchingURLs];
```

*KSTFileWatcher.h* provides a wrapper around **Grand Central Dispatch** file sources and is available on all the platforms (iOS/tvOS/watchOS/macOS). You supply it an array of file URLs, some options, and a block. It will invoke that block whenever any of the files are modified. For example:

```
NSArray<NSURL *> *URLs = ...; // assume this exists
KSTFileWatcher *watcher = [[KSTFileWatcher alloc] initWithURLs:URLs flags:KSTFileWatcherFlagsWrite|KSTFileWatcherFlagsExtend|KSTFileWatcherFlagsRename block:^(KSTFileWatcher *fileWatcher, NSURL *URL, KSTFileWatcherFlags flags){
	// the file at URL was written to or renamed, act accordingly
}];
```

*KSTPhoneNumberFormatter.h* is an `NSFormatter` subclass that generates nicely formatted phone numbers, even as the user types (and on iOS, if you use another handy Kosoku library [KSOTextValidation](https://github.com/Kosoku/KSOTextValidation)). It is locale aware, but falls back to `en_US` formatting if necessary. For example:

```
NSString *phoneNumber = @"1234567890";
NSString *formatted = [KSTPhoneNumberFormatter.sharedFormatter localizedStringFromPhoneNumber:phoneNumber];

NSLog(@"%@",formatted); // prints @"(123) 456-7890"
```

*KSTReachabilityManager.h* provides a wrapper around the network reachability APIs that are part of the `SystemConfiguration` framework on iOS/tvOS/macOS. It can monitor the reachability of network resources and post notifications when things change. You can use the `sharedManager` for generic reachability or use one of the init methods to create your own instance for a specific network resource. For example:

```
KSTReachabilityManager *reachability = [[KSTReachabilityManager alloc] initWithDomain:@"https://myawesomedomain.com"];

[reachability startMonitoringReachability];

// listen for KSTReachabilityManagerNotificationDidChangeStatus to see when things change
```

*KSTTimer.h* aims to be a replacement for `NSTimer`, it uses **Grand Central Dispatch** and doesn't retain its target like `NSTimer` does. It supplies methods that match the API provided by `NSTimer` as well as block support.

```
// timer is a property defined on self
self.timer = [KSTTimer scheduledTimerWithTimeInterval:1.0 block:^(KSTimer *timer){
	// this block is invoked on each timer fire
} userInfo:nil repeats:YES queue:nil];
```

Those are just a few of the highlights. Stay tuned for additional articles in the series highlighting Kosoku frameworks!