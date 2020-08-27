defmodule Sqli.WidgetContext do
  @moduledoc """
  The WidgetContext context.
  """

  import Ecto.Query, warn: false
  alias Sqli.Repo


  @doc """
  Gets a single widget.

  Raises `Ecto.NoResultsError` if the Widget does not exist.

  ## Examples

      iex> get_widget!(123)
      %Widget{}

      iex> get_widget!(456)
      ** (Ecto.NoResultsError)

  """
  def get_widget_by!(sku: sku) do
    {:ok, %{columns: cols, rows: rows}} =
      Repo.query("SELECT w.id, w.description, w.sku FROM widgets w WHERE sku = #{sku}")
      |> IO.inspect(label: "WIDGET")

    cols = Enum.map(cols, &String.to_existing_atom/1)
    Enum.map(rows, fn row -> Enum.zip(cols, row) |> Map.new() end)
  end
  def get_widget_by!(_), do: []
end
