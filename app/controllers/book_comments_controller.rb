class BookCommentsController < ApplicationController

  def create
    book_comment = BookComment.new(book_comment_params)
    book_comment.book_id = params[:book_id]
    book_comment.user_id = current_user.id
    book_comment.save
    redirect_to request.referer
  end

  def destroy
    book_comment = BookComment.find(params[:id])
    book_comment.destroy
    redirect_to request.referer
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
