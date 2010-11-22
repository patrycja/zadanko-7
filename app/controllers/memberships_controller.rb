class MembershipsController < ApplicationController
before_filter :authenticate_user!

  def create
    @membership = current_user.memberships.build(:group_id => params[:group_id])
    if @membership.save
      flash[:notice] = "Dodano do grupy"
      redirect_to root_url
    else
      flash[:error] = "Nie mozna dodac do grupy."
      redirect_to root_url
    end
  end

  def destroy
    @membership = current_user.memberships.find(params[:id])
    @membership.destroy
    flash[:notice] = "Usunieto z grupy"
    redirect_to groups_path
  end

  def index
    @group = Group.find(params[:group_id])
  end
end
