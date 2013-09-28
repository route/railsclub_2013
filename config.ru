lib = File.expand_path('./')
$:.unshift lib unless $:.include?(lib)

require 'sinatra/base'
require 'application'

run Application
