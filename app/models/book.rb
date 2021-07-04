class Book < ApplicationRecord

	# BookモデルとUserモデルをbelongs_toで関連付けしている。
	# :userはメソッド名であり、userメソッドを定義している。
	# userメソッドは、Userモデルのインスタンスを生成し、それを戻り値として返すメソッドである。
	belongs_to :user
	# BookモデルとFavoriteモデルをhas_manyで関連付けしている。
	# :favoritesはメソッド名であり、favoritesメソッドを定義している。
	# favoritesメソッドは、Favoriteモデルのインスタンスを生成し、それを戻り値として返すメソッドである。
	has_many :favorites, dependent: :destroy

	has_many :book_comments, dependent: :destroy

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	# Bookモデルクラスのインスタンスメソッド、favorited_by?メソッドを定義する
	# 上記の記述によりBookモデルクラスとfavoriteモデルクラスは関連付けされた。
	# 関連付けされたことによって、Bookモデルクラスにfavoritesメソッドが定義された。
	# favoritesメソッドは、Favoriteモデルクラスのインスタンスを生成し、それをを戻り値として返す。
	# favoritesメソッドによって生成したFavoriteモデルのインスタンスは、whereメソッドによって、
	# favoritesテーブルの中から、引数のidメソッドの戻り値idと同じ値のuser_idを持つ
	# レコードを見つけ、配列として返す。
	# exists?が、その配列内にレコードがあるかどうかの真偽値を返す。
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end


end
