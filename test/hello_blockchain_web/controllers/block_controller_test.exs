defmodule HelloBlockchainWeb.BlockControllerTest do
  use HelloBlockchainWeb.ConnCase

  alias HelloBlockchain.Blockchain

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:block) do
    {:ok, block} = Blockchain.create_block(@create_attrs)
    block
  end

  describe "index" do
    test "lists all blocks", %{conn: conn} do
      conn = get conn, block_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Blocks"
    end
  end

  describe "new block" do
    test "renders form", %{conn: conn} do
      conn = get conn, block_path(conn, :new)
      assert html_response(conn, 200) =~ "New Block"
    end
  end

  describe "create block" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, block_path(conn, :create), block: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == block_path(conn, :show, id)

      conn = get conn, block_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Block"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, block_path(conn, :create), block: @invalid_attrs
      assert html_response(conn, 200) =~ "New Block"
    end
  end

  describe "edit block" do
    setup [:create_block]

    test "renders form for editing chosen block", %{conn: conn, block: block} do
      conn = get conn, block_path(conn, :edit, block)
      assert html_response(conn, 200) =~ "Edit Block"
    end
  end

  describe "update block" do
    setup [:create_block]

    test "redirects when data is valid", %{conn: conn, block: block} do
      conn = put conn, block_path(conn, :update, block), block: @update_attrs
      assert redirected_to(conn) == block_path(conn, :show, block)

      conn = get conn, block_path(conn, :show, block)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, block: block} do
      conn = put conn, block_path(conn, :update, block), block: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Block"
    end
  end

  describe "delete block" do
    setup [:create_block]

    test "deletes chosen block", %{conn: conn, block: block} do
      conn = delete conn, block_path(conn, :delete, block)
      assert redirected_to(conn) == block_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, block_path(conn, :show, block)
      end
    end
  end

  defp create_block(_) do
    block = fixture(:block)
    {:ok, block: block}
  end
end
