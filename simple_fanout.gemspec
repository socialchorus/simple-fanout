Gem::Specification.new do |s|
  s.name        = 'simple_fanout'
  s.version     = '0.0.0'
  s.date        = '2014-03-21'
  s.summary     = "Fanout.io client!"
  s.description = "A simple client for sending http post requests"
  s.authors     = ["SocialChorus", "Deepti Anand", "Roy Pfaffman"]
  s.email       = 'developers@socialchorus.com'
  s.files       = ["lib/simple_fanout.rb"]
  s.homepage    = 'http://rubygems.org/gems/simple_fanout'
  s.license     = 'MIT'

  s.files = Dir["lib/**/*", "MIT-LICENSE", "README.rdoc"]

  s.add_dependency 'jwt'
  s.add_dependency 'rest-client'

  s.add_development_dependency 'rspec'
end