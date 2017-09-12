defmodule HelloBlockchainWeb.BlockController do
  use HelloBlockchainWeb, :controller

  alias HelloBlockchain.Blockchain

  def index(conn, _params) do
    with {:ok, hash} <- Blockchain.getbestblockhash() do
      redirect(conn, to: block_path(conn, :show, hash))
    end
  end

  def show(conn, %{"id" => hash}) do
    with {:ok, block} <- Blockchain.getblock(hash) do
      render(conn, "show.html", block: block)
    end
  end

end
