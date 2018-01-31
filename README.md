<p align="center">
  <img src="https://github.com/columbbus/AuthNavigation/blob/master/Assets/LogoHeader.png?raw=true" alt="AuthNavigation Logo"/>
</p>

## Motivation
AuthNavigation was created to simplify the process of login in your app, after a simple setup AuthNavigation organizes the presentation of your custom Login (and Loading) screen.
AuthNavigation is designed so that you can set it up on every ViewController that you want, no matter if it's the entry VC of your app or any other VC. And of course you can also setup AuthNavigation on multiple VC's.


## Components
- `AUAuthenticatableViewController`   : The base class of any VC that you want use AuthNavigation on
- `AULoginViewController`             : The base class for your custom LoginVC
- `AULoadingViewController`           : The base class for your custom LoadingVC
- `AUSegueFade`, `AUSegueFadeUnwind`  : Default implementation of segue animation between the VC's, here with a simple fade.


## Usage

<p align="center">
  <img src="https://github.com/columbbus/AuthNavigation/blob/master/Assets/Flow-detailed.png?raw=true" alt="Login Flow"/>
</p>


## License
See the [LICENSE](LICENSE) file for license rights and limitations (MIT).
