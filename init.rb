require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare :redmine_better_files do 
  require_dependency 'attachments_controller'

  unless Attachment.included_modules.include? RedmineBetterFiles::AttachmentPatch
    Attachment.send(:include, RedmineBetterFiles::AttachmentPatch)
  end
  
  unless FilesController.included_modules.include? RedmineBetterFiles::FilesPaginationPatch
    FilesController.send(:include, RedmineBetterFiles::FilesPaginationPatch)
  end
  
end

Redmine::Plugin.register :redmine_better_files do
  name 'Redmine Better Files plugin'
  author 'Alexey Kuleshov'
  description 'This plugin improves Redmine Files and Attachments functinoality'
  version '0.0.1'
  url 'http://github.com/kulesa/redmine_better_files'
  author_url 'http://github.com/kulesa'
end
