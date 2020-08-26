defmodule Sqli.WidgetContextTest do
  use Sqli.DataCase

  alias Sqli.WidgetContext

  describe "widgets" do
    alias Sqli.WidgetContext.Widget

    @valid_attrs %{desc: "some desc", sku: 42}
    @update_attrs %{desc: "some updated desc", sku: 43}
    @invalid_attrs %{desc: nil, sku: nil}

    def widget_fixture(attrs \\ %{}) do
      {:ok, widget} =
        attrs
        |> Enum.into(@valid_attrs)
        |> WidgetContext.create_widget()

      widget
    end

    test "list_widgets/0 returns all widgets" do
      widget = widget_fixture()
      assert WidgetContext.list_widgets() == [widget]
    end

    test "get_widget!/1 returns the widget with given id" do
      widget = widget_fixture()
      assert WidgetContext.get_widget!(widget.id) == widget
    end

    test "create_widget/1 with valid data creates a widget" do
      assert {:ok, %Widget{} = widget} = WidgetContext.create_widget(@valid_attrs)
      assert widget.desc == "some desc"
      assert widget.sku == 42
    end

    test "create_widget/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WidgetContext.create_widget(@invalid_attrs)
    end

    test "update_widget/2 with valid data updates the widget" do
      widget = widget_fixture()
      assert {:ok, %Widget{} = widget} = WidgetContext.update_widget(widget, @update_attrs)
      assert widget.desc == "some updated desc"
      assert widget.sku == 43
    end

    test "update_widget/2 with invalid data returns error changeset" do
      widget = widget_fixture()
      assert {:error, %Ecto.Changeset{}} = WidgetContext.update_widget(widget, @invalid_attrs)
      assert widget == WidgetContext.get_widget!(widget.id)
    end

    test "delete_widget/1 deletes the widget" do
      widget = widget_fixture()
      assert {:ok, %Widget{}} = WidgetContext.delete_widget(widget)
      assert_raise Ecto.NoResultsError, fn -> WidgetContext.get_widget!(widget.id) end
    end

    test "change_widget/1 returns a widget changeset" do
      widget = widget_fixture()
      assert %Ecto.Changeset{} = WidgetContext.change_widget(widget)
    end
  end
end
