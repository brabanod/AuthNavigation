Pod::Spec.new do |s|
  s.name             = 'AuthNavigation'
  s.version          = '1.1.3'
  s.summary          = 'Delivers basic structure for login process'

  s.description      = <<-DESC
AuthNavigation was created to simplify the process of login in your app, after a simple setup AuthNavigation organizes the presentation of your custom Login and Loading screen.
                       DESC

  s.homepage         = 'https://github.com/columbbus/AuthNavigation.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pascal Braband' => 'pascal.braband@googlemail.com' }
  s.source           = { :git => 'https://github.com/columbbus/AuthNavigation.git', :tag => s.version.to_s }

  s.platform              = :ios
  s.ios.deployment_target = '10.0'

  s.source_files = "Source/*.{swift}"
  s.framework    = "UIKit"

end
