module RedmineBetterFiles
  module AttachmentsDownloadPatch
    def self.included(base)
      base.send(:include, InstanceMethods)

      base.class_eval do 
        alias_method_chain :download, :rename
      end
    end

    module InstanceMethods
      def download_with_rename
       if @attachment.container.is_a?(Version) || @attachment.container.is_a?(Project)
         @attachment.increment_download
       end
    
       filename = filename_for_content_disposition(@attachment.filename) 
       if @attachment.container_type == "Issue"
         filename = "#{@attachment.container.project.name}_#{@attachment.container.id}_#{@attachment.filename}"
       end
       
       # images are sent inline
       send_file @attachment.diskfile, :filename => filename,
                                      :type => detect_content_type(@attachment), 
                                      :disposition => (@attachment.image? ? 'inline' : 'attachment')

      end
    end
  end
end
