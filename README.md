<p align="center">
  <img src="https://github.com/columbbus/AuthNavigation/blob/master/Assets/LogoHeader.png?raw=true" alt="AuthNavigation Logo"/>
</p>

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/AuthNavigation.svg)](https://img.shields.io/cocoapods/v/AuthNavigation.svg)
[![Platform](https://img.shields.io/cocoapods/p/AuthNavigation.svg)](https://cocoapods.org/pods/AuthNavigation)

## Motivation
AuthNavigation was created to simplify the process of login in your app, after a simple setup AuthNavigation organizes the presentation of your custom Login (and Loading) screen.

AuthNavigation is designed so that you can set it up on every ViewController that you want, no matter if it's the entry VC of your app or any other VC. And of course you can also setup AuthNavigation on multiple VC's.
Another feature of AuthNavigation is that you can integrate a loading screen very simple. This may be needed if you have to request a server in order to know if login is needed or not.


## What it's not
AuthNavigation does not give you ready-to-use login and loading screen templates. AuthNavigation gives the navigation structure to create a simple login process with additional loading page, the design has to be done independently.


## Flow
This is a summary of the login flow in a simple diagram:

<p align="center">
  <img src="https://github.com/columbbus/AuthNavigation/blob/master/Assets/Flow-detailed.png?raw=true" alt="Login Flow"/>
</p>


## Installation

### Manual

You can simply drag the files from the `Source` folder into you project and use the classes.

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. To integrate AuthNavigation into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'AuthNavigation', '~> 1.1'
end
```


## Usage
There are two ways to use AuthNavigation:

* **Basic:** Your `MainVC` is protected by a login screen, let's call it `LoginVC`. As soon as `MainVC` is presented, it will check, wether login is needed or not and will eventually present the `LoginVC`.

* **Advanced:** The same functionality as *Basic* + presenting a `LoadingVC` while checking wheter login is needed or not (may be useful if you have to request a server if user should pass or not)


Follow the below steps to use AuthNavigation:

### Short Instructions

1. *Projetc:* Create 2 VC's for *Basic* and 3 for *Advance*
2. *Interface Builder:* Connect all VC's with segues and unwinding segues (Main <-> Login, Main <-> Loading)
3. *MainVC:* Create a `AUAuthNavigator` instance
4. *MainVC:* Make the class conform to `AUAuthenticatable` protocol and implement the two methods
5. *MainVC:* Set the segue names to the corresponding properties of your `authNavigator`
6. *MainVC:* Call `startAuthentication` in `viewWillAppear` and call `stopAuthentication` in `viewDidDisappear`
7. *LoginVC:* Set `loginDelegate` to self and call `finishLogin(success: Bool)` when your login process is done
8. *LoadingVC:* Set `loadingDelegate` to self and call `finishLoading` when your loading process is done


### Complete Instrcutions

1. **Setting up VC's:** You need to create 2 VC's in Interface Builder and their related controller classes, one is your `MainVC` and the other is your `LoginVC`. If you want a loading screen, you have to create a third VC, which we will name `LoadingVC`

2. **Setting up segues:** For Basic, you need to create a segue from `MainVC` to `LoginVC`, set it's type to *custom* and the class to `AUSegueFade`. Also create an unwind segue for `LoginVC`, set the class to `AUSegueFadeUnwind`. If you want a loading screen, to the same from `MainVC` to `LoadingVC` and the unwind segue. Don't forget to give all segues identifiers.

3. **Creating `AUAuthNavigatorInstance`:** In your `MainVC` you need an instance of `AUAuthNavigator`. If you only use AuthNavigation on one of your VC's in your app it's a good practice to use the `sharedInstance` from the class itself. If you use AuthNavigation multiple times in your app you should create your own instance. because your `LoginVC` and `LoadingVC` will need the same instance as `MainVC` it's a good idea, to declare the instance as a `static` variable in `MainVC` and use this in the other classes like `MainVC.authNavigator`.

4. **Setting up `MainVC`:** Your `MainVC` class needs to conform to the `AUAuthenticatable` protocol. In `viewDidLoad` set the delegate of your `AUAuthNavigator` instance, let's call it `authNavigator`.  
 Next set all the segue names (`loginSegueID`,  `loginUnwindSegueID` and if you want `loadingSegueID`, `loadingUnwindSegueID`).  
 To actually use the authenticator, call `authNavigator.startAuthentication()` in `viewWillAppear` and `authNavigator.stopAuthentication()` in view.  
 Now implement the 2 methods of the protocol:
    * `shouldLogin`: Here you implement your authentication process. If your user needs to login, return true, if he is already logged in return false
    * `willReturnFromLoginActions`: This method is called when returning from the `LoginVC`. You can run additional actions if you need to. If not leave the method body empty.

5. **Setting up `LoginVC`:** Set the `authNavigator.loginDelegate` to `self`. If you've finished your login process call `authNavigator.finishLogin(success: Bool)`. A good practice is to handle wrong inputs on the login site itself rather than calling `...finishLogin(false)`, because AuthNavigator will then only show the login screen again.

6. **Setting up `LoadingVC`:** Set the `authNavigator.loadingDelegate` to `self`. If you've finished your loading process call `authNavigator.finishLoading`.




## License
See the [LICENSE](LICENSE) file for license rights and limitations (MIT).
