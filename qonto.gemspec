# frozen_string_literal: true

$LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), 'lib'))

require 'qonto/version'

Gem::Specification.new do |s|
  s.name                  = 'qonto-api'
  s.version               = Qonto::VERSION
  s.required_ruby_version = '>= 2.7.1'
  s.date                  = '2020-10-18'
  s.summary               = 'Ruby SDK for Qonto API'
  s.authors               = ['Johan Le Bray']
  s.email                 = 'contact@jlebray.com'
  s.homepage              = 'https://rubygems.org/gems/qonto-api'
  s.license               = 'MIT'
  s.files                 = `git ls-files`.split("\n")
  s.test_files            = []
  s.executables           = []
  s.require_paths         = ['lib']
end
