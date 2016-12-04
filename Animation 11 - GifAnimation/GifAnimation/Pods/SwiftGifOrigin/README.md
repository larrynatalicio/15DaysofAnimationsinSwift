# SwiftGif [![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://developer.apple.com/swift/) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CocoaPods](https://img.shields.io/cocoapods/v/SwiftGifOrigin.svg)](http://cocoadocs.org/docsets/SwiftGifOrigin) [![License MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)](https://github.com/Carthage/Carthage) [![Build Status](https://travis-ci.org/bahlo/SwiftGif.svg?branch=master)](https://travis-ci.org/bahlo/SwiftGif)

A small `UIImage` extension with gif support.

![Demo gif](demo.gif)

## Usage

```swift
// An animated UIImage
let jeremyGif = UIImage.gif(name: "jeremy")

// A UIImageView with async loading
let imageView = UIImageView()
imageView.loadGif(name: "jeremy")
```

## Installation
### CocoaPods
Install [CocoaPods](http://cocoapods.org) with the following command:

```bash
gem install cocoapods
```

Integrate SwiftGif into your Xcode project by creating a `Podfile`:

```ruby
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'SwiftGifOrigin', '~> 1.6.1'
end
```

Run `pod install` to build your dependencies.

### Carthage

Install [Carthage](https://github.com/Carthage/Carthage) with
[Homebrew](http://brew.sh/) using the following command:

```bash
brew update
brew install carthage
```

Add the following line to your `Cartfile` to add SwiftGif:

```ogdl
github "bahlo/SwiftGif" ~> 1.6.1
```

Run `carthage update` to build the framework and drag the built
`SwiftGif.framework` into your Xcode project.


## How does it work?
Easy, it does the following:

1. Find out the duration of every frame
2. Find the greatest common divisor
3. Add frames accordingly to the greatest common divisor to an array
4. Create an animated UIImage with the frames

# Inspiration
This project is heavily inspired by [uiimage-from-animated-gif](https://github.com/mayoff/uiimage-from-animated-gif).
Kudos to [@mayoff](https://github.com/mayoff). :thumbsup:

## License
This repository is licensed under the MIT license, more under
[LICENSE](LICENSE).
