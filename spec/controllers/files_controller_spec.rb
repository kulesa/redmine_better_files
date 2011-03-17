require File.dirname(__FILE__) + '/../spec_helper'

describe FilesController, '#index' do
  include Redmine::I18n
  integrate_views

  before(:all) do
    @tracker = Factory(:tracker)
    @project = Factory(:project)
    @project_attachment = Factory(:attachment, :container => @project)

    @issue = Factory(:issue, :project => @project, :tracker => @tracker)
    @issue_attachment = Factory(:attachment, :container => @issue)
  end

  before(:each) do
    @current_user = mock_model(User, :admin? => true, :logged? => true, :language => :en, :active? => true, :memberships => [], :anonymous? => false, :name => "A Test   >User", :projects => Project)
    User.stub!(:current).and_return(@current_user)
    @current_user.stub!(:allowed_to?).and_return(true)
    fake_pref = mock_model(Object)
    fake_pref.stub!(:save).and_return(true)
    @current_user.stub!(:preferences).and_return(fake_pref)
    @current_user.stub!(:time_zone).and_return(nil)
    projects = mock_model(Object)
    projects.stub!(:all).and_return([])
    @current_user.stub!(:projects).and_return(projects) # AGRHHHHH!

    Project.stub!(:find).and_return(@project)
  end

  it 'should be successful' do 
    get :index
    response.should be_success
  end

  it 'should display filename but provide link to download_name' do
    get :index
    response.should have_text(/#{@project_attachment.filename}/)
    response.should have_text(/#{@project_attachment.download_name}/)
  end
end
