defmodule LiveViewStudioWeb.PaginateLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Donations

  @default_page 1
  @default_per_page 10
  @per_page_options [5, 10, 15, 20]

  def mount(_params, _session, socket) do
#    paginate_options = %{page: @default_page, per_page: @default_per_page}
#    sort_options = %{sort_by: :id, sort_order: :asc}
#
#    donations = Donations.list_donations(
#      paginate: paginate_options,
#      sort: sort_options
#    )
#    socket = assign(socket,
#      options: paginate_options,
#      donations: donations
#    )
    socket = assign(socket, per_page_options: @per_page_options)

    {:ok, socket, temporary_assigns: [donations: []]}
  end

  ### EVENTS ###

  def handle_params(params, _url, socket) do
    IO.puts "--> handle_params:params: #{inspect params}"

    page = String.to_integer(params["page"] || "#{@default_page}")
    per_page = String.to_integer(params["per_page"] || "#{@default_per_page}")

    paginate_options = %{page: page, per_page: per_page}
    sort_options = %{sort_by: :id, sort_order: :asc}

    donations = Donations.list_donations(
      paginate: paginate_options,
      sort: sort_options
    )
    socket = assign(socket,
      options: paginate_options,
      donations: donations
    )
    {:noreply, socket}
  end

  def handle_event("update_per_page", %{"per_page" => per_page}, socket) do
    IO.puts "--> update_per_page:per_page: #{inspect per_page}"
    per_page = String.to_integer(per_page)

    # Always send back to page 1 after changing per_page
    socket = push_patch(socket,
      to: Routes.live_path(socket, __MODULE__, page: 1, per_page: per_page)
    )
    {:noreply, socket}
  end

  ### HELPERS ###

  defp expires_class(donation) do
    if Donations.almost_expired?(donation), do: "eat-now", else: "fresh"
  end

end