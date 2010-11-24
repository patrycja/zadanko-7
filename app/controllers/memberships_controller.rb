class MembershipsController < ApplicationController
before_filter :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    @membership = @group.memberships.build(:user_id => params[:user_id])
    if @membership.save
      flash[:notice] = "Dodano do grupy"
      redirect_to :action => "show", :id => @group, :controller => "groups"
    else
      flash[:error] = "Nie mozna dodac do grupy."
      redirect_to :action => "show", :id => @group, :controller => "groups"
    end
  end

  def destroy
    @membership = current_user.memberships.find(params[:id])
    @membership.destroy
    flash[:notice] = "Usunieto z grupy"
    redirect_to root_url
  end

  def index
    @group = Group.find(params[:group_id])
  end
end
