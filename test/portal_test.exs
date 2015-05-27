defmodule PortalTest do
  use ExUnit.Case

  setup_all do
    Portal.shoot(:blue)
    orange_shot = Portal.shoot(:orange)
    {:ok, orange_shot: orange_shot}
  end

  setup do
    portal = Portal.transfer(:orange, :blue, [1,2,3,4])
    on_exit fn ->
    end
    {:ok, portal: portal}
  end

  test "shoot portals", context do
    orange_shot = context[:orange_shot]
    assert(List.first(Tuple.to_list(orange_shot))) == :ok
  end

  test "set up transfer between portals", context do
    portal = context[:portal]
    assert portal.left == :orange
    assert portal.right == :blue
  end

  test "set up data in left portal" do
    assert Portal.Door.get(:orange) == [4,3,2,1]
  end

  test "push data to the right", context do
    portal = context[:portal]
    Portal.push_right(portal)
    assert Portal.Door.get(:orange) == [3,2,1]
  end
end
