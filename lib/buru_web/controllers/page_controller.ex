defmodule BuruWeb.PageController do
  use BuruWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
