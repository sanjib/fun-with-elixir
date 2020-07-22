defmodule LiveViewStudioWeb.VehicleLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Vehicles

  @def_page 1
  @def_per_page 50
  @per_page_options [50, 100, 200]

  @def_sort_by :id
  @def_sort_order :asc
  @sort_options %{
    "ID 1 to 9" => "id:asc",
    "ID 9 to 1" => "id:desc",
    "Make A to Z" => "make:asc",
    "Make Z to A" => "make:desc",
    "Model A to Z" => "model:asc",
    "Model Z to A" => "model:desc",
    "Color A to Z" => "color:asc",
    "Color Z to A" => "color:desc"
  }

  def mount(_params, _session, socket) do
    # Count total vehicles in mount as it doesn't need to be updated on page change
    # or on occurrence of other events
    total_vehicles = Vehicles.count_vehicles()

    socket = assign(socket,
      total_vehicles: total_vehicles,
      per_page_options: @per_page_options,
      sort_options: @sort_options
    )

    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "#{@def_page}")
    per_page = String.to_integer(params["per_page"] || "#{@def_per_page}")
    sort_by = (params["sort_by"] || "#{@def_sort_by}") |> String.to_atom
    sort_order = (params["sort_order"] || "#{@def_sort_order}") |> String.to_atom
    sort_select = Atom.to_string(sort_by) <> ":" <> Atom.to_string(sort_order)

    vehicles = Vehicles.list_vehicles(
      paginate: %{page: page, per_page: per_page},
      sort: %{sort_by: sort_by, sort_order: sort_order}
    )

    socket = assign(socket,
      vehicles: vehicles,
      options: %{page: page, per_page: per_page, sort_by: sort_by, sort_order: sort_order},
      sort_select: sort_select
    )

    {:noreply, socket}
  end

  def handle_event("update_per_page", %{"per_page" => per_page}, socket) do
    per_page = String.to_integer(per_page)

    # Always default to page 1 on update_per_page
    socket = push_patch socket,
                        to: (Routes.live_path socket, __MODULE__,
                                              page: 1,
                                              per_page: per_page,
                                              sort_by: socket.assigns.options.sort_by,
                                              sort_order: socket.assigns.options.sort_order
                          )

    {:noreply, socket}
  end

  def handle_event("sort", %{"sort" => sort}, socket) do
    #IO.puts "--> sort: #{inspect sort}"

    [sort_by, sort_order] = String.split(sort, ":")

    socket = push_patch socket,
                        to: (Routes.live_path socket, __MODULE__,
                                              page: socket.assigns.options.page,
                                              per_page: socket.assigns.options.per_page,
                                              sort_by: sort_by,
                                              sort_order: sort_order
                          )

    {:noreply, socket}
  end

  ### HELPERS ###

  defp paginate(socket, total_records, options) do
    current_page = options.page
    per_page = options.per_page

    for page_number <- 1..(total_records/per_page |> ceil) do
      if current_page == page_number do
        raw "<span class=\"current_page\">#{page_number}</span>"
      else
        live_patch "#{page_number} ",
                   to: Routes.live_path(socket, __MODULE__,
                     page: page_number,
                     per_page: per_page,
                     sort_by: options.sort_by,
                     sort_order: options.sort_order
                   )
      end
    end

  end
end