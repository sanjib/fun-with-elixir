defmodule LiveViewStudioWeb.ServersLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Servers

  def mount(_params, _session, socket) do
    servers = Servers.list_servers()
    socket = assign(socket,
      servers: servers,
      selected_server: hd(servers)
    )

    # won't work with temporary_assigns
    # {:ok, socket, temporary_assigns: [servers: []]}
    {:ok, socket}
  end

  #_____________
  # EVENTS

  def handle_params(%{"id" => id}, _url, socket) do
    IO.puts "--> #{inspect id}"
    id = String.to_integer(id)
    server = Servers.get_server!(id)
    socket = assign(socket,
      page_title: server.name,
      selected_server: server,
    )
    {:noreply, socket}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  #_____________
  # HELPERS

  defp link_body(server) do
    assigns = %{name: server.name}

    ~L"""
    <img src="/images/server.svg">
    <%= @name %>
    """
  end

  #_____________
  # RENDER

  def render(assigns) do
    ~L"""
    <h1>Servers</h1>
    <div id="servers">
      <div class="sidebar">
        <nav>
          <%= for server <- @servers do %>
            <div>
              <%= live_patch link_body(server),
                    to: Routes.live_path(@socket, __MODULE__, id: server.id),
                    class: (if server == @selected_server, do: "active"),
                    replace: true #change the URL without polluting the browser's history
              %>
            </div>
          <% end %>
        </nav>
      </div>
      <div class="main">
        <div class="wrapper">
          <div class="card">
            <div class="header">
              <h2><%= @selected_server.name %></h2>
              <span class="<%= @selected_server.status %>">
                <%= @selected_server.status %>
              </span>
            </div>
            <div class="card-body">
              <div class="row">
                <div class="deploys">
                  <img src="/images/deploy.svg">
                  <span>
                    <%= @selected_server.deploy_count %> deploys
                  </span>
                </div>
                <span>
                  <%= @selected_server.size %> MB
                </span>
                <span>
                  <%= @selected_server.framework %>
                </span>
              </div>
              <h3>Git Repo</h3>
              <div class="repo">
                <%= @selected_server.git_repo %>
              </div>
              <h3>Last Commit</h3>
              <div class="commit">
                <%= @selected_server.last_commit_id %>
              </div>
              <blockquote>
                <%= @selected_server.last_commit_message %>
              </blockquote>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end