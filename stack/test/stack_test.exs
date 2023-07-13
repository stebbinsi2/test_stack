defmodule StackTest do
  use ExUnit.Case
  doctest Stack

  test "start_link default state" do
    {:ok, pid} = Stack.start_link([])
    assert Stack.pop(pid) == nil
  end

  test "pop/1 removes one element from stack" do
    {:ok, pid} = Stack.start_link([1, 2, 3])
    assert Stack.pop(pid) == 1
    assert Stack.pop(pid) == 2
  end

  test "push/2 adds one element to empty stack" do
    {:ok, pid} = Stack.start_link([])
    Stack.push(pid, 1)
    Stack.pop(pid) == 1
  end

  test "push/2 adds one element to a stack with multiple elements" do
    {:ok, pid} = Stack.start_link([1, 2, 3])
    Stack.push(pid, 4)
    Stack.pop(pid) == 4
  end
end
