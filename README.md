<p align="center">
  <img src="https://github.com/columbbus/AuthNavigation/blob/master/Assets/LogoHeader.png?raw=true" alt="AuthNavigation Logo"/>
</p>

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


## Usage
There are two ways to use AuthNavigation:

* **Basic:** Your `MainVC` is protected by a login screen, let's call it `LoginVC`. As soon as `MainVC` is presented, it will check, wether login is needed or not and will eventually present the `LoginVC`.

* **Advanced:** The same functionality as *Basic* + presenting a `LoadingVC` while checking wheter login is needed or not (may be useful if you have to request a server if user should pass or not)


Follow the below steps to use AuthNavigation:

1. **Setting up VC's:** You need to create 2 VC's in Interface Builder and their related controller classes, one is your `MainVC` and the other is your `LoginVC`. If you want a loading screen, you have to create a third VC, which we will name `LoadingVC`

2. **Setting up segues:** For Basic, you need to create a segue from `MainVC` to `LoginVC`, set it's type to *custom* and the class to `AUSegueFade`. Also create an unwind segue for `LoginVC`, set the class to `AUSegueFadeUnwind`. If you want a loading screen, to the same from `MainVC` to `LoadingVC` and the unwind segue. Don't forget to give all segues identifiers.

3. **Creating `AUAuthNavigatorInstance`:** In your `MainVC` you need an instance of `AUAuthNavigator`. If you only use AuthNavigation on one of your VC's in your app it's a good practice to use the `sharedInstance` from the class itself. If you use AuthNavigation multiple times in your app you should create your own instance. because your `LoginVC` and `LoadingVC` will need the same instance as `MainVC` it's a good idea, to declare the instance as a `static` variable in `MainVC` and use this in the other classes like `MainVC.authNavigator`.

4. **Setting up `MainVC`:** 




## License
See the [LICENSE](LICENSE) file for license rights and limitations (MIT).
