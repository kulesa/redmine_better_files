require 'redmine'
require 'dispatcher'

Dir[File.join(directory,'vendor','plugins','*')].each do |dir|
  path = File.join(dir, 'lib')
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

Dispatcher.to_prepare :redmine_better_files do 
  require_dependency 'attachments_controller'

  unless Attachment.included_modules.include? RedmineBetterFiles::AttachmentPatch
    Attachment.send(:include, RedmineBetterFiles::AttachmentPatch)
  end
  
  unless FilesController.included_modules.include? RedmineBetterFiles::FilesPaginationPatch
    FilesController.send(:include, RedmineBetterFiles::FilesPaginationPatch)
  end

  unless AttachmentsController.included_modules.include? RedmineBetterFiles::AttachmentsDownloadNamePatch
    AttachmentsController.send(:include, RedmineBetterFiles::AttachmentsDownloadNamePatch)
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

require_dependency 'is_taggable'
