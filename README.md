# ListPlaceholder

[![Version](https://img.shields.io/cocoapods/v/ListPlaceholder.svg?style=flat)](http://cocoapods.org/pods/ListPlaceholder)
[![License](https://img.shields.io/cocoapods/l/ListPlaceholder.svg?style=flat)](http://cocoapods.org/pods/ListPlaceholder)
[![Platform](https://img.shields.io/cocoapods/p/ListPlaceholder.svg?style=flat)](http://cocoapods.org/pods/ListPlaceholder)

<h1 align="center">ListPlaceholder</h1>
<h3 align="center">Facebook news feed style animation</h3>

<p align="center">
<img src="https://github.com/malkouz/ListPlaceholder/raw/master/demo.gif"/>
</p>


## Features
ListPlaceholder is a swift library allows you to easily add facebook style animated loading placeholder to your tableviews, collection views or custom views.

## Installation

### CocoaPods (Recommended)

1. Install [CocoaPods](https://cocoapods.org)
2. Add this repo to your `Podfile`

```ruby
target 'Example' do
# IMPORTANT: Make sure use_frameworks! is included at the top of the file
use_frameworks!
platform :ios, '8.0'
pod 'ListPlaceholder'
end
```
3. Run `pod install`
4. Open up the `.xcworkspace` that CocoaPods created
5. Done!

### Manually

Simply download the `ListLoader.swift` file from [here](https://github.com/malkouz/ListPlaceholder/blob/master/ListPlaceholder/Classes/ListLoader.swift) into your project, make sure you point to your projects target

### Usage

```swift
import ListPlaceholder
```
UITableView usage
```swift
//to show the loader
tableView.reloadData()
tableView.showLoader()

//to hide the loader
tableView.hideLoader()
```

UICollectionView usage
```swift
//to show the loader
collectionView.reloadData()
collectionView.layoutIfNeeded()
collectionView.showLoader()

//to hide the loader
collectionView.hideLoader()
```

UIView usage
```swift
//to show the loader

customView.showLoader()

//to hide the loader
customView.hideLoader()
```

Also the placeholder is now supporting in Objective-C language
```Objective-C

@import ListPlaceholder;

//to show the loader
[_customView showLoader];
//to hide the loader
[_customView hideLoader];
```


## Example project

Take a look at the example project over here

1. Download it
2. Open the `Example.xcworkspace` in Xcode
3. Enjoy!

## Author

Moayad Al kouz, moayad_kouz9@hotmail.com

## License

ListPlaceholder is available under the MIT license. See the LICENSE file for more info.
