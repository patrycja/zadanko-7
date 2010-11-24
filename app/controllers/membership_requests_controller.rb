class MembershipRequestsController < ApplicationController
before_filter :authenticate_user!

def new
   @request = MembershipRequest.new
end

def create
   @group = Group.find(params[:group_id])
   @request = @group.membership_requests.create(:user_id => current_user.id)
   if @request.save
      flash[:notice] = "Wyslano prosbe o dodanie do grupy"
      redirect_to :action => "show", :id => @group, :controller => "groups"
    else
      flash[:error] = "Nie dodamy cie do grupy, muahaha"
      redirect_to :action => "show", :id => @group, :controller => "groups"
    end  
end

def destroy
   @group = Group.find(params[:group_id])
   @request = @group.membership_requests.find(params[:id])
   @request.destroy
   redirect_to :action => "show", :id => @group, :controller => "groups"
end

end
