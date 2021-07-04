class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy


　# 多対多の関係をリレーショナルデータベースでは直接表現できないので、中間テーブルを使って表現するのが一般的。
  # リレーショナルデータベースとは、行と列によって構成された「表形式のテーブル」と呼ばれるデータの集合を、互いに関連付けて関係モデルを使ったデータベースのこと。

　#＜解説＞
  # 参照先のusersテーブルと参照元のrelationshipsテーブルのアソシエーションをhas_manyメソッドによって宣言する。
  # それによって、参照先の主キー:idと参照元の外部キー:followed_idを対応させ、参照先の主キーから参照元の複数のレコードを取得できるようにする。
  # has_manyの関連名には参照元のモデル名を記述するが、今回は関連名をreverse_of_relationshipsにする。
  # 関連名がモデル名でないので、:class_nameを使ってモデル名を指定する必要がある。
  # relationshipsテーブルにある、userテーブルの外部キーのカラム名は、:user_idではなく、:followed_idである。
  # :モデル名_idではないため、:foreign_keyを使って外部キーを指定する必要がある。
  # dependent: :destroyでオーナーオブジェクトがdestroyされたときに関連付けされたオブジェクトをすべて同時にdestroyされる。
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

　#＜解説＞
  # 関連名reverse_of_relationshipsのアソシエーションで、中間テーブルの外部キーfollowed_idを参照先のusersテーブルの主キー:idと対応させた。
  # 関連名followerのアソシエーションで、中間テーブルの外部キーfollowed_idを参照元のusersテーブルの主キーと対応させた。
  # 参照先のusersテーブルと参照元のusersテーブルのアソシエーションをhas_many throughメソッドによって宣言する。
  # それによって、参照先の主キーと参照元の主キーを対応させ、参照先の主キーから参照元の複数のレコードを取得できるようにする。
  # has_manyの関連名には参照元のモデル名を記述するが、今回は関連名をfollowersにする。
  # through: には参照先と中間テーブルのアソシエーションの関連名を記述する。
  # 今回の場合だと、reverse_of_relationshipsを記述する。
  # source: には「ソース」の関連名を記述する。
  # 「ソース」とは主に情報の出どころ、出典、情報源のことを指します。
  # ここでの「ソース」は参照元のこと。つまり、参照元の主キーと対応させたアソシエーションの関連名を記述する。
  # 今回の場合だと、relationship.rbのアソシエーションで宣言された関連名を記述する。
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction,  length: { maximum: 50 }



  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user_id).destroy
  end

  def follwing?(user)
    follwings.include?(user)
  end

end
