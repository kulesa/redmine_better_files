module RedmineBetterFiles
  module AttachmentPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        alias_method_chain :sanitize_filename, :context
      end
    end
  end

  module InstanceMethods
    def sanitize_filename_with_context(value)
       # This will return filename with included project name and issue number
      if self.container_type == "Issue"
        value = "#{project.name}_#{container.id}_#{value}"
      end

      sanitize_filename_without_context(value)
    end
  end
end
