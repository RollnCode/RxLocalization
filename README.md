# RxLocalization
## Usage
__RxLocalization__ allows you to easily localize your application with Rx. You will never care again about complexity of user-driven language changes.

You define your `Localizable.strings` as always. Bu instead of 

```swift
@IBOutlet weak var doneButton: UIBarButtonItem!
...
doneButton.title = NSLocalizedString("STR_DONE", comment: "")
```

you are able to write 

```swift
import RxL10n
...
@IBOutlet weak var doneButton: UIBarButtonItem!
...
L("STR_DONE")
    .bind(to: doneButton.rx.title)
    .disposed(by: disposeBag)
```

And when your user wants to change language of the application just do:

```swift
Localization.current.value = Localization(langCode: "pl")
```

All other magic Rx will do for you for free.

## Requirements

This library depends on __RxSwift__ and __Foundation__.


## Installation
### [Carthage](https://github.com/Carthage/Carthage)

Add this to `Cartfile`

```
github "RollnCode/RxLocalization"
```
And run

```bash
$ carthage update
```

## License

RxLocalization is available under the MIT license. See the LICENSE file for more info.