# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Sqli.Repo.insert!(%Sqli.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Sqli.Repo.delete_all(Sqli.WidgetContext.Widget)

now = fn -> NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second) end
Sqli.Repo.insert_all(Sqli.WidgetContext.Widget, [
  [description: "Widget A", sku: 1, inserted_at: now.(), updated_at: now.()],
  [description: "Widget B", sku: 2, inserted_at: now.(), updated_at: now.()],
  [description: "Widget C", sku: 3, inserted_at: now.(), updated_at: now.()]
])
