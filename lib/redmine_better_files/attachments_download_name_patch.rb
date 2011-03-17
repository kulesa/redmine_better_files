module RedmineBetterFiles
  module AttachmentsDownloadNamePatch
    def self.included(base)
      base.send(:include, InstanceMethods)

      base.class_eval do 
        alias_method_chain :find_project, :download_name
      end
    end

    module InstanceMethods
      # Do not raise exception if attachment download name is different
     def find_project_with_download_name
        @attachment = Attachment.find(params[:id])
        @project = @attachment.project
     end
    end
  end
end
