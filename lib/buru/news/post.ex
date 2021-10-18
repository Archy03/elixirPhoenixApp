defmodule Buru.News.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Buru.News.{Comment, Category}

  schema "posts" do
    field :body, :string
    field :title, :string
    has_many  :comments, Comment
    belongs_to :category, Category
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :category_id])
    |> validate_required([:title, :body, :category_id])
  end
end
