# infocus

[![swift-version](https://img.shields.io/badge/Swift-5.0-brightgreen)](https://developer.apple.com/documentation/swift) ![macos-version](https://img.shields.io/badge/macOS-11+-blue) [![xcode-version](https://img.shields.io/badge/xcode-13.1-red)](https://developer.apple.com/xcode/)

![install](https://user-images.githubusercontent.com/3598965/133254387-74923520-32c7-48c2-ad98-916ab2f77ad3.png)

## What

Small app for Mac Admins that checks focus status under macOS 11 and 12 and can be used to add Do Not Disturb support to management scripts.

Infocus runs from the command line. If the user has a Focus mode set, infocus exits with code 1, otherwise exits with code 0

For a pre-built preview, check the [Releases](https://github.com/bartreardon/infocus/releases) page.

## Why

Because you're a nice #MacAdmin that doesn't want to disturb your users with some popup or other event that ordinarily wouldn't adhear to macOS Notification framework.

## How

Through the Magic of Swift! on macOS 11 it reads a local plist to get DND data. Under macOS 12 it uses the communications notifications entitlements but because of app sandbox rules that come with adding the entitlements, required for macOS 12, there is a seperate `infocuscli` binary included in the app bundle for use on macOS 11. Within the sandbox the app can't read the local plist. Fun.


## Demo

The following script will run the correct version for the OS, check focus state and exit if focus/DND is enabled

```zsh
#!/bin/zsh

infocusapppath="/Applications/Utilities/infocus.app"

autoload is-at-least
if is-at-least 12.0 $(sw_vers -productVersion); then
    infocus="${infocusapppath}/Contents/MacOS/infocus"
else
    infocus="${infocusapppath}/Contents/Resources/infocuscli"
fi

# Running Infocus - if DND is enabled (i.e. exit code is 1), then exit
if [[ -e ${infocus} ]]; then
  ${infocus} || exit 0
else
  echo "Infocus is not installed - Do Not Disturb preferences will not be considered" 
fi

# ... continuing with the rest of the script if focus/DND is not enabled.
# ...

```
