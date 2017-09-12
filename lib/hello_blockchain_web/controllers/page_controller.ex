defmodule HelloBlockchainWeb.PageController do
  use HelloBlockchainWeb, :controller

  alias HelloBlockchain.Blockchain

  def index(conn, _params) do
    with {:ok, hash} <- Blockchain.getbestblockhash() do
      redirect(conn, to: header_path(conn, :show, hash))
    end
  end

end
