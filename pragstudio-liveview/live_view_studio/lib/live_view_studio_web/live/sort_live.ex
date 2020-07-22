defmodule LiveViewStudioWeb.SortLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Donations

  @default_page 1
  @default_per_page 10
  @per_page_options [5, 10, 15, 20]

  @def_sort_by :id
  @def_sort_order :asc

  def mount(_params, _session, socket) do
    socket = assign(socket, per_page_options: @per_page_options)
    {:ok, socket, temporary_assigns: [donations: []]}
  end

  ### EVENTS ###

  def handle_params(params, _url, socket) do
    #IO.puts "--> handle_params:params: #{inspect params}"

    # PAGINATION FROM PARAMS
    page = String.to_integer(params["page"] || "#{@default_page}")
    per_page = String.to_integer(params["per_page"] || "#{@default_per_page}")

    # SORTING FROM PARAMS
    sort_by = (params["sort_by"] || "#{@def_sort_by}") |> String.to_atom
    sort_order = (params["sort_order"] || "#{@def_sort_order}") |> String.to_atom

    # OPTIONS FOR QUERY AND ASSIGNS
    paginate_options = %{page: page, per_page: per_page}
    sort_options = %{sort_by: sort_by, sort_order: sort_order}

    donations = Donations.list_donations(
      paginate: paginate_options,
      sort: sort_options
    )
    socket = assign(socket,
      options: Map.merge(paginate_options, sort_options),
      donations: donations
    )
    {:noreply, socket}
  end

  def handle_event("update_per_page", %{"per_page" => per_page}, socket) do
    #IO.puts "--> update_per_page:per_page: #{inspect per_page}"
    per_page = String.to_integer(per_page)

    # Always send back to page 1 after changing per_page
    socket = push_patch(socket,
      to: Routes.live_path(socket, __MODULE__,
        page: 1,
        per_page: per_page,
        sort_by: socket.assigns.options.sort_by,
        sort_order: socket.assigns.options.sort_order
      )
    )
    {:noreply, socket}
  end

  ### HELPERS ###

  defp sort_link(socket, sort_by_header, sort_by_atom, options) do
    sort_by_header =
      if sort_by_atom == options.sort_by do
        sort_by_header <> sort_pointer(options.sort_order)
      else
        sort_by_header
      end

    live_patch sort_by_header,
               to: Routes.live_path(socket, __MODULE__,
                 page: options.page,
                 per_page: options.per_page,
                 sort_by: sort_by_atom,
                 sort_order: (if options.sort_order == :asc && options.sort_by == sort_by_atom, do: :desc, else: :asc)
               )
  end

  defp sort_pointer(:asc), do: " 👆"
  defp sort_pointer(:desc), do: " 👇"

  defp expires_class(donation) do
    if Donations.almost_expired?(donation), do: "eat-now", else: "fresh"
  end

end