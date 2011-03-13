module RedmineBetterFiles
  module FilesPaginationPatch
    def self.included(base)
      base.send(:include, InstanceMethods)

      base.class_eval do 
        alias_method_chain :index, :pagination
      end
    end

    module InstanceMethods
      # To allow pagination on files I have to refuse from Project Versions separation so far
      def index_with_pagination
        sort_init 'filename', 'asc'
        sort_update 'filename' => "#{Attachment.table_name}.filename",
                    'created_on' => "#{Attachment.table_name}.created_on",
                    'size' => "#{Attachment.table_name}.filesize",
                    'downloads' => "#{Attachment.table_name}.downloads"
                
        @file_pages, @files = paginate :attachments, :conditions => { :container_type => "Project", :container_id => @project.id},
                              :order => sort_clause
#        @containers = [ Project.find(@project.id, :include => :attachments, :order => sort_clause)]
#        @containers += @project.versions.find(:all, :include => :attachments, :order => sort_clause).sort.reverse
        render :layout => !request.xhr?
      end
    end
  end
end
