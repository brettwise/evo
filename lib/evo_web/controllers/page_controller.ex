defmodule EvoWeb.PageController do
  use EvoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
