Pod::Spec.new do |s|
  s.name             = 'draw_on_image_plugin'
  s.version          = '0.1.0'
  s.summary          = 'Flutter plugin for drawing text on images.'
  s.description      = 'Flutter plugin for drawing text on images.'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Nikolai' => 'nikolaiko@mail.ru' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'path_provider'
  s.platform = :ios, '8.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
