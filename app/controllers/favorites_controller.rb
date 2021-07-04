class FavoritesController < ApplicationController

  def create
    # ルートを指定するときにbook_idをURLに渡しているので、paramsでbook_idを受け取る。
    # 渡されたbook_idを持つレコードを扱うBookモデルのインスタンスを生成
    book = Book.find(params[:book_id])
    # current_userは現在ログインしているuserのidと同じ値を持つUsersテーブルのレコードを扱うUserモデルのインスタンスである。
    # そのUserモデルのインスタンスが持つfavoritesメソッドによって、先ほどのUsersテーブルのレコードが持つidと同じ値のuser_idを持つ
    # favoritesテーブルのレコードを扱う、favoriteモデルのインスタンスを生成する。
    # current_userでuser_idを指定し、引数でbook_idを指定している
    favorite = current_user.favorites.new(book_id: book.id)
    # データベースにパラメータを保存
    favorite.save
    # 遷移先はlink元のページのまま
    redirect_to request.referer
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_to request.referer
  end

end
