require 'delayed_job'

config.after_initialize do
  # fix for yaml serialization 
  YAML.add_domain_type("ActiveRecord,2008", "") do |type, val| 
    klass = type.split(':').last.constantize 
    YAML.object_maker(klass, val) 
  end 
  class ActiveRecord::Base 
    def to_yaml_type 
      "!ActiveRecord,2008/#{self.class}" 
    end 
  end 
  class ActiveRecord::Base 
    def to_yaml_properties 
      ['@attributes'] 
    end 
  end

  Delayed::Worker.backend = :active_record
  Delayed::Worker.destroy_failed_jobs = false
  Delayed::Worker.sleep_delay = 60
  Delayed::Worker.max_attempts = 3
end