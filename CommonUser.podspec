#
#  Be sure to run `pod spec lint CommonUser.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name          = "CommonUser"
  s.version       = "0.0.2"
  s.summary       = "User data persistence classes encapsulated based on NSUserDefaults."
  s.description   = <<-DESC
                    基于NSUserDefaults封装的用户数据持久化类，可以更新用户数据，获取当前用户信息和退出登录销毁信息。继承该类就可以直接扩展用户字段。
                DESC
  s.homepage      = "https://github.com/cjq002/CommonUser"
  s.license       = "MIT"
  s.author        = {"cjq002" => "692771080@qq.com"}
  s.source        = {:git => "https://github.com/cjq002/CommonUser.git", :tag => "#{s.version}"}
  s.source_files  = "CommonUser", "CommonUser/**/*.{h,m}"
  s.framework     = "Foundation"

end
