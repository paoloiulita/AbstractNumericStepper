Pod::Spec.new do |s|
  s.name             = "AbstractNumericStepper"
  s.version          = "0.1.0"
  s.summary          = "Abstract class to extend useful to create numeric steppers using swift"

  s.description      = <<-DESC
This library provides the abstract implementation needed to create numeric steppers using swift
                       DESC

  s.homepage         = "https://github.com/paoloiulita/AbstractNumericStepper"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Paolo Iulita" => "paolo.iulita@gmail.com" }
  s.source           = { :git => "https://github.com/paoloiulita/AbstractNumericStepper.git", :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'AbstractNumericStepper/Classes/**/*'
end
