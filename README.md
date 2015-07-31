Originally, adding public extensions to standard Swift types wasn't working, but it appears to be running at the moment.  If that changes in the future, we'll have to find a new way to share this code.  For the moment, cocoapods is running appropriately.

This library currently uses Swift features only available in Xcode 7+.  Until this pod is officially added to `intrepid-wisdom`, add this to your Podfile:

```
pod 'SwiftWisdom', :git => 'https://github.com/intrepidpursuits/swift-wisdom.git'
```

**Note**

To use this library, you must add the following line to your `Podfile`:

```
use_frameworks!
```

####Contributions

All contributions and updates are welcome!  Here's some basic guidelines when submitting an addition:

- Submit via a Pull Request documenting the addition
- Follow appropriate folder conventions
- Only include extensions for the moment.  If you have a more self contained class, it should probably have its own library.
- Prefix all extension methods and variables with `ip_` to avoid namespacing.  Swift namespacing doesn't apply the same way to extensions and prefixes help avoid issues.
- Document functionality if it is ambiguous
