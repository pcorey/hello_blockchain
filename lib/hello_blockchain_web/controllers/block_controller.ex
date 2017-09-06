defmodule HelloBlockchainWeb.BlockController do
  use HelloBlockchainWeb, :controller

  alias HelloBlockchain.Blockchain
  alias HelloBlockchain.Blockchain.Block

  def index(conn, _params) do
    with {:ok, info} <- Blockchain.getinfo() |> IO.inspect,
         {:ok, hash} <- Blockchain.getblockhash(info["blocks"]) do
      redirect(conn, to: block_path(conn, :show, hash))
    end
  end

  def show(conn, %{"id" => hash}) do
    with {:ok, block} <- Blockchain.getblockheader(hash) do
      render(conn, "show.html", block: block)
    end
  end

end
