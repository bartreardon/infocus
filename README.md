# infocus

![install](https://user-images.githubusercontent.com/3598965/133254387-74923520-32c7-48c2-ad98-916ab2f77ad3.png)

## What

Small app for Mac Admins that checks focus status under macOS 12 and can be used to add Do Not Sisturb support to management scripts.

Infocus runs from the command line. If the user has a Focus mode set, infocus exits with code 1, otherwise exits with code 0

For a pre-built preview, check the [Releases](https://github.com/bartreardon/infocus/releases) page.

## Why

Because you're a nice #MacAdmin that doesn't want to disturb your users with some popup or other event that ordinarily wouldn't adhear to macOS Notification framework.

## How

In theory this should run under macOS 10.15/11 (or earlier?...untested). Because of app sandbox rules that come with adding the communications notifications entitlements required for macOS 12, there is a seperate `infocuscli` binary included in the app bundle.


