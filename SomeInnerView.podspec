Pod::Spec.new do |s|
  s.name = 'SomeInnerView'
  s.version = '1.0.2'
  s.license = 'MIT'
  s.summary = 'Make selection on image'
  s.homepage = 'https://github.com/smakeev/SomeInnerView'
  s.authors = { 'Sergey Makeev' => 'makeev.87@gmail.com' }
  s.source = { :git => 'https://github.com/smakeev/SomeInnerView.git', :tag => s.version }
  s.documentation_url = 'https://github.com/smakeev/SomeInnerView/wiki'

  s.ios.deployment_target = '10.0'

  s.swift_versions = ['5.1']

  s.source_files = 'SomeInnerView/SomeInnerView/*.swift'
end
