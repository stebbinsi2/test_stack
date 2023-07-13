defmodule Stack do
  @moduledoc """
  iex> {:ok, pid} = Stack.start_link([])
  iex> :ok = Stack.push(pid, 1)
  iex> Stack.pop(pid)
  1
  iex> Stack.pop(pid)
  nil
  """

  use GenServer

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, [])
  end

  def push(stack_pid, element) do
    GenServer.cast(stack_pid, {:push, element})
  end

  def pop(stack_pid) do
    GenServer.call(stack_pid, :pop)
  end

  # Define the necessary Server callback functions:
  @impl true
  def init(_arg) do
    {:ok, []}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end

  @impl true
  def handle_call(:pop, _from, state) do
    [head | tail] = state

    {:reply, head, tail}
  end
end
