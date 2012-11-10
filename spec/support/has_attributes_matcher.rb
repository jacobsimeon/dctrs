module Dctrs
  module Matchers
    def have_initializable_attributes *attr_names
      InitializableAttributesMatcher.new attr_names
    end

    class InitializableAttributesMatcher
      def initialize attr_names
        @attr_names = attr_names
      end

      def matches? subject
        @attr_names.each do |attr_name|
          @subject = subject.class
          target = @subject.new attr_name => "some value"
          return false unless target.send(attr_name) == "some value"
        end
      end

      def failure_message
        "Expected #{@subject} to have basic attribute #{@attr_names}"
      end
    end

  end
end

module RSpec::Matchers
  include Dctrs::Matchers
end
