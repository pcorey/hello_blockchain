defmodule HelloBlockchain.Blockchain do
  @moduledoc """
  The Blockchain context.
  """

  import Ecto.Query, warn: false
  alias HelloBlockchain.Repo

  alias HelloBlockchain.Blockchain.Block

  defp bitcoind(command) do
    url = "http://bitcoinrpc:dae10a91212ab0423401b0f079e043ed@localhost:8332"
    headers = [{"Content-Type", "application/json"}]
    with {:ok, response} <- HTTPoison.post(url, Poison.encode!(command), headers),
         {:ok, body} <- Poison.decode(response.body),
         %{"error" => nil, "result" => result} <- body do
      {:ok, result}
    else
      %{"error" => error} -> {:error, error}
      _ -> {:error, :rpc_failure}
    end
  end

  def getinfo do
    bitcoind(%{
      jsonrpc: "1.0",
      id: "curltext",
      method: "getinfo",
      params: []
    })
  end

  def getblockhash(index) do
    bitcoind(%{
      jsonrpc: "1.0",
      id: "curltext",
      method: "getblockhash",
      params: [index]
    })
  end

  def getblock(hash) do
    bitcoind(%{
      jsonrpc: "1.0",
      id: "curltext",
      method: "getblock",
      params: [hash]
    })
  end

end
