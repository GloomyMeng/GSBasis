# GSBasis

[![CI Status](https://img.shields.io/travis/gloomy.meng.049@gmail.com/GSBasis.svg?style=flat)](https://travis-ci.org/gloomy.meng.049@gmail.com/GSBasis)
[![Version](https://img.shields.io/cocoapods/v/GSBasis.svg?style=flat)](https://cocoapods.org/pods/GSBasis)
[![License](https://img.shields.io/cocoapods/l/GSBasis.svg?style=flat)](https://cocoapods.org/pods/GSBasis)
[![Platform](https://img.shields.io/cocoapods/p/GSBasis.svg?style=flat)](https://cocoapods.org/pods/GSBasis)


- [Others](#other)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Others

### [GSNetwork](https://github.com/GloomyMeng/GSNetwork) 
```
A simple network components. simple and clear API usage.
Support diverse data structure returns while guaranteeing type checking. 
Unified error types and standard error handling.
```

## Features

- [] Category, SPM installation
- [] Logger store
- [x] etc..

## Requirements

- iOS 10.0+ / macOS 10.12+ / tvOS 10.0+ / watchOS 3.0+
- Xcode 10.2+
- Swift 5+

## Usage

GSBasis is basic components of the GS series components which can add into a new project or existing project. Provide some methods and logic that I use most.

```
Hope can help everyone who likes and enjoys swift
```

### GSBasis/Common

- [x] 'Compatible' support a namespace for use
- [x] 'Error' defined suggested error protocol and error cause protocol
- [x] 'Extensions' a few extension for which i think need to placed 
- [x] 'GSDefaults' a simple, easy use tool for using UserDefaults
- [x] 'Logger' a canonical log output that supports simple log grading and supports Cocoapod module differentiation
- [x] 'Notifier' use enum for define Notification.Name, and extension methods for monitor notification Simply
- [x] 'Time' a way to streamline time calculations
- [x] 'Typealiases' alias ​​used by multiple platforms

### GSBasis/UIKit

- [x] 'Localize' a simple solution for implement multiple languages support
- [x] 'UICompatible' define some methods about UI by Compatible
- [x] 'UITypealiases' alias ​​used by multiple platforms abount UI
- [x] 'UIExtensions' a few extension about UI 

### GSBasis/FatModel

Reduce the controller's code in this way, and reduce coupling.
Specification of where to initialize, where to set data.
Support other GS modules for easy expansion and use

- [x] 'Protocols' just protocol define
- [x] 'TemplateClass' just protocol implementation base class

## Installation

### Cocoapods

GSBasis is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GSBasis'
```

## Document 
More detail is here, document created by [jazzy](https://github.com/realm/jazzy):

[Document](https://gloomymeng.io/GSBasis/)

## License

GSBasis is available under the MIT license. See the LICENSE file for more info.
