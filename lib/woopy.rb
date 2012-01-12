require 'rubygems'
require 'bundler/setup'

require 'active_resource'

require 'woopy/version'
require 'woopy/client'
require 'woopy/resource'
require 'woopy/user'
require 'woopy/account'
require 'woopy/employment'

def Woopy(options = {})
  Woopy::Client.new(options)
end
