[![Build Status](http://ci.intrepid.io:8080/buildStatus/icon?job=Swift Wisdom)](http://ci.intrepid.io:8080/job/Swift%20Wisdom/)
[![Coverage](http://ci.intrepid.io:9913/jenkins/cobertura/Swift%20Wisdom/)](http://ci.intrepid.io:8080/job/Swift%20Wisdom/cobertura/)

This library is meant to be a general grab bag of Swift methods made by the engineers at IntrepidPursuits.  As this library goes, useful components will be isolated into separate podspecs where appropriate.

The reason for the grab bag approach is to make it easier to facilitate the adding of materials and encourage componentization and sharing of common functionality.

### Core

```Ruby
pod 'Intrepid'
```

### Subspecs

```Ruby
pod 'Intrepid/Rx' # Intrepid's RxSwift Extensions
```

### Testing Additions

```Ruby
source 'https://github.com/IntrepidPursuits/intrepid-wisdom.git'
target 'SwiftWisdomTests',
    use_frameworks!
    pod 'IntrepidSwiftWisdomTesting'
end
```

### Components

* [Qu](#qu)
* [After](#after)
* [Nib Initable](#nib-initable)
* [Color Descriptor](#color-descriptor)
* [Cell Configuring](#cell-configuring)
* [User Defaults](#user-defaults)
* [Result](#result)

#### Qu

A basic wrapper for dispatch operations in Swift.  Syntax example:

```Swift
    Qu.Background {
        // Sleep for long operation
        sleep(4)
        log("1")
    } .Also {
        sleep(4)
        log("2")
    } .Also {
        sleep(1)
        log("3")
    } .Also {
        sleep(1)
        log("4")
    } .Also {
        sleep(1)
        log("5")
    } .ThenAfter(.Previous(3)) {
        log("6: After 5, 4, & 3")
    } .Then {
        sleep(1)
        log("7: After 6")
    } .FinallyOn(.Main) {
        sleep(1)
        log("Finished: After All")
    }
```

#### After

A simple way to perform or repeat future operations:

```Swift
After(2.5) {
  print("Two and a half seconds later")
}

RepeatAtInterval(1.0, numberOfTimes: 5) {
  print("Once a second, 5 times")
}
```

#### Nib Initable

Load views from nibs:

```Swift
let myCustomView = MyCustomView.fromNib()
```

#### Color Descriptor

Setup Easy Color Schemes.  Note, if you're using Zeplin that it auto generates color schemes if you'd like

```Swift
enum ColorPalette : ColorDescriptor {
    case White = "254,216,130,255"
    case DarkGreen = "51,58,24,255"
    case DarkGray = "64,48,56,255"
    case BrightWhite = "#ffffff"

    var color: UIColor {
        return rawValue.color
    }
}
```

And use:

```Swift
someView.backgroundColor = ColorPalette.White.color
```

#### Cell Configuring

A simple way to cover most table view registering / dequeing

##### Register

```Swift
tableView.ip_registerCell(YourCell.self)
tableView.ip_registerHeader(YourHeader.self)
```

##### Dequeue

```Swift
let cell: YourCell = tableView.ip_dequeueCell(indexPath)
//
let header: YourHeader = tableView.ip_dequeueHeader(section)
```

#### User Defaults

A way to read and write from defaults simply and type-safe

##### Define

```Swift
enum Setting : String, EnumSettingsKeyAccessible {
    case DisplayName
    case LastOpenDate
}
```

##### Read

```Swift
let displayName: String? = Setting.DisplayName.readFromDefaults
```

##### Write

```Swift
Setting.DisplayName.writeToDefaults(displayName)
```

##### Implement

```Swift
struct ApplicationSettings {
    var displayName: String {
        get {
            return Setting.DisplayName.readFromDefaults ?? ""
        }
        set {
            Setting.DisplayName.writeToDefaults(newValue)
        }
    }
}
```

#### Result

As opposed to using objective-c style async completion blocks like `(possibleObject: AnyObject?, error: NSError?)`, Result types are preferable:

```Swift
func fetchName(completion: Result<String> -> Void)
```

And use:

```Swift
fetchName { result in
    switch result {
    case let .Success(name):
        print("Successfully got name: \(name)")
    case let .Failure(error):
        print("Failed to get name: \(error)")
    }

}
```

#### Time Of Day

Used to convert times of day back and forth from NSDate

To Time

```Swift
let date = ...
let timeOfDay = TimeOfDay(date)
// or

let timeOfDay = TimeOfDay("1:30")
```

To Date:

```Swift
let timeOfDay = ...

// Time Today
let todayAtThatTime = timeOfDay.timeToday()

// Time on given date
let someDate = ...
let timeOnThatDate = timeOfDay.timeOnDate(someDate)
```

#### Contributions

All contributions and updates are welcome!  Here's some basic guidelines when submitting an addition:

- Submit via a Pull Request documenting the addition
- Follow appropriate folder conventions
- Prefix all extension methods and variables with `ip_` to avoid namespacing.  Swift namespacing doesn't apply the same way to extensions and prefixes help avoid issues.
- Document functionality if it is ambiguous
- Bump podspec and tag on branch before merging
- On approval, push the podspec to trunk using `pod trunk push Intrepid.podspec`.
