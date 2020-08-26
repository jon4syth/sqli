defmodule SqliWeb.LightLive do
  use SqliWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :brightness, 10)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <h1>My Light</h1>
      <span style="width: <%= @brightness %>">
        <%= @brightness %>
      </span>

      <button phx-click="off">
      Off
      </button>

      <button phx-click="on">
      On
      </button>

      <button phx-click="up">
      Up
      </button>

      <button phx-click="down">
      Down
      </button>
    """
  end

  def handle_event("on", _, socket) do
    {:noreply, assign(socket, :brightness, 100)}
  end

  def handle_event("off", _, socket) do
    {:noreply, assign(socket, :brightness, 0)}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &(&1 + 10))
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &(&1 - 10))
    {:noreply, socket}
  end
end
