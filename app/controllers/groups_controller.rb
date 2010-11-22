class GroupsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]  
  attr_reader :per_page

  def index
  @search = Group.search(params[:search])
  @groups = @search.paginate(:page => params[:page], :per_page => 5)
  end
  
  def show
  @group = Group.find(params[:id])
  @users = @group.users
  end
  
  def new
      @group = Group.new
  end
  
  def create
      @group = Group.new(params[:group])
      if @group.save
	        @membership = @group.memberships.create(:user_id => current_user.id, :admin => true)
			if @membership.save
              redirect_to :action => 'show', :id => @group
			else
			  @group.delete
			  render :action => 'new'
			end
      else
            render :action => 'new'
      end
  end
  def edit
      @group = Group.find(params[:id])
  end  
  def update
      @group = Group.find(params[:id])
      if @group.update_attributes(params[:group])
         redirect_to :action => 'show', :id => @group
      else
         render :action => 'edit'
      end
  end
  def destroy
      @group = Group.find(params[:id])
	  @group.destroy
      redirect_to groups_path
  end
end
