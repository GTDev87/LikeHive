require 'sunspot'
require 'mongoid'
require 'sunspot/rails'

# == Examples:
#
# class Post
#   include Mongoid::Document
#   field :title
# 
#   include Sunspot::Mongoid
#   searchable do
#     text :title
#   end
# end
#
module Sunspot
  module Mongoid
    def self.included(base)
      base.class_eval do
        extend Sunspot::Rails::Searchable::ActsAsMethods
        Sunspot::Adapters::DataAccessor.register(DataAccessor, base)
        Sunspot::Adapters::InstanceAdapter.register(InstanceAdapter, base)
      end
    end

    class InstanceAdapter < Sunspot::Adapters::InstanceAdapter
      def id
        @instance.id
      end
    end

    class DataAccessor < Sunspot::Adapters::DataAccessor
      def load(id)
        @clazz.find(id) rescue nil
      end

      def load_all(ids)
        bson_object_ids = []
        ids.each do |id|
          if BSON::ObjectId.legal?(id)
            bson_object_ids << BSON::ObjectId(id)
          end
        end
        
        # Find object using both id string and BSON::ObjectId initilized from id string
        @clazz.where(:_id.in => bson_object_ids + ids )
      end
    end
  end
end
