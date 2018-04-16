<p align="center">
  <img src="https://github.com/columbbus/AuthNavigation/blob/master/Assets/demo.gif?raw=true" alt="AuthNavigation Demo" height="800"/>
</p>

<p align="center">
  <img src="https://img.shields.io/cocoapods/v/AuthNavigation.svg" alt="CocoaPods Compatible" style="padding:10px"/>
  <img src="https://img.shields.io/cocoapods/p/AuthNavigation.svg" alt="Platform" style="padding:10px"/>
  <img src="https://img.shields.io/badge/Swift-4.1-orange.svg" alt="Swift Version" style="padding:10px"/>
  <img src="https://img.shields.io/cocoapods/l/AuthNavigation.svg" alt="License" style="padding:10px"/>
</p>




## AuthNavigation

AuthNavigation is an iOS library, that organizes the login process in your app, making it easy to implement auto-login. AuthNavigation automatically checks if your user needs to login or not and presents the correct screens based on the result.

AuthNavigation can also organize loading screen, i.e. if you need to make server requests.

You can setup AuthNavigation on one or more `UIViewController`'s, it can authenticate the whole screen or just parts of it.

AuthNavigation is not a replacement for `UINavigationController`, in fact you can use both side by side.




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

* **Basic:** Your `HostVC` is protected by a login screen, let's call it `LoginVC`. As soon as `HostVC` is presented, it will check, wether login is needed or not and will eventually present the `LoginVC`.

* **Advanced:** The same functionality as *Basic* + presenting a `LoadingVC` while checking wheter login is needed or not (may be useful if you have to request a server if user should pass or not)

Follow the below steps to use AuthNavigation:


### Short Instructions

1. *Project:* Create 2 VC's for *Basic* and 3 for *Advance* (Specify unique Storybard ID's for each)
3. *HostVC:* Create an `AUAuthNavigator` instance
4. *HostVC:* Make the class conform to `AUAuthenticatable` protocol, set the delegate and implement the two methods
5. *HostVC:* Set the Storyboard ID's to the corresponding properties of your `authNavigator`
6. *HostVC:* Call `startAuthentication` in `viewWillAppear` and call `stopAuthentication` in `viewDidDisappear`
7. *LoginVC:* Call `finishLogin(success: Bool)` when your login process is done
8. *LoadingVC:* Call `finishLoading` when your loading process is done


### Complete Instrcutions

1. **Setting up VC's:** You need to create minimum 2 VC's in Interface Builder and their related controller classes, one is your `HostVC` and the other is your `LoginVC`. If you want a loading screen, you have to create a third VC, which we will name `LoadingVC`

2. **Creating `AUAuthNavigatorInstance`:** In your `HostVC` you need an instance of `AUAuthNavigator`. If you only use AuthNavigation on one of your VC's in your app it's a good practice to use the `sharedInstance` from the class itself. If you use AuthNavigation multiple times in your app you should create your own instance. because your `LoginVC` and `LoadingVC` will need the same instance as `HostVC` it's a good idea, to declare the instance as a `static` variable in `HostVC` and use this in the other classes like `HostVC.authNavigator`.

3. **Setting up `HostVC`:** Your `HostVC` class needs to conform to the `AUAuthenticatable` protocol. In `viewDidLoad` set the delegate of your `AUAuthNavigator` instance, let's call it `authNavigator`.  
 Next set the Storyboard ID's (`loginVCId` and if you want `loadingVCId`).  
 To actually use the authenticator, call `authNavigator.startAuthentication()` in `viewWillAppear` and `authNavigator.stopAuthentication()` in view.  
 Now implement the 2 methods of the protocol:
    * `shouldLogin`: Here you implement your authentication process. If your user needs to login, return true, if he is already logged in return false
    * `willReturnFromLoginActions`: This method is called when returning from the `LoginVC`. You can run additional actions if you need to. If not leave the method body empty.

4. **Setting up `LoginVC`:** After finishing your login process call `authNavigator.finishLogin(success: Bool)`. A good practice is to handle wrong inputs on the login site itself rather than calling `...finishLogin(false)`, because AuthNavigator will then only show the login screen again.

6. **Setting up `LoadingVC`:** After finishing your loading process call `authNavigator.finishLoading`.


**Logout**: Call `logout(presentLoading: Bool)` in your to `HostVC`. If `presentLoading` is set to `true`, the loading screen will be presented, if it's set to `false`, the login screen will be presented directly.


### Additional settings

* **`hostView`:** This is the container view for your login and loading screen, setting this to a specific view in your `HostVC` can be useful if you don't want the entire screen to be covered by the authentication. By default it's set to the entire screen.
* **`overlayColor`:** The overlay is used to hide the content of your `HostVC` during authorization. If you need this overlay to have a special color, then specify it here. Default behaviour is to use the background color of the `hostView`.
* **`animationDuration`:** Here you can specify a custom duration for all animations done by AUAuthNavigator (overlay, login and loading fade in/out).




## License
See the [LICENSE](LICENSE) file for license rights and limitations (MIT).

More on the motivation for this project can be found in [this](https://medium.com/@pascal.braband/navigating-your-ios-app-through-login-51c88e2329d3) article.
