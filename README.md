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

