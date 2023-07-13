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

  # Client side API

  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  def push(stack_pid, element) do
    GenServer.cast(stack_pid, {:push, element})
  end

  def pop(stack_pid) do
    GenServer.call(stack_pid, :pop)
  end

  # Initializing the process

  @impl true
  def init(state) do
    {:ok, state}
  end

  # When given a push, this handle will take the element, and prepend it into state
  # This is asynchronous, so does not give a reply, just updates state with the element

  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end

  # When given a pop, it will take the head and tail of the list, respond with the the head, and the new
  # state is now just the tail. When at an empty list, returns nil

  @impl true
  def handle_call(:pop, _from, state) do
    case state do
      [] -> {:reply, nil, state}
      [head | tail] -> {:reply, head, tail}
    end
  end
end
