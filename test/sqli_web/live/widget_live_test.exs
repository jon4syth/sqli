defmodule SqliWeb.WidgetLiveTest do
  use SqliWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Sqli.WidgetContext

  @create_attrs %{desc: "some desc", sku: 42}
  @update_attrs %{desc: "some updated desc", sku: 43}
  @invalid_attrs %{desc: nil, sku: nil}

  defp fixture(:widget) do
    {:ok, widget} = WidgetContext.create_widget(@create_attrs)
    widget
  end

  defp create_widget(_) do
    widget = fixture(:widget)
    %{widget: widget}
  end

  describe "Index" do
    setup [:create_widget]

    test "lists all widgets", %{conn: conn, widget: widget} do
      {:ok, _index_live, html} = live(conn, Routes.widget_index_path(conn, :index))

      assert html =~ "Listing Widgets"
      assert html =~ widget.desc
    end

    test "saves new widget", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.widget_index_path(conn, :index))

      assert index_live |> element("a", "New Widget") |> render_click() =~
               "New Widget"

      assert_patch(index_live, Routes.widget_index_path(conn, :new))

      assert index_live
             |> form("#widget-form", widget: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#widget-form", widget: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.widget_index_path(conn, :index))

      assert html =~ "Widget created successfully"
      assert html =~ "some desc"
    end

    test "updates widget in listing", %{conn: conn, widget: widget} do
      {:ok, index_live, _html} = live(conn, Routes.widget_index_path(conn, :index))

      assert index_live |> element("#widget-#{widget.id} a", "Edit") |> render_click() =~
               "Edit Widget"

      assert_patch(index_live, Routes.widget_index_path(conn, :edit, widget))

      assert index_live
             |> form("#widget-form", widget: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#widget-form", widget: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.widget_index_path(conn, :index))

      assert html =~ "Widget updated successfully"
      assert html =~ "some updated desc"
    end

    test "deletes widget in listing", %{conn: conn, widget: widget} do
      {:ok, index_live, _html} = live(conn, Routes.widget_index_path(conn, :index))

      assert index_live |> element("#widget-#{widget.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#widget-#{widget.id}")
    end
  end

  describe "Show" do
    setup [:create_widget]

    test "displays widget", %{conn: conn, widget: widget} do
      {:ok, _show_live, html} = live(conn, Routes.widget_show_path(conn, :show, widget))

      assert html =~ "Show Widget"
      assert html =~ widget.desc
    end

    test "updates widget within modal", %{conn: conn, widget: widget} do
      {:ok, show_live, _html} = live(conn, Routes.widget_show_path(conn, :show, widget))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Widget"

      assert_patch(show_live, Routes.widget_show_path(conn, :edit, widget))

      assert show_live
             |> form("#widget-form", widget: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#widget-form", widget: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.widget_show_path(conn, :show, widget))

      assert html =~ "Widget updated successfully"
      assert html =~ "some updated desc"
    end
  end
end
