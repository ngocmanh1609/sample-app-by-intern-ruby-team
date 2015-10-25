# encoding: utf-8
# Microposts controller
class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  def index
    @microposts = current_user.microposts.hash_tree
  end

  def new
    @micropost = current_user.microposts.build(parent_id: params[:parent_id])
  end

  def create
    if params[:micropost][:parent_id].to_i > 0
      parent = current_user.microposts.find_by_id(params[:micropost].delete(:parent_id))
      @micropost = parent.children.build(micropost_params)
    else
      @micropost = current_user.microposts.build(micropost_params)
    end
    if @micropost.save
      flash[:success] = 'Micropost created!'
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'Micropost deleted'
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
