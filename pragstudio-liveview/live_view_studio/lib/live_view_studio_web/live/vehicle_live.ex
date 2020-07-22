defmodule LiveViewStudioWeb.VehicleLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Vehicles

  @def_page 1
  @def_per_page 50
  @def_per_page_options [50, 100, 200]

  @def_sort_by :id
  @def_sort_order :asc

  def mount(_params, _session, socket) do
    # Count total vehicles in mount as it doesn't need to be updated on page change
    # or on occurrence of other events
    total_vehicles = Vehicles.count_vehicles()

    socket = assign(socket,
      total_vehicles: total_vehicles,
      per_page_options: @def_per_page_options
    )
    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "#{@def_page}")
    per_page = String.to_integer(params["per_page"] || "#{@def_per_page}")

    vehicles = Vehicles.list_vehicles(
      paginate: %{page: page, per_page: per_page},
      sort: %{sort_by: @def_sort_by, sort_order: @def_sort_order}
    )

    socket = assign(socket,
      vehicles: vehicles,
      options: %{page: page, per_page: per_page}
    )
    {:noreply, socket}
  end

  def handle_event("update_per_page", %{"per_page" => per_page}, socket) do
    per_page = String.to_integer(per_page)

    # Always default to page 1 on update_per_page
    socket = push_patch socket, to: (Routes.live_path socket, __MODULE__, page: 1, per_page: per_page)

    {:noreply, socket}
  end

  ### HELPERS ###

  defp paginate(socket, current_page, per_page, total_records) do
    for page_number <- 1..(total_records/per_page |> ceil) do
      if current_page == page_number do
        raw "<span class=\"current_page\">#{page_number}</span>"
      else
        live_patch "#{page_number} ", to: Routes.live_path(socket, __MODULE__, page: page_number, per_page: per_page)
      end
    end

  end
end