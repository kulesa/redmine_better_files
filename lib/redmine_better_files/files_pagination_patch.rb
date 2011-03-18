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
        
        # This should select attachments for current Project and Issues of current project
        basic_query = "attachments.id in (select a.id from attachments a left join projects p on (p.id = a.container_id) 
                                                             left join issues i on (i.id = a.container_id)
                                                             where (p.id = ? and a.container_type = 'Project') or 
                                                             (a.container_type = 'Issue' and i.project_id = ?))"
        
        @file_pages, @files = paginate :attachments, 
                              :conditions => [basic_query, @project.id, @project.id],
                              :order => sort_clause,
                              :per_page => per_page
        render :layout => !request.xhr?
      end
    end
  end
end
