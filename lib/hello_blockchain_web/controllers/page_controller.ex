defmodule HelloBlockchainWeb.PageController do
  use HelloBlockchainWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
