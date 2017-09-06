defmodule HelloBlockchainWeb.PageController do
  use HelloBlockchainWeb, :controller

  alias HelloBlockchain.Blockchain
  alias HelloBlockchain.Blockchain.Block

  def index(conn, _params) do
    with {:ok, info} <- Blockchain.getinfo() |> IO.inspect,
         {:ok, hash} <- Blockchain.getblockhash(info["blocks"]) do
      redirect(conn, to: header_path(conn, :show, hash))
    end
  end

end
