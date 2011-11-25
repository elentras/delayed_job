autoload :ActiveRecord, 'active_record'

require File.dirname(__FILE__) + '/delayed/message_sending'
require File.dirname(__FILE__) + '/delayed/performable_method'
require File.dirname(__FILE__) + '/delayed/yaml_ext'
require File.dirname(__FILE__) + '/delayed/lifecycle'
require File.dirname(__FILE__) + '/delayed/plugin'
require File.dirname(__FILE__) + '/delayed/plugins/clear_locks'

require File.dirname(__FILE__) + '/delayed/backend/base'
require File.dirname(__FILE__) + '/delayed/worker'
require File.dirname(__FILE__) + '/delayed/deserialization_error'
require File.dirname(__FILE__) + '/delayed/railtie' if defined?(::Rails::Railtie)

Object.send(:include, Delayed::MessageSending)   
Module.send(:include, Delayed::MessageSending::ClassMethods)

if defined?(Merb::Plugins)
  Merb::Plugins.add_rakefiles File.dirname(__FILE__) / 'delayed' / 'tasks'
end
