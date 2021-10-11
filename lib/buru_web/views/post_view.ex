defmodule BuruWeb.PostView do
  use BuruWeb, :view
  alias Buru.News

	def get_comments_count(post_id) do
		News.get_number_of_comments(post_id)
	end
end
