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
                
        per_page = params[:per_page].nil? ? Setting.per_page_options_array.first : params[:per_page].to_i
 
        @file_pages, @files = paginate :attachments, 
                              :conditions => ["select count(a.id) from attachments a, issues i where (a.container_type = ? and a.container_id = ?) or (a.container_type = ? and i.id = a.container_id and i.project_id = ?)", 'Project', @project.id, 'Issue', @project.id],
                              :order => sort_clause,
                              :per_page => per_page
        render :layout => !request.xhr?
      end
    end
  end
end
