<p align="center">
  <img src="https://github.com/columbbus/AuthNavigation/blob/master/Assets/LogoHeader.png?raw=true" alt="AuthNavigation Logo"/>
</p>

## Motivation
AuthNavigation was created to simplify the process of login in your app, after a simple setup AuthNavigation organizes the presentation of your custom Login (and Loading) screen.
AuthNavigation is designed so that you can set it up on every ViewController that you want, no matter if it's the entry VC of your app or any other VC. And of course you can also setup AuthNavigation on multiple VC's.
Another feature of AuthNavigation is that you can integrate a loading screen very simple. This may be needed if you have to request a server in order to know if login is needed or not.


## Components
- `AUAuthenticatableViewController`   : The base class of any VC that you want use AuthNavigation on
- `AULoginViewController`             : The base class for your custom LoginVC
- `AULoadingViewController`           : The base class for your custom LoadingVC
- `AUSegueFade`, `AUSegueFadeUnwind`  : Default implementation of segue animation between the VC's, here with a simple fade.


## Usage
In order to you AuthNavigation on one of your VC's, follow these steps:

Let's say you have a VC called `SecretVC`. In order to use login you will also need a specified VC for this, we call it `SecretLoginVC`.

#### Integrating `AUAuthenticatableViewController`:
Subclass it -> then specify loginSegueID and loadingSegueID if you want. Implement shouldLogin method

#### Integrating `AULoginViewController`:

#### Integrating `AULoadingViewController`:




## Flow
This is a summary of the login flow in a simple diagram:

<p align="center">
  <img src="https://github.com/columbbus/AuthNavigation/blob/master/Assets/Flow-detailed.png?raw=true" alt="Login Flow"/>
</p>


## License
See the [LICENSE](LICENSE) file for license rights and limitations (MIT).
