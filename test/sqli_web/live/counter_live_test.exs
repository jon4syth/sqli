defmodule SqliWeb.CounterLiveTest do
 use SqliWeb.ConnCase

 import Phoenix.LiveViewTest

 alias Sqli.CounterContext

 @create_attrs %{current_count: 0}
 @update_attrs %{current_count: 1}
 @invalid_attrs %{current_count: nil}

 defp fixture(:counter) do
  {:ok, counter} = CounterContext.create_counter(@create_attrs)
  counter
 end

 defp create_counter(_) do
  counter = fixture(:counter)
  %{counter: counter}
 end

 describe "Index" do
  setup [:create_counter]

  test "lists all counters", %{conn: conn, counter: counter} do
    {:ok, _index_live, html} = live(conn, Routes.counter_index_path(conn, :index))

    assert html =~ "Listing Counters"
    assert html =~ counter.current_count
  end

  test ""
 end
end
