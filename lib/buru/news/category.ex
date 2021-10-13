defmodule Buru.News.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Buru.News.Post

  schema "categories" do
    field :title, :string
    has_many :posts, Post
    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
