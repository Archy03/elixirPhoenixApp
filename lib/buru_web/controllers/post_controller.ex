defmodule BuruWeb.PostController do
  use BuruWeb, :controller

  alias Buru.News
  alias Buru.News.Post
  alias Buru.News.Comment
  alias Buru.News.Category
  alias Buru.Repo

  def index(conn, _params) do
    posts = News.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = News.change_post(%Post{})
    categories = Repo.all(Category) |> Enum.map(&{&1.title, &1.id})
    render(conn, "new.html", changeset: changeset, categories: categories)
  end

  def create(conn, %{"post" => post_params}) do
    case News.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        categories = Repo.all(Category) |> Enum.map(&{&1.title, &1.id})
        render(conn, "new.html", changeset: changeset, categories: categories)
    end
  end

  def show(conn, %{"id" => id}) do
    post =
        id
        |> News.get_post!
        |> Repo.preload([:comments])

    changeset = Comment.changeset(%Comment{}, %{})
    render(conn, "show.html", post: post, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    post = News.get_post!(id)
    changeset = News.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = News.get_post!(id)

    case News.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        categories = Repo.all(Category) |> Enum.map(&{&1.title, &1.id})
        render(conn, "edit.html", changeset: changeset, categories: categories)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = News.get_post!(id)
    {:ok, _post} = News.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end

  def add_comment(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    post =
      post_id
      |> News.get_post!()
      |> Repo.preload([:comments])
    case News.add_comment(post_id, comment_params) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Added comment!")
        |> redirect(to: Routes.post_path(conn, :show, post))
      {:error, _error} ->
        conn
        |> put_flash(:error, "Oops! Couldn't add comment!")
        |> redirect(to: Routes.post_path(conn, :show, post))
    end
  end

end
