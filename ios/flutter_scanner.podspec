#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_scanner.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_scanner'
  s.version          = '0.0.1'
  s.summary          = 'A new qr canner Flutter plugin.'
  s.description      = <<-DESC
A new qr canner Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  # (https://github.com/mikebuss/MTBBarcodeScanner)
  s.dependency 'MTBBarcodeScanner'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
