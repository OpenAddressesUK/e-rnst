require 'rubygems'
require 'bundler'
Bundler.require

ENV['RACK_ENV'] ||= 'development'

require File.join(File.dirname(__FILE__), 'lib/ernest.rb')

run Ernest
