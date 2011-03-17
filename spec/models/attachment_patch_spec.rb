require File.dirname(__FILE__) + '/../spec_helper'

describe 'Attachment Patch' do
  before(:all) do
    @tracker = Factory(:tracker)
    @project = Factory(:project)
    @issue = Factory :issue, :project => @project, :tracker => @tracker
    
    @project_attachment = Factory(:attachment, :container => @project)
    @issue_attachment   = Factory(:attachment, :container => @issue)
  end

  it 'should provide download filename for a project file' do 
    @project_attachment.download_name.should == "#{@project.name}_#{@project_attachment.filename}"
  end

  it 'should provide download filename for an issue attachment' do 
     @issue_attachment.download_name.should == "#{@project.name}_#{@issue.id}_#{@issue_attachment.filename}"
  end
end
