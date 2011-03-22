module ApplicationHelper

  def self.included(base)
    base.class_eval do 
      alias_method_chain :link_to_attachment, :download_name
    end
  end
  
  # Generates a link to an attachment.
  # Options:
  # * :text - Link text (default to attachment filename)
  # * :download - Force download (default: false)
  def link_to_attachment_with_download_name(attachment, options={})
    text = options.delete(:text) || attachment.filename
    action = options.delete(:download) ? 'download' : 'show'

    link_to(h(text), {:controller => 'attachments', :action => action, :id => attachment, :filename => attachment.download_name }, options)
  end

  # Generates string like 'Project1 >> Project2 >> Project3' with links to the projects
  def column_with_nested_projects(project)
      b = []
      ancestors = (project.root? ? [] : project.ancestors.visible)
      if ancestors.any?
        root = ancestors.shift
        b << link_to_project(root, {:jump => current_menu_item}, :class => 'root')
        if ancestors.size > 1
          b << '&#8230;'
          ancestors = ancestors[-1, 1]
        end
        b += ancestors.collect {|p| link_to_project(p, {:jump => current_menu_item}, :class => 'ancestor') }
      end
      b << link_to_project(project, {:jump => current_menu_item}, :class => 'ancestor') 
      b.join(' &#187; ')
  end
end

