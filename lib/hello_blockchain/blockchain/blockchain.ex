defmodule HelloBlockchain.Blockchain do
  import Ecto.Query, warn: false

  alias HelloBlockchain.Repo
  alias HelloBlockchain.Blockchain.Block

  defp bitcoind(command) do
    url = "http://bitcoinrpc:dae10a91212ab0423401b0f079e043ed@localhost:8332"
    body = %{jsonrpc: "1.0", params: []}
    |> Map.merge(command)
    |> Poison.encode!
    headers = [{"Content-Type", "application/json"}]
    with {:ok, response} <- HTTPoison.post(url, body, headers),
         {:ok, body} <- Poison.decode(response.body),
         %{"error" => nil, "result" => result} <- body do
      {:ok, result}
    else
      %{"error" => error} -> {:error, error}
      _ -> {:error, :jsonrpc_failure}
    end
  end

  def getinfo do
    bitcoind(%{method: "getinfo"})
  end

  def getblockhash(index) do
    bitcoind(%{method: "getblockhash", params: [index]})
  end

  def getblock(hash) do
    bitcoind(%{method: "getblock", params: [hash]})
  end

end
