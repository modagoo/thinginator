require 'spec_helper'

  describe Collection do
    before(:each) do
    @user = FactoryGirl.build(:user)
  end

  it "should be valid" do
    @user.should be_valid
  end

  it "should retrieve name from The Square" do
    @user.save
    expect(@user.firstname).to eq("Paul")
    expect(@user.lastname).to eq("Groves")
  end

  it "should authenticate ISER users with master password" do
    expect(User.authenticate('pmgroves', MASTER_PASSWORD)).to be_true
  end

  it "should not authenticate non-ISER users with master password" do
    expect(User.authenticate('notaniserusername', MASTER_PASSWORD)).to be_false
  end

  it "should return a full name" do
    @user = FactoryGirl.create(:user, username: "pmgroves")
    expect(@user.fullname).to eq("Paul Groves")
  end

  it "should not destroy a superuser" do
    @user.superuser = true
    expect(@user.destroy).to be_false
  end

  it "should destroy a non-superuser" do
    @user.superuser = false
    expect(@user.destroy).to be_true
  end

  it "should not allow a non-unique username to be created" do
    @user.save
    non_unique_user = FactoryGirl.build(:user, username: "pmgroves")
    expect(non_unique_user).to have(1).errors_on(:username)
    expect(non_unique_user.errors_on(:username)).to include("has already been taken")
  end

  it "should check presence of username" do
    user = FactoryGirl.build(:user, username: nil)
    expect(user).to have(2).errors_on(:username)
    expect(user.errors_on(:username)).to include("can't be blank")
  end

  it "should not allow creation of non-ISER user" do
    user = FactoryGirl.build(:user, username: "notaniserusername")
    expect(user).to have(1).errors_on(:username)
    expect(user.errors_on(:username)).to include("is not an ISER member")
  end

end
