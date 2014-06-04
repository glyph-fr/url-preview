$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'url-preview/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'url-preview'
  s.version     = UrlPreview::VERSION
  s.authors     = ['Valentin Ballestrino']
  s.email       = ['vala@glyph.fr']
  s.homepage    = 'http://www.glyph.fr'
  s.summary     = 'Display previews of user entered URLs'
  s.description = 'Display previews of user entered URLs'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '>= 3.1'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'curb'

  s.add_development_dependency 'sqlite3'
end
