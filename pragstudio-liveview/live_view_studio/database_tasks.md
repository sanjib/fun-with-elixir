# Database Tasks

**Kinokuniya Stores**

```console
mix phx.gen.context KinokuniyaStores KinokuniyaStore kinokuniya_stores address1:string, address2:string, city:string, state:string, zip:string, country:string, phone:string, opening_hours:string
mix ecto.migrate
mix ecto.reset
```

**Flights**

```console
mix phx.gen.context Flights Flight flights number:string origin:string destination:string departure_time:utc_datetime_usec arrival_time:utc_datetime_usec
mix ecto.migrate
mix ecto.reset
```

