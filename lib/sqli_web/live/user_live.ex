defmodule UserLive do
  use SqliWeb, :live_view

  def mount(params, session, socket) do
    {:ok, assign(socket, :key, :value)}
  end
end
