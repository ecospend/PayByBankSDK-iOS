# # ExampleFlutter
### Environment Setup

### Install flutter
```
brew install flutter
```

### Install pods
`pod init`   if needed

`pod install`

## Be Sure

### add
```
#include "Pods/Target Support Files/Pods-Runner/Pods-Runner.debug.xcconfig"
```
### to
iOS/Flutter/Debug.xcconfig

### and add
```
#include "Pods/Target Support Files/Pods-Runner/Pods-Runner.release.xcconfig"
#include "Pods/Target Support Files/Pods-Runner/Pods-Runner.profile.xcconfig"
```
### to
iOS/Flutter/Release.xcconfig

## Run application
In iOS folder:

```
flutter run
``` 
## **OR**
## Open Runner.xcworkspace and run.