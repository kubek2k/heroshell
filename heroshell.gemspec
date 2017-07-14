Gem::Specification.new do |s|
    s.name        = 'heroshell'
    s.version     = '0.0.1'
    s.date        = '2017-07-14'
    s.summary     = 'Heroku command shell'
    s.description = 'Heroku command shell'
    s.authors     = ['Jakub Janczak (@kubek2k)']
    s.email       = 'kubek2k@gmail.com'
    s.files       = ['lib/heroshell.rb']
    s.executables << 'heroshell'
    s.homepage    = 'http://rubygems.org/gems/heroshell'
    s.license       = 'MIT'

    s.add_runtime_dependency 'rainbow', '2.2.2'
end
