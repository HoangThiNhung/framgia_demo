class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create]
	before_action :correct_user,   only: :destroy

	def create
		@comment = current_user.comments.build(comment_params)
		@comment.micropost = Micropost.find(params[:micropost_id])

	    if @comment.save
	      flash[:success] = "Comment created!"
	      respond_to do |format|
		      format.html { redirect_to request.referrer || root_url }
		      format.js
		  end
	      # redirect_to request.referrer || root_url
	    else
	      @feed_items = []
	      render 'static_pages/home'
	    end
	end

	def destroy
  		@comment.destroy
	    flash[:success] = "Comment deleted"
	    redirect_to request.referrer || root_url
  	end

  	private

	    def comment_params
      		params.require(:comment).permit(:content, :user_id, :micropost_id)
    	end

	    def correct_user
	    	@comment = current_user.comments.find_by(id: params[:id])
	    	redirect_to root_url if @comment.nil?
	    end
end
