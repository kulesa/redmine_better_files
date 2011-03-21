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
end

