#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
#
Pod::Spec.new do |s|
  s.name             = 'ZeticMLange'
  s.version          = '1.2.2'
  s.summary          = 'ZeticMLange Framework'
  s.homepage         = 'https://github.com/zetic-ai/ZeticMLangeiOS'
  s.author           = { 'Zetic AI' => 'software@zetic.ai' }
  s.source           = { :http => 'https://github.com/zetic-ai/ZeticMLangeiOS/releases/download/1.2.2/ZeticMLange.xcframework.zip' }
  s.platform = :ios, '15.0'
  s.vendored_frameworks = 'ZeticMLange.xcframework'
end
