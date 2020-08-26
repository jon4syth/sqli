defmodule Sqli.WidgetContext.Widget do
  use Ecto.Schema
  import Ecto.Changeset

  schema "widgets" do
    field :description, :string
    field :sku, :integer

    timestamps()
  end

  @doc false
  def changeset(widget, attrs) do
    widget
    |> cast(attrs, [:desc, :sku])
    |> validate_required([:desc, :sku])
  end
end
