defmodule StackTest do
  use ExUnit.Case
  doctest Stack

  test "start_link default state" do

    {:ok, pid} = Stack.start_link([])
    assert Stack.start_link()
  end
end
