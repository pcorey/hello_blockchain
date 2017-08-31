defmodule HelloBlockchain.BlockchainTest do
  use HelloBlockchain.DataCase

  alias HelloBlockchain.Blockchain

  describe "blocks" do
    alias HelloBlockchain.Blockchain.Block

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def block_fixture(attrs \\ %{}) do
      {:ok, block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blockchain.create_block()

      block
    end

    test "list_blocks/0 returns all blocks" do
      block = block_fixture()
      assert Blockchain.list_blocks() == [block]
    end

    test "get_block!/1 returns the block with given id" do
      block = block_fixture()
      assert Blockchain.get_block!(block.id) == block
    end

    test "create_block/1 with valid data creates a block" do
      assert {:ok, %Block{} = block} = Blockchain.create_block(@valid_attrs)
    end

    test "create_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blockchain.create_block(@invalid_attrs)
    end

    test "update_block/2 with valid data updates the block" do
      block = block_fixture()
      assert {:ok, block} = Blockchain.update_block(block, @update_attrs)
      assert %Block{} = block
    end

    test "update_block/2 with invalid data returns error changeset" do
      block = block_fixture()
      assert {:error, %Ecto.Changeset{}} = Blockchain.update_block(block, @invalid_attrs)
      assert block == Blockchain.get_block!(block.id)
    end

    test "delete_block/1 deletes the block" do
      block = block_fixture()
      assert {:ok, %Block{}} = Blockchain.delete_block(block)
      assert_raise Ecto.NoResultsError, fn -> Blockchain.get_block!(block.id) end
    end

    test "change_block/1 returns a block changeset" do
      block = block_fixture()
      assert %Ecto.Changeset{} = Blockchain.change_block(block)
    end
  end
end
