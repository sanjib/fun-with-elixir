# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LiveViewStudio.Repo.insert!(%LiveViewStudio.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias LiveViewStudio.Repo
alias LiveViewStudio.Boats.Boat
alias LiveViewStudio.KinokuniyaStores.KinokuniyaStore

%Boat{
  model: "1760 Retriever Jon Deluxe",
  price: "$",
  type: "fishing",
  image: "/images/boats/1760-retriever-jon-deluxe.jpg"
}
|> Repo.insert!()

%Boat{
  model: "1650 Super Hawk",
  price: "$",
  type: "fishing",
  image: "/images/boats/1650-super-hawk.jpg"
}
|> Repo.insert!()

%Boat{
  model: "1850 Super Hawk",
  price: "$$",
  type: "fishing",
  image: "/images/boats/1850-super-hawk.jpg"
}
|> Repo.insert!()

%Boat{
  model: "1950 Super Hawk",
  price: "$$",
  type: "fishing",
  image: "/images/boats/1950-super-hawk.jpg"
}
|> Repo.insert!()

%Boat{
  model: "2050 Authority",
  price: "$$$",
  type: "fishing",
  image: "/images/boats/2050-authority.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Deep Sea Elite",
  price: "$$$",
  type: "fishing",
  image: "/images/boats/deep-sea-elite.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Beneteau First 14",
  price: "$$",
  type: "sailing",
  image: "/images/boats/beneteau-first-14.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Beneteau First 24",
  price: "$$$",
  type: "sailing",
  image: "/images/boats/beneteau-first-24.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Beneteau Oceanis 31",
  price: "$$$",
  type: "sailing",
  image: "/images/boats/beneteau-oceanis-31.jpg"
}
|> Repo.insert!()

%Boat{
  model: "RS Quest",
  price: "$",
  type: "sailing",
  image: "/images/boats/rs-quest.jpg"
}
|> Repo.insert!()

%Boat{
  model: "RS Feva",
  price: "$",
  type: "sailing",
  image: "/images/boats/rs-feva.jpg"
}
|> Repo.insert!()

%Boat{
  model: "RS Cat 16",
  price: "$$",
  type: "sailing",
  image: "/images/boats/rs-cat-16.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Yamaha SX190",
  price: "$",
  type: "sporting",
  image: "/images/boats/yamaha-sx190.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Yamaha 212X",
  price: "$$",
  type: "sporting",
  image: "/images/boats/yamaha-212x.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Glastron GT180",
  price: "$",
  type: "sporting",
  image: "/images/boats/glastron-gt180.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Glastron GT225",
  price: "$$",
  type: "sporting",
  image: "/images/boats/glastron-gt225.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Yamaha 275E",
  price: "$$$",
  type: "sporting",
  image: "/images/boats/yamaha-275e.jpg"
}
|> Repo.insert!()

%Boat{
  model: "Yamaha 275SD",
  price: "$$$",
  type: "sporting",
  image: "/images/boats/yamaha-275sd.jpg"
}
|> Repo.insert!()

#_____________________
# KinokuniyaStores

%KinokuniyaStore {
  address1: "1073 Avenue of the Americas",
  address2: "",
  city: "New York",
  state: "NY",
  zip: "10018",
  country: "USA",
  phone: "+1 (212) 869-1700",
  opening_hours: "11:00am-6:00pm (daily)",
}
|> Repo.insert!()

%KinokuniyaStore {
  address1: "Mitsuwa Marketplace",
  address2: "595 River Road",
  city: "Edgewater",
  state: "NJ",
  zip: "07020",
  country: "USA",
  phone: "+1 (201) 496-6910",
  opening_hours: "10:00am-6:00pm (daily)",
}
|> Repo.insert!()

%KinokuniyaStore {
  address1: "Japan Center",
  address2: "1581 Webster Street",
  city: "San Francisco",
  state: "CA",
  zip: "94115",
  country: "USA",
  phone: "+1 (415) 567-7625",
  opening_hours: "10:30am - 6:00pm (Daily)",
}
|> Repo.insert!()

%KinokuniyaStore {
  address1: "Little Tokyo",
  address2: "123 Astronaut E. S. Onizuka Street",
  city: "Los Angeles",
  state: "CA",
  zip: "90012",
  country: "USA",
  phone: "+1 (213) 687-4480",
  opening_hours: "11:00am - 6:00pm (Daily) ",
}
|> Repo.insert!()

%KinokuniyaStore {
  address1: "391 Orchard Road",
  address2: "#04-20/20A/20B/20C/21",
  city: "Takashimaya S.C., Ngee Ann City",
  state: "",
  zip: "238872",
  country: "Singapore",
  phone: "+65 6737-5021",
  opening_hours: "Daily: 11am to 9pm",
}
|> Repo.insert!()

%KinokuniyaStore {
  address1: "200 Victoria Street",
  address2: "#03-09 Bugis Junction",
  city: "Singapore",
  state: "",
  zip: "188021",
  country: "Singapore",
  phone: "+65 6339-1790",
  opening_hours: "Daily - 11am to 9pm",
}
|> Repo.insert!()

%KinokuniyaStore {
  address1: "Lots 406-408 & 429-430, Level 4, Suria KLCC",
  address2: "Kuala Lumpur City Centre",
  city: "Kuala Lumpur",
  state: "",
  zip: "50088",
  country: "Malaysia",
  phone: "(+6) 03 - 2164 8133",
  opening_hours: "Monday - Sunday, 10AM - 10PM",
}
|> Repo.insert!()

%KinokuniyaStore {
  address1: "3rd Level Siam Paragon",
  address2: "991 Rama I Road, Pathumwan",
  city: "Bangkok",
  state: "",
  zip: "10330",
  country: "Thailand",
  phone: "Tel: +662 610 9500",
  opening_hours: "Daily - 10am to 10pm",
}
|> Repo.insert!()

%KinokuniyaStore {
  address1: "3rd Floor Unit 3B 01 EmQuartier Shopping Complex",
  address2: "689 Sukhumvit Road, Klongton Nua, Wattana",
  city: "Bangkok",
  state: "",
  zip: "10110",
  country: "Thailand",
  phone: "+662 003 6507",
  opening_hours: "Daily - 10am to 10pm",
}
|> Repo.insert!()

%KinokuniyaStore {
  address1: "Level 2, The Galeries",
  address2: "500 George Street (opposite QVB)",
  city: "Sydney",
  state: "NSW",
  zip: "2000",
  country: "Australia",
  phone: "+61 2 9262-7996",
  opening_hours: "Monday to Saturday: 10am – 7pm, Sunday: 10am – 6pm",
}
|> Repo.insert!()

%KinokuniyaStore {
  address1: "The Dubai Mall Level 2, SF-098",
  address2: "Financial Centre Road, Down Town Burj Khalifa",
  city: "Dubai",
  state: "",
  zip: "283578",
  country: "United Arab Emirates",
  phone: "+971-(0)-4-434-0111",
  opening_hours: "",
}
|> Repo.insert!()

%KinokuniyaStore {
  address1: "Plaza Senayan 5th Floor, Jalan Asia Afrika No.8,   ",
  address2: "",
  city: "Jakarta",
  state: "Pusat",
  zip: "10270",
  country: "Indonesia",
  phone: "+62-(0)21-57900022",
  opening_hours: "",
}
|> Repo.insert!()

%KinokuniyaStore {
  address1: "123 test street",
  address2: "",
  city: "dup",
  state: "test state",
  zip: "98765",
  country: "test country",
  phone: "+1234567890",
  opening_hours: "10:00 - 22:00 daily",
}
|> Repo.insert!()

%KinokuniyaStore {
  address1: "123 test street",
  address2: "",
  city: "test city",
  state: "test state",
  zip: "98765",
  country: "dup",
  phone: "+1234567890",
  opening_hours: "10:00 - 22:00 daily",
}
|> Repo.insert!()

%KinokuniyaStore {
  address1: "123 test street",
  address2: "",
  city: "dup",
  state: "test state",
  zip: "98765",
  country: "dup",
  phone: "+1234567890",
  opening_hours: "10:00 - 22:00 daily",
}
|> Repo.insert!()

