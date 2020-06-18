# OpenWeather

Fetch OpenWeather Api to show weather.

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

![minio_SWIFT1](https://github.com/laxmansahni/OpenWeather/blob/master/screenshots.png)

## Version

1.0

## Prerequisites

- Xcode 11.3 or later
- iOS 13.2 or later
- macOS 10.15 or later

## 1. Dependencies

We will be building this app using Xcode 11.3 with Swift 5.0. This app will also consume the OpenWeatherMap API Service built to get the current weather in a specified city.

- Xcode 11.3
- Swift 5.0

## 2. Library Dependencies

- SwiftLint (A tool to enforce Swift style and conventions, loosely based on [GitHub's Swift Style Guide](https://github.com/github/swift-style-guide).)

## 3. Written in Swift

This sample is written in Swift.

## Tools

- [CocoaPods](https://cocoapods.org/) - CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects. It has over 33 thousand libraries and is used in over 2.2 million apps. CocoaPods can help you scale your projects elegantly.
- [SonarQube 7.2.1](https://github.com/Jintin/Swimat) - SonarQube provides the capability to not only show health of an application but also to highlight issues newly introduced. With a Quality Gate in place, you can fix the leak and therefore improve code quality systematically.
- [SwiftLint](https://github.com/realm/SwiftLint) - A tool to enforce Swift style and conventions.
- [Sonar-swift 0.3.7 ](https://github.com/Backelite/sonar-swift) - This is an open source plugin for Apple Swift language support in SonarQube.

## Design Patterns

- ### MVVM

Model-View-ViewModel (MVVM) is one of the building blocks of Cocoa and is undoubtedly the most-used design pattern of all. It classifies objects according to their general role in your application and encourages clean separation of code based on role.

![minio_SWIFT1](https://koenig-media.raywenderlich.com/uploads/2019/12/MVVM-Diagram.png)

- ### Facade

The Facade design pattern provides a single interface to a complex subsystem. Instead of exposing the user to a set of classes and their APIs, you only expose one simple unified API.

![minio_SWIFT1](https://koenig-media.raywenderlich.com/uploads/2013/07/facade2.png)

- ### Decorator

The Decorator pattern dynamically adds behaviors and responsibilities to an object without modifying its code. It’s an alternative to subclassing where you modify a class’s behavior by wrapping it with another object.

In Swift, there are two very common implementations of this pattern: Extensions and Delegation.

## Features

- API class : `WeatherGetter`
- MVC pattern used (recommanded by Apple)
- Ready to fetch others section or period (see `Parameters` struct).
- Modular enough to add others calls from open Weather Map API.
- Ready for background fetch (using `URLSession` with delegate).
- Unit Testing using XCTest
- UI Testing using XCUITest
- CI/CD - Sonar Qube

## Installation

\*Cloning or downloading the repository

- Go to working directory
- Open OpenWeather.xcodeproj
- Use command + B or Product -> Build to build the project
- Press run icon in Xcode or command + R to run the project on Simulator

## Step to run the project from command-line

- Make sure command-line tools of Xcode is installed
- Go to working Directory
- xcodebuild -scheme OpenWeather build -allowProvisioningUpdates

## Step to static code coverage

- Open OpenWeather.xcodeproj
- Use Command+Shift+B or Product+Analyze to analyze the project

![minio_SWIFT1](https://github.com/laxmansahni/OpenWeather/blob/master/unit-test.png)

# Step to execute test cases

- Use Command+U or Product+Test to execute the test case

## Linting

- SwiftLint is used for linting.

## Code Coverage

- Implemented using [SonarQube](https://github.com/Backelite/sonar-swift)

* Installation (once for all your Swift projects)

- Download the plugin binary into the $SONARQUBE_HOME/extensions/plugins directory
- Copy [run-sonar-swift.sh](https://raw.githubusercontent.com/Backelite/sonar-swift/master/sonar-swift-plugin/src/main/shell/run-sonar-swift.sh) somewhere in your PATH
- Restart the SonarQube server.

* Configuration (once per project)

- Copy [sonar-project.properties](https://raw.githubusercontent.com/Backelite/sonar-swift/master/sonar-project.properties) in your Xcode project root folder (along your .xcodeproj file)
- Edit the `sonar-project.properties` file to match your Xcode iOS project

* Update (once per plugin update)

- Install the lastest plugin version
- Copy `run-sonar-swift.sh` somewhere in PATH

![minio_SWIFT1](https://github.com/laxmansahni/OpenWeather/blob/master/sonarqube-coverage.png)

## To Do

### CI/CD

- [Jenkins](http://jenkins.io)
- [Azure DevOps](https://azure.microsoft.com/en-in/services/devops/#DevOps)
- [TestFlight](https://developer.apple.com/testflight/)
- [fastlane](https://fastlane.tools)
- [Xcode Server](https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/xcode_guide-continuous_integration/index.html)

### Crash Reporting

- [AppCenter](https://appcenter.ms/)

## License

Distributed under the MIT license. See `LICENSE` for more information.

[https://github.com/laxmansahni/OpenWeather/blob/master/LICENSE](https://github.com/laxmansahni/OpenWeather/blob/master/LICENSE)

[swift-image]: https://img.shields.io/badge/swift-5.0-orange
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
