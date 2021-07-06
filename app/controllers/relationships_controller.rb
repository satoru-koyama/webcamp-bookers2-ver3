class RelationshipsController < ApplicationController
  # フォロー機能を作成保存削除

  # 解説
  # Userモデルのインスタンスcurrent_userのインスタンスメソッドfollowを宣言し、paramsから:user_idの値を取得して、それをfollowメソッドの引数にする。
  # followメソッドによって、current_userの参照元のrelationshipsテーブルのレコードのカラムfollowed_idの値をparamsから:user_idの値にして、データベースに保存する。
  # 元のページにリダイレクトする。
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  # 解説
  # Userモデルのインスタンスcurrent_userのインスタンスメソッドunfollowを宣言し、paramsから:user_idの値を取得して、それをunfollowメソッドの引数にする。
  # unfollowメソッドによって、current_userの参照元のrelationshipsテーブルのレコードのカラムfollowed_idの値がparamsから:user_idの値のレコードを取得して、データベースから削除する。
  # 元のページにリダイレクトする。

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # フォロ―・フォロワー機能の追加

  # 解説
  # paramsから:user_idを取得して、usersテーブルのレコードの中からその値と:idが一致するレコードを取得しする。（そのレコードを扱えるモデルのインスタンスが生成される）
  # 生成したインスタンスをローカル変数userに代入する。
  # userのインスタンスメソッドfollowingsを宣言して、参照元のuserテーブルを取得する。（そのテーブルを扱えるモデルのインスタンスが生成される）
  # 生成したインスタンスをインスタンス変数@usersに代入する。
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

   # 解説
  # paramsから:user_idを取得して、usersテーブルのレコードの中からその値と同じ:idが一致するレコードを取得する。
  # 生成したインスタンスをローカル変数userに代入する。
  # userのインスタンスメソッドfollowersを宣言して、参照元のuserテーブルを取得する。
  # 生成したインスタンスをインスタンス変数@usersに代入する。
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
