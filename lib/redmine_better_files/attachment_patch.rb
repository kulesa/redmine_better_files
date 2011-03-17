module RedmineBetterFiles
  module AttachmentPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
    end
  end

  module InstanceMethods
    def download_name
      if self.container_type == "Project"
        "#{project.name}_#{filename}"
      elsif self.container_type == "Issue"
        "#{project.name}_#{container.id}_#{filename}"
      else
        filename
      end
    end
  end
end
