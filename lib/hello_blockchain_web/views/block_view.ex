defmodule HelloBlockchainWeb.BlockView do
  use HelloBlockchainWeb, :view

  # alias HelloBlockchainWeb.Endpoint
  # alias HelloBlockchainWeb.Router
  # alias Phoenix.HTML
  # alias Phoenix.HTML.Link

  defp hash_link(hash), do: "<a href='/#{hash}'>#{hash}</a>"

  # defp hash_link(hash) do
  #   Link.link(hash, to: Router.Helpers.block_path(Endpoint, :show, hash || ""))
  #   |> HTML.safe_to_string
  #   |> String.replace("\"", "", global: true)
  # end

  def mark_up_block(block) do
    block
    |> Map.replace("previousblockhash", hash_link(block["previousblockhash"]))
    |> Map.replace("nextblockhash", hash_link(block["nextblockhash"]))
    |> Poison.encode!(pretty: true)
  end

end
