class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      

      @comment_new  = current_user.comments.build
    else
      @feed_items = Micropost.paginate(page: params[:page])
      #@comments = @feed_items.comments.paginate(page: params[:page], per_page: 5)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
