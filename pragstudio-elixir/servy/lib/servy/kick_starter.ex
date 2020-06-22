defmodule Servy.KickStarter do
  use GenServer

  @name __MODULE__
  @http_server :http_server

  def start_link(_arg) do
    IO.puts "Starting Kick Starter..."
    GenServer.start_link(__MODULE__, :ok, name: @name)
  end

  def get_server_whereis() do
    Process.whereis(@http_server)
  end

  def get_server() do
    GenServer.call @name, :get_server
  end

  #_________________
  # Server callbacks

  def init(:ok) do
    Process.flag(:trap_exit, true)
    server_pid = start_server()
    {:ok, server_pid}
  end

  def handle_call(:get_server, _from, state) do
    {:reply, state, state}
  end

  def handle_info({:EXIT, _pid, reason}, _state) do
    IO.puts "HTTP Server exited: #{inspect reason}"
    server_pid = start_server()
    {:noreply, server_pid}
  end

  #____________
  # Helpers

  def start_server do
    IO.puts "Starting the HTTP Server..."
    server_pid = spawn Servy.HttpServer, :start, [4000]
    Process.link(server_pid)
    Process.register(server_pid, @http_server)
    server_pid
  end

end
