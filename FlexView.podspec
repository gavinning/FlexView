Pod::Spec.new do |s|

  s.name         = "FlexView"
  s.version      = "0.3.1"
  s.summary      = "Auto layout like html flexbox."
  s.homepage     = "https://github.com/gavinning/FlexView"
  s.license      = "MIT"
  s.author       = { "gavinning" => "ningyubo@gmail.com" }
  s.source       = { :git => "https://github.com/gavinning/FlexView.git", :tag => s.version }
  s.platform     = :ios, "10.0"
  s.framework    = "UIKit"
  s.source_files = "Sources/*.swift"

  s.dependency "GLEKit"

end
