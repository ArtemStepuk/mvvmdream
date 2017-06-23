## Motivation

Just yet another one MVVM example with cross platform implementation, unit tests and ui tests.

## Installation

Currently project is using Carthage and Pods as dependency managers (pods decommissioning is in plan).

- git clone git@github.com:ArtemStepuk/mvvmdream.git
- cd mvvmdream
- carthage update --platform iOS,macOS 
- open rx.xcworkspace   

Dependencies are:

 - RxSwift/RxCocoa
 - Swinject
 - FBSnapshotTestCase (for iosAppTests target)

Project targets:

- iosApp - iOS application
- macosApp - macOS application
- CommonIOS - framework for iOS (same code base as in CommonMac)
- CommonMac - framework for macOS (same code base as in CommonIOS)
- CommonIOSTests - unit test for common business logic.
- iosAppTests - ui tests (snapshots) for iOS app.
- Utils - jazzy/swiftlint/synx scripts run.

other stuff can be ignored for now.
