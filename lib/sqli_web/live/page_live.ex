defmodule SqliWeb.PageLive do
  use SqliWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: %{})}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    IO.puts("search handle_event called!")

    case search(query) do
      {:ok, %Postgrex.Result{rows: rows}} ->
        {:noreply,
         assign(socket,
           results: Enum.into(rows, %{}, fn [name] -> {name, ""} end)
         )}

      match ->
        IO.inspect(match)

        {:noreply,
         socket
         |> put_flash(:error, "No dependencies found matching \"#{query}\"")
         |> assign(results: %{}, query: query)}
    end
  end

  defp search(query) do
    Sqli.Repo.query("SELECT name FROM users WHERE name = '#{query}'")
    |> IO.inspect()
  end
end
