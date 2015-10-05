
Pod::Spec.new do |s|
  s.name             = "OBBlurPicker"
  s.version          = "1.0.2"
  s.summary          = "OBBlurPicker is an attractive, full screen picker widget."

  s.description      = <<-DESC
                        OBBlurPicker was written because most attempts to integrate a UIPickerView into a UI look wonky
                        and out of place. This was designed to be a drop in solution to that problem.
                       DESC

  s.homepage         = "https://github.com/Openbay/OBBlurPicker"
  s.license          = 'MIT'
  s.author           = { "Ryan Popa" => "rp@openbay.com" }
  s.source           = { :git => "https://github.com/Openbay/OBBlurPicker.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resources = 'Pod/Assets/*.xib'

  s.frameworks = 'UIKit'
  s.dependency 'UIImageEffects'
end
