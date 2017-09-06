defmodule HelloBlockchain.Blockchain do

  def bitcoin_rpc(method, params \\ []) do
    with url <- Application.get_env(:hello_blockchain, :bitcoin_url),
         command <- %{jsonrpc: "1.0", method: method, params: params},
         {:ok, body} <- Poison.encode(command),
         {:ok, response} <- HTTPoison.post(url, body),
         {:ok, metadata} <- Poison.decode(response.body),
           %{"error" => nil, "result" => result} <- metadata do
      {:ok, result}
    else
      %{"error" => reason} -> {:error, reason}
    error -> error
    end
  end

  def getinfo, do: bitcoin_rpc("getinfo")

  def getblockhash(height), do: bitcoin_rpc("getblockhash", [height])

  def getblock(hash), do: bitcoin_rpc("getblock", [hash])

  def getblockheader(hash), do: bitcoin_rpc("getblockheader", [hash])

end
