require 'spec_helper'

describe Admin::ProviderAccountsController do

  fixtures :all
  before(:each) do
    @cloud_account = Factory :mock_cloud_account
    @provider = @cloud_account.provider

    @admin_permission = Permission.create :role => Role.find(:first, :conditions => ['name = ?', 'Provider Administrator']),
                                          :permission_object => @provider,
                                          :user => Factory(:provider_admin_user)
    @admin = @admin_permission.user
    activate_authlogic
  end

  it "shows provider accounts as list" do
    UserSession.create(@admin)
    get :index, :provider_id => @provider.id
    response.should be_success
    response.should render_template("index")
  end

  it "allows test account validity on create when passing test_account param" do
    UserSession.create(@admin)
    post :create, :provider_id => @provider.id, :cloud_account => {}, :test_account => true
    response.should be_success
    response.should render_template("new")
    response.flash[:error].should == "Test Connection Failed: Invalid Account Details"
  end

  it "doesn't allow to save provider's account if not valid credentials" do
    UserSession.create(@admin)
    post :create, :provider_id => @provider.id, :cloud_account => {}
    response.should be_success
    response.should render_template("new")
    response.flash[:error].should == "The entered credential information is incorrect"
  end

  it "should permit users with account modify permission to access edit cloud account interface" do
    UserSession.create(@admin)
    get :edit, :id => @cloud_account.id
    response.should be_success
    response.should render_template("edit")
  end

  it "should allow users with account modify password to update a cloud account" do
    UserSession.create(@admin)

    @cloud_account.password = "foobar"
    @cloud_account.stub!(:valid_credentials?).and_return(true)
    @cloud_account.quota = Quota.new
    @cloud_account.save.should be_true

    post :update, :id => @cloud_account.id, :cloud_account => { :password => 'mockpassword' }
    response.should redirect_to admin_provider_account_path(@provider)
    CloudAccount.find(@cloud_account.id).password.should == "mockpassword"
  end

  it "should allow users with account modify permission to delete a cloud account" do
    UserSession.create(@admin)
    lambda do
      post :multi_destroy, :accounts_selected => [@cloud_account.id]
    end.should change(CloudAccount, :count).by(-1)
    response.should redirect_to admin_provider_accounts_url
    CloudAccount.find_by_id(@cloud_account.id).should be_nil
  end

  it "should deny access to users without account modify permission" do
    get :edit, :id => @cloud_account.id
    response.should_not be_success

    post :update, :id => @cloud_account.id, :cloud_account => { :password => 'foobar' }
    response.should_not be_success

    post :destroy, :id => @cloud_account.id
    response.should_not be_success
  end

  it "should provide ui to create new account" do
     UserSession.create(@admin)
     get :new, :provider_id => @provider.id
     response.should be_success
     response.should render_template("new")
  end

  it "should fail to grant access to account UIs for unauthenticated user" do
     get :new
     response.should_not be_success
  end

end
