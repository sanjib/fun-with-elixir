defmodule LiveViewStudio.KinokuniyaStores do

  def list_by_country(country) do
    list_all
    |> Enum.filter(&(&1.country == country))
  end

  def list_by_country_fuzzy(country) do
    list_all
    |> Enum.filter(&(&1.country =~ ~r/#{country}/i))
  end

  def list_by_city(city) do
    :timer.sleep(2000)

    list_all
    |> Enum.filter(&(&1.city == city))
  end

  def list_by_city_fuzzy(city) do
    list_all
    |> Enum.filter(&(&1.city =~ ~r/#{city}/i))
  end

  def list_by_zip(zip) do
    :timer.sleep(2000)

    list_all
    |> Enum.filter(&(&1.zip == zip))
  end

  def list_all() do
    [
      %{
        address1: "1073 Avenue of the Americas",
        address2: "",
        city: "New York",
        state: "NY",
        zip: "10018",
        country: "USA",
        phone: "+1 (212) 869-1700",
        opening_hours: "11:00am-6:00pm (daily)",
      },
      %{
        address1: "Mitsuwa Marketplace",
        address2: "595 River Road",
        city: "Edgewater",
        state: "NJ",
        zip: "07020",
        country: "USA",
        phone: "+1 (201) 496-6910",
        opening_hours: "10:00am-6:00pm (daily)",
      },
      %{
        address1: "Japan Center",
        address2: "1581 Webster Street",
        city: "San Francisco",
        state: "CA",
        zip: "94115",
        country: "USA",
        phone: "+1 (415) 567-7625",
        opening_hours: "10:30am - 6:00pm (Daily)",
      },
      %{
        address1: "Little Tokyo",
        address2: "123 Astronaut E. S. Onizuka Street",
        city: "Los Angeles",
        state: "CA",
        zip: "90012",
        country: "USA",
        phone: "+1 (213) 687-4480",
        opening_hours: "11:00am - 6:00pm (Daily) ",
      },
      %{
        address1: "391 Orchard Road",
        address2: "#04-20/20A/20B/20C/21",
        city: "Takashimaya S.C., Ngee Ann City",
        state: "",
        zip: "238872",
        country: "Singapore",
        phone: "+65 6737-5021",
        opening_hours: "Daily: 11am to 9pm",
      },
      %{
        address1: "200 Victoria Street",
        address2: "#03-09 Bugis Junction",
        city: "Singapore",
        state: "",
        zip: "188021",
        country: "Singapore",
        phone: "+65 6339-1790",
        opening_hours: "Daily - 11am to 9pm",
      },
      %{
        address1: "Lots 406-408 & 429-430, Level 4, Suria KLCC",
        address2: "Kuala Lumpur City Centre",
        city: "Kuala Lumpur",
        state: "",
        zip: "50088",
        country: "Malaysia",
        phone: "(+6) 03 - 2164 8133",
        opening_hours: "Monday - Sunday, 10AM - 10PM",
      },
      %{
        address1: "3rd Level Siam Paragon",
        address2: "991 Rama I Road, Pathumwan",
        city: "Bangkok",
        state: "",
        zip: "10330",
        country: "Thailand",
        phone: "Tel: +662 610 9500",
        opening_hours: "Daily - 10am to 10pm",
      },
      %{
        address1: "3rd Floor Unit 3B 01 EmQuartier Shopping Complex",
        address2: "689 Sukhumvit Road, Klongton Nua, Wattana",
        city: "Bangkok",
        state: "",
        zip: "10110",
        country: "Thailand",
        phone: "+662 003 6507",
        opening_hours: "Daily - 10am to 10pm",
      },
      %{
        address1: "Level 2, The Galeries",
        address2: "500 George Street (opposite QVB)",
        city: "Sydney",
        state: "NSW",
        zip: "2000",
        country: "Australia",
        phone: "+61 2 9262-7996",
        opening_hours: "Monday to Saturday: 10am – 7pm, Sunday: 10am – 6pm",
      },
      %{
        address1: "The Dubai Mall Level 2, SF-098",
        address2: "Financial Centre Road, Down Town Burj Khalifa",
        city: "Dubai",
        state: "",
        zip: "283578",
        country: "United Arab Emirates",
        phone: "+971-(0)-4-434-0111",
        opening_hours: "",
      },
      %{
        address1: "Plaza Senayan 5th Floor, Jalan Asia Afrika No.8,   ",
        address2: "",
        city: "Jakarta",
        state: "Pusat",
        zip: "10270",
        country: "Indonesia",
        phone: "+62-(0)21-57900022",
        opening_hours: "",
      },
      %{
        address1: "123 test street",
        address2: "",
        city: "dup",
        state: "test state",
        zip: "98765",
        country: "test country",
        phone: "+1234567890",
        opening_hours: "10:00 - 22:00 daily",
      },
      %{
        address1: "123 test street",
        address2: "",
        city: "test city",
        state: "test state",
        zip: "98765",
        country: "dup",
        phone: "+1234567890",
        opening_hours: "10:00 - 22:00 daily",
      },
      %{
        address1: "123 test street",
        address2: "",
        city: "dup",
        state: "test state",
        zip: "98765",
        country: "dup",
        phone: "+1234567890",
        opening_hours: "10:00 - 22:00 daily",
      },
    ]
  end
end