defmodule SqliWeb.WidgetLive.Show do
  use SqliWeb, :live_view

  def mount(%{"sku" => sku}, _context, socket) do
    socket = assign(socket, :widget, Sqli.WidgetContext.get_widget_by!(sku: sku))
    {:ok, socket}
  end
end
