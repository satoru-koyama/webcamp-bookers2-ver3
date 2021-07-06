class Relationship < ApplicationRecord

  #＜解説＞
  # 参照先のusersテーブルと参照元のrelaionshipsテーブルのアソシエーションをbelongs_toメソッドによって宣言する。
  # それによって、参照先の主キーと参照元の外部キーfollower_idを対応させ、参照元の外部キーから参照先の一つのレコードを取得できるようにする。
  # belongs_toメソッドの関連名には参照先のモデル名を記述するが、今回は関連名をfollowerにする。
  # 関連名がモデル名でないので、:class_nameを用いてモデル名を指定する必要がある。
  # 外部キーを指定を行っていないが、follower_idを外部キーとして認識されていることから、関連名から自動的に推論されていると予想している。
  belongs_to :follower, class_name: "User"

  #＜解説＞
  # 参照先のusersテーブルと参照元のrelaionshipsテーブルのアソシエーションをbelongs_toメソッドによって宣言する。
  # それによって、参照先の主キーと参照元の外部キーfollowed_idを対応させ、参照元の外部キーから参照先の一つのレコードを取得できるようにする。
  # belongs_toメソッドの関連名には参照先のモデル名を記述するが、今回は関連名をfollowerにする。
  # 関連名がモデル名でないので、:class_nameを用いてモデル名を指定する必要がある。
  # 外部キーを指定を行っていないが、follower_idを外部キーとして認識されていることから、関連名から自動的に推論されていると予想している。
  belongs_to :followed, class_name: "User"

end
