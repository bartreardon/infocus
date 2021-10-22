# infocus

![install](https://user-images.githubusercontent.com/3598965/133254387-74923520-32c7-48c2-ad98-916ab2f77ad3.png)

## What

Small app for Mac Admins that checks focus status under macOS 12 and can be used to add Do Not Disturb support to management scripts.

Infocus runs from the command line. If the user has a Focus mode set, infocus exits with code 1, otherwise exits with code 0

For a pre-built preview, check the [Releases](https://github.com/bartreardon/infocus/releases) page.

## Why

Because you're a nice #MacAdmin that doesn't want to disturb your users with some popup or other event that ordinarily wouldn't adhear to macOS Notification framework.

## How

In theory this should run under macOS 10.15/11 (or earlier?...untested). Because of app sandbox rules that come with adding the communications notifications entitlements required for macOS 12, there is a seperate `infocuscli` binary included in the app bundle.


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
