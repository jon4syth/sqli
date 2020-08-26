defmodule Sqli.Repo.Migrations.WidgetTable do
  use Ecto.Migration

  def change do
    create table(:widget) do
      add :description, :string
      add :sku, :integer
    end
  end
end
