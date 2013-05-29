require 'rubygems'
require 'bundler/setup'

require 'active_resource'

require 'woopy/version'
require 'woopy/client'
require 'woopy/demo'
require 'woopy/resource'
require 'woopy/user'
require 'woopy/account'
require 'woopy/role'
require 'woopy/employment'
require 'woopy/ownership'

def Woopy(options = {})
  Woopy::Client.new(options)
end
