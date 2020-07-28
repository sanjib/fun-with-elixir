defmodule LiveViewStudioWeb.ServersLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Servers
  alias LiveViewStudio.Servers.Server

  def mount(_params, _session, socket) do
    servers = Servers.list_servers()
    selected_server = if socket.assigns.live_action == :new, do: nil, else: hd(servers)
    changeset = Servers.change_server(%Server{})

    socket = assign(socket,
      servers: servers,
      selected_server: selected_server,
      changeset: changeset
    )

    # won't work with temporary_assigns
    # {:ok, socket, temporary_assigns: [servers: []]}
    {:ok, socket}
  end

  #_____________
  # PARAMS

  def handle_params(%{"id" => id}, _url, socket) do
    id = String.to_integer(id)
    server = Servers.get_server!(id)
    socket = assign(socket,
      page_title: server.name,
      selected_server: server
    )
    {:noreply, socket}
  end

  def handle_params(%{"name" => name}, _url, socket) do
    server = Servers.get_server_by_name(name)
    socket = assign(socket,
      page_title: server.name,
      selected_server: server
    )
    {:noreply, socket}
  end

  def handle_params(_params, _url, socket) do
    case socket.assigns.live_action do
      :new ->
        socket = assign(socket,
          selected_server: nil
        )
        {:noreply, socket}
      _ ->
        selected_server = hd(socket.assigns.servers)
        socket = assign(socket,
          selected_server: selected_server
        )
        {:noreply, socket}
    end
  end

  ### EVENTS ###

  def handle_event("save", %{"server" => params}, socket) do
    case Servers.create_server(params) do
      {:ok, server} ->
        socket = update(socket, :servers, fn servers -> [server | servers] end)
        changeset = Servers.change_server(%Server{})
        socket = assign(socket, changeset: changeset)
        socket = push_patch socket,
                            to: Routes.live_path(socket, __MODULE__,
                              name: server.name
                            )
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
    end
  end

  def handle_event("change", %{"server" => params}, socket) do
    IO.puts "--> params: #{inspect params}"

    #1 changeset
    changeset =
      %Server{}
      |> Servers.change_server(params)
      |> Map.put(:action, :insert)

    #2
    socket = assign(socket, changeset: changeset)

    {:noreply, socket}
  end
  
  ### LIVE PATH /servers/new ###

  def new(_params, _session, socket) do
    {:ok, socket}
  end

  #_____________
  # HELPERS

  defp link_body(server) do
    assigns = %{name: server.name, status: server.status}

    ~L"""
    <span class="status <%= @status %>"></span>
    <img src="/images/server.svg">
    <%= @name %>
    """
  end

end