This library is mean to be a general grab bag of Swift methods made by the engineers at IntrepidPursuits.  As this library goes, useful components will be isolated into separate podspecs where appropriate.

The reason for the grab bag approach is to make it easier to facilitate the adding of materials and encourage componentization and sharing of common functionality.

```
source 'https://github.com/IntrepidPursuits/swift-wisdom.git'
pod 'IntrepidSwiftWisdom'
use_frameworks!
```

####Contributions

All contributions and updates are welcome!  Here's some basic guidelines when submitting an addition:

- Submit via a Pull Request documenting the addition
- Follow appropriate folder conventions
- Prefix all extension methods and variables with `ip_` to avoid namespacing.  Swift namespacing doesn't apply the same way to extensions and prefixes help avoid issues.
- Document functionality if it is ambiguous
